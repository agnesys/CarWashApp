//
//  AddComplainPopUpVC.m
//  YesMakeOver
//
//  Created by Janmenjaya Rout on 26/12/17.
//  Copyright © 2017 Janmenjaya Rout. All rights reserved.
//

#import "AddComplainPopUpVC.h"
#import "GlobalConstants.h"
#import "UserSelectionPopUp.h"
#import "AppDelegate.h"
#import "ApartmentBO.h"
#import "SelectionListBO.h"
#import "UserSession.h"
#import "APIManager.h"

static NSString *kApartment = @"Aprt";
static NSString *kBlock = @"Blck";

@interface AddComplainPopUpVC ()<UserSelectionPopUpDelegate>
{
    UserSelectionPopUp *popUpFields;
}

@property (nonatomic, strong) SelectionListBO *objSelectedAprtmnt;
@property (nonatomic, strong) SelectionListBO *objSelectedBlock;
@property (nonatomic, strong) UITextField *currentField;
@end

@implementation AddComplainPopUpVC
@synthesize delegate;
@synthesize objSelectedAprtmnt;
@synthesize objSelectedBlock;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.9];
    self.viewContainer.layer.cornerRadius = 5.0f;
    self.viewContainer.layer.masksToBounds = YES;
    
    self.btnApply.layer.cornerRadius = 20.0f;
    
    [self implementTapToDismissModalControllers];
}

- (void)implementTapToDismissModalControllers
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClicked:)];
    [self.view addGestureRecognizer:tap];
}

//Override this method for extra functionality
- (void)tapClicked:(UITapGestureRecognizer *)gesture
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - Service Call -

- (void)registerComplainWithComplainDetails:(id)complain
{
 
    [APIManager registerComplainWithComplainDetails:complain withCompletion:^(NSError *err) {
        
        if (!err) {

            if (self.delegate != nil && [self.delegate respondsToSelector:@selector(btnActionClicked:withOwner:)]) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.delegate btnActionClicked:self.btnApply withOwner:self];
                    [self dismissViewControllerAnimated:YES completion:nil];
                });
            }

        }else{
            
            [ISMessages showCardAlertWithTitle:@"Try Again!!" message:err.localizedDescription duration:5 hideOnSwipe:YES hideOnTap:YES alertType:ISAlertTypeError alertPosition:ISAlertPositionTop didHide:^(BOOL finished) {
                
            }];
        }
    }];
    
}
#pragma mark - UITextField Delegates -

// return NO to disallow editing.
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    self.scrlView.contentInset = UIEdgeInsetsMake(0, 0, 216, 0);
    self.currentField = textField;
    
    if (textField == _fldDateFrom) {
        textField.inputView = [self createDatePickerViewWithMaxDate:nil withMinDate:nil];
        textField.inputAccessoryView = [self createInputAccessoryViewWithCancelButton:NO];

    }else if (textField == _fldDateTo){
        NSDate *minDate = [self getDateValueOfStringDate:_fldDateFrom.text withFormat:@"dd-MM-yyyy"];
        textField.inputView = [self createDatePickerViewWithMaxDate:nil withMinDate:minDate];
        textField.inputAccessoryView = [self createInputAccessoryViewWithCancelButton:NO];

    }else if (textField == _fldApartment){
        
        NSArray *arrLists = [self createSelectionListForApartments];
        CGPoint p = [self.viewContainer convertPoint:textField.frame.origin toView:self.view.window];
        [self showPopUpWithvalue:arrLists withTitle:kApartment shouldBeMultiselect:NO withYPos:p.y + CGRectGetHeight(_fldApartment.frame)];
        
    }else if (textField == _fldBlock){
        NSArray *arrLists = [self createSelectionListFromApartmentBlock];
        CGPoint p = [self.viewContainer convertPoint:textField.center toView:self.view.window];
        [self showPopUpWithvalue:arrLists withTitle:kBlock shouldBeMultiselect:NO withYPos:p.y + CGRectGetHeight(_fldBlock.frame)];

    }else{
        
    }
    
    return YES;
}

// called when 'return' key pressed. return NO to ignore.
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
#pragma mark -

- (NSArray *)createSelectionListForApartments{
    
    NSMutableArray *arrLists = [NSMutableArray new];
    
    [APP_DELEGATE.arrAllApartments enumerateObjectsUsingBlock:^(ApartmentBO   * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        SelectionListBO *objSelection = [SelectionListBO new];
        objSelection.objectId = obj.aprtmntId;
        objSelection.title = obj.aprtmntName;
        objSelection.isSelected = NO;
        
        [arrLists addObject:objSelection];
    }];
    
    return arrLists;
}

- (NSArray *)createSelectionListFromApartmentBlock{
    if (self.objSelectedAprtmnt.objectId.length) {
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"aprtmntId MATCHES %@", self.objSelectedAprtmnt.objectId];
        ApartmentBO *objApartment = [[APP_DELEGATE.arrAllApartments filteredArrayUsingPredicate:pred] firstObject];
        NSArray *arrBlocks = [[objApartment.blocks stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] componentsSeparatedByString:@","];
        
        NSMutableArray *arrLists = [NSMutableArray new];
        
        for (NSString *strBlockName in arrBlocks) {
            
            if (![[strBlockName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]) {
                continue;
            }

            SelectionListBO *objSelection = [SelectionListBO new];
            objSelection.objectId = nil;
            objSelection.title = strBlockName;
            objSelection.isSelected = NO;
            
            [arrLists addObject:objSelection];
        }

        return arrLists;
    }else{
        return nil;
    }
}

