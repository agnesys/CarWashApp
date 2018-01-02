//
//  AddComplainViewController.m
//  YesMakeOver
//
//  Created by Janmenjaya Rout on 30/12/17.
//  Copyright © 2017 Janmenjaya Rout. All rights reserved.
//

#import "AddComplainViewController.h"
#import "GlobalConstants.h"
#import "UserSelectionPopUp.h"
#import "AppDelegate.h"
#import "SelectionListBO.h"
#import "UserSession.h"
#import "APIManager.h"

static NSString *kVehicleNum = @"VehicleRegNo";

@interface AddComplainViewController ()<UserSelectionPopUpDelegate>
{
    UserSelectionPopUp *popUpFields;
}

@property (nonatomic, strong) SelectionListBO *objSelectedSubscrptn;

@end

@implementation AddComplainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.shouldShowMenu = NO;
    [self designNavigationBarWithTitle:@"Add Complain" withNavBarImage:@"" shouldShowBack:YES];

    [self extraDesign];
}

- (void)extraDesign
{
    self.viewSection.layer.shadowColor = [UIColor blackColor].CGColor;
    self.viewSection.layer.shadowRadius = 5.0f;
    self.viewSection.layer.shadowOffset = CGSizeMake(2, 2);
    self.viewSection.layer.shadowOpacity = 0.5;
    
    self.txtVwComplain.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.6];
    self.txtVwComplain.layer.shadowColor = [UIColor grayColor].CGColor;
    self.txtVwComplain.layer.shadowRadius = 2.0f;
    self.txtVwComplain.layer.shadowOffset = CGSizeMake(1, 1);
    self.txtVwComplain.layer.shadowOpacity = 0.5;
    self.txtVwComplain.layer.borderColor = [UIColor lightGrayColor].CGColor;
}

#pragma mark - Service Call -

- (void)registerComplainWithComplainDetails:(id)complain
{
    
    [APIManager registerComplainWithComplainDetails:complain withCompletion:^(NSError *err) {
        
        if (!err) {
            
            [ISMessages showCardAlertWithTitle:@"Success!!" message:@"Your complain has been posted successfully." duration:5 hideOnSwipe:YES hideOnTap:YES alertType:ISAlertTypeSuccess alertPosition:ISAlertPositionTop didHide:^(BOOL finished) {
                
            }];
            
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
    
    if (textField == _fldVehicleNo) {
        
        NSArray *arrLists = [self createSelectionListForVehicleNumbers];
        
        CGPoint p = [self.viewSection convertPoint:textField.frame.origin toView:self.view.window];
        
        [self showPopUpWithvalue:arrLists withTitle:kVehicleNum shouldBeMultiselect:NO withYPos:p.y + CGRectGetHeight(_fldVehicleNo.frame)];
        
        return NO;
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
#pragma mark - UITextView Delegate -
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    self.scrlView.contentInset = UIEdgeInsetsMake(0, 0, 216, 0);
    textView.inputAccessoryView = [self createInputAccessoryViewWithCancelButton:NO];
    
    return YES;
}

#pragma mark -

- (NSArray *)createSelectionListForVehicleNumbers{
    
    NSMutableArray *arrLists = [NSMutableArray new];
    
    NSArray *arrSubScriptions = [UserSession sharedInstance].currentUser.arrSubscription;
    
    [arrSubScriptions enumerateObjectsUsingBlock:^(SubscriptionBO * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        SelectionListBO *objSelection = [SelectionListBO new];
        objSelection.objectId = obj.subcriptionId;
        objSelection.title = obj.regNo;
        objSelection.isSelected = NO;
        
        [arrLists addObject:objSelection];
    }];
    
    return arrLists;
}

- (BOOL)isValidComplainForm
{
    BOOL isinvalid = YES;
    NSString *strInvalidMsg = @"";
    
    if (![self.fldVehicleNo.text length]) {
        
        strInvalidMsg = @"Please select vehicle";
        
    }else if (![self.txtVwComplain.text length]){
        
        strInvalidMsg = @"Please describe about the issue";
        
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
    
    if ([[objReference extraParam] isEqualToString:kVehicleNum]) {
        self.objSelectedSubscrptn = (SelectionListBO *)value;
        self.fldVehicleNo.text = self.objSelectedSubscrptn.title;
        
    }else{
        
    }
    
    [self dissmissPopUpViewAfterGettingValue:YES];
}

- (IBAction)buttonSubmitClicked:(MDCRaisedButton *)sender {
    
    if ([self isValidComplainForm]) {
        
        UserBO *currentUser = [UserSession sharedInstance].currentUser;
        NSString *strToday = [self getStrinValueOfDate:[NSDate date] withFormat:@"dd-MM-yyyy"];
        
        NSDictionary *param = @{@"customer_name":[UserSession sharedInstance].currentUser.customerName,
                                @"customer_id":currentUser.userId,
                                @"apartment_name":currentUser.apartmentName,
                                @"apartment_id":@"NA",
                                @"block":currentUser.blockName,
                                @"date":strToday,
                                @"complain":_txtVwComplain.text,
                                @"vehicle_no":_fldVehicleNo.text,
                                @"assigned_to":@"NA",
                                @"status":@"New"
                                };
        
        [self registerComplainWithComplainDetails:param];
    }
    
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