#pragma mark - Accessory View -

- (UIView *)createDatePickerViewWithMaxDate:(NSDate *)maxDate withMinDate:(NSDate *)minDate
{
    UIView *viewDate = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, 216)];
    viewDate.backgroundColor = [UIColor whiteColor];
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:viewDate.bounds];
    datePicker.center = viewDate.center;
    datePicker.datePickerMode = UIDatePickerModeDate;
    if (maxDate) {
        datePicker.maximumDate = maxDate;
    }
    if (minDate) {
        datePicker.minimumDate = minDate;
    }
    [datePicker addTarget:self action:@selector(datePickerChanged:) forControlEvents:UIControlEventValueChanged];
    [viewDate addSubview:datePicker];
    
    return viewDate;
}

- (void)datePickerChanged:(UIDatePicker *)datePicker
{
    NSDate *date = datePicker.date;
    NSLog(@"date: %@", date);
    
    NSString *strSelectedDate = [self getStrinValueOfDate:datePicker.date withFormat:@"dd-MM-yyyy"];
    self.currentField.text = strSelectedDate;
}

#pragma mark - Buton Action Methods -
- (IBAction)btnCacelClicked:(MDCRaisedButton *)sender {
   
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];

}

- (IBAction)btnApplyClicked:(MDCRaisedButton *)sender {
    
    if ([self isValidComplainForm]) {
        
        NSDictionary *param = @{@"customer_name":[UserSession sharedInstance].currentUser.customerName,
                                @"customer_id":[UserSession sharedInstance].currentUser.userId,
                                @"date_from":self.fldDateFrom.text,
                                @"date_to":self.fldDateTo.text,
                                @"apartment_name":self.objSelectedAprtmnt.title,
                                @"apartment_id":self.objSelectedAprtmnt.objectId,
                                @"block":self.fldBlock.text};
        
        [self registerComplainWithComplainDetails:param];
    }
    
}

- (BOOL)isValidComplainForm
{
    BOOL isinvalid = YES;
    NSString *strInvalidMsg = @"";
    
    if (![self.fldDateFrom.text length]) {
        
        strInvalidMsg = @"Please select date from";
        
    }else if (![self.fldDateTo.text length]){
        
        strInvalidMsg = @"Please select date to";

    }else if (![self.fldApartment.text length]){
        
        strInvalidMsg = @"Please select apartment";
        
    }else if (![self.fldBlock.text length]){
        
        strInvalidMsg = @"Please select block";
        
    }else
    {
        isinvalid = NO;
    }
    
    if (isinvalid) {
        [ISMessages showCardAlertWithTitle:@"Invalid Complain!" message:strInvalidMsg duration:3 hideOnSwipe:YES hideOnTap:YES alertType:ISAlertTypeError alertPosition:ISAlertPositionTop didHide:^(BOOL finished) {
            
        }];
        
        return NO;
    }else{
        return YES;
    }

}

//MARK: - Custom PopUp fro Qr code -
- (void)showPopUpWithvalue:(NSArray *)arrValues withTitle:(NSString *)title shouldBeMultiselect:(BOOL)shouldMultiSelect withYPos:(float)yRef
{
    float yRefTemp = yRef;
    if (yRefTemp+250 > SCREEN_SIZE.height) {
        yRefTemp = yRef - 250;
    }
    
    popUpFields = [[UserSelectionPopUp alloc] initWithFrame:self.view.window.bounds withFrameforPopUp:CGPointMake(50, yRefTemp) withArray:arrValues isListType:YES withTitle:title];
    popUpFields.extraParam = title;
    popUpFields.callback = self;
    [popUpFields.btnDone setTitle:@"DONE" forState:UIControlStateNormal];
    [self.view.window addSubview:popUpFields];
}

#pragma mark - CustomPopUp Delegates -

-(void)dissmissPopUpViewAfterGettingValue:(BOOL)isValue
{
    [self.view endEditing:YES];
    
    popUpFields.callback = nil;
    
    if (popUpFields) {
        [popUpFields removeFromSuperview];
        popUpFields = nil;
    }
}

-(void)dissmissPopUpViewWithSelectedValue:(id)value withTag:(NSInteger)tag withOwner:(id)objReference
{
    NSLog(@"Selected Value %@",value);
    
    if ([[objReference extraParam] isEqualToString:kApartment]) {
        self.objSelectedAprtmnt = (SelectionListBO *)value;
        self.currentField.text = self.objSelectedAprtmnt.title;

    }else{
        self.objSelectedBlock = (SelectionListBO *)value;
        self.currentField.text = self.objSelectedBlock.title;

    }
    
    [self dissmissPopUpViewAfterGettingValue:YES];
}

#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
