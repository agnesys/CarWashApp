//
//  ViewController.m
//  YesMakeOver
//
//  Created by Janmenjaya Rout on 19/12/17.
//  Copyright © 2017 Janmenjaya Rout. All rights reserved.
//

#import "ViewController.h"
#import "GlobalConstants.h"
#import <Firebase.h>
#import "AppDelegate.h"
#import "UserSession.h"
#import "Utils.h"
#import "APIManager.h"
#import "UserSession.h"
#import "UserBO.h"
#import "TermsCondnViewController.h"

@interface ViewController () <UITextFieldDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self extraDesign];
}

- (void)extraDesign
{
    
    self.fldMobileControllerFloating = [[MDCTextInputControllerDefault alloc] initWithTextInput:_fldMobile];
    self.fldPasswordControllerFloating = [[MDCTextInputControllerDefault alloc] initWithTextInput:_fldPassword];
    
    self.fldMobileControllerFloating.activeColor = self.fldPasswordControllerFloating.activeColor = [UIColor orangeColor];
    
    [self.btnSubmit setTitle:@"SUBMIT" forState:UIControlStateNormal];
    [self.btnSubmit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    [self.btnSubmit setBackgroundColor:COLOR_ORANGE_APP forState:UIControlStateNormal];
    self.btnSubmit.inkColor = [UIColor colorWithWhite:0.7 alpha:1.0];
    
    
    UIImageView *imgVwMobile = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    imgVwMobile.contentMode = UIViewContentModeCenter;
    imgVwMobile.image = [UIImage imageNamed:@"call_icon.png"];
    
    UIImageView *imgVwPassword = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    imgVwPassword.contentMode = UIViewContentModeCenter;
    imgVwPassword.image = [UIImage imageNamed:@"password_icon.png"];

    UIButton *btnVwPasswordRight = [UIButton buttonWithType:UIButtonTypeCustom];
    btnVwPasswordRight.frame = CGRectMake(0, 0, 30, 30);
    [btnVwPasswordRight setImage:[UIImage imageNamed:@"preview_password.png"] forState:UIControlStateNormal];
    [btnVwPasswordRight addTarget:self action:@selector(btnPreviewPasswordClicked) forControlEvents:UIControlEventTouchUpInside];
    

    self.fldMobile.leftView = imgVwMobile;
    self.fldPassword.leftView = imgVwPassword;
    self.fldMobile.leftViewMode = UITextFieldViewModeAlways;
    self.fldPassword.leftViewMode = UITextFieldViewModeAlways;
    self.fldPassword.rightView = btnVwPasswordRight;
    self.fldPassword.rightViewMode = UITextFieldViewModeAlways;
    
}

- (void)loginAsAnonymousInFirebase
{
    [[FIRAuth auth]
     signInAnonymouslyWithCompletion:^(FIRUser *_Nullable user, NSError *_Nullable error) {
         
//         dispatch_async(dispatch_get_main_queue(), ^{
//             [APP_DELEGATE removeLoaderView];
//         });
         
         if (!error) {
             NSLog(@"successfully signed in anonymously");
             [UserSession sharedInstance].userID = kAnonymousUser;
             [Utils saveStringData:user.uid key:kUDanonymousUID];
             
             [self checkUserIsInTheUserListOrNotWithCompletion:^(UserBO *objUser, NSError *err) {
                 if (!error) {
                     
                     NSLog(@"[UserSession sharedInstance].currentUser: %@", [UserSession sharedInstance].currentUser);
                     
                     [self performSegueWithIdentifier:@"enterApp" sender:self];
                 }else{
                     [ISMessages showCardAlertWithTitle:@"Invalid Credential!" message:@"No user found with this credential. Please check again." duration:5 hideOnSwipe:YES hideOnTap:YES alertType:ISAlertTypeError alertPosition:ISAlertPositionTop didHide:^(BOOL finished) {
                         
                     }];
                 }
             }];
             

//             if (APP_DELEGATE.fromPushInfo == nil) {
//                 [self performSegueWithIdentifier:@"enterApp" sender:self];
//             } else {
//                 [self navigateToQuizOrNotifsAfterSegue];
//             }
             //                 }
         } else {
             NSLog(@"error: %@", error);
             [self showError];
         }
     }];
}


- (void)checkUserIsInTheUserListOrNotWithCompletion:(void(^)(UserBO *user, NSError *err))completion
{
    [APIManager checkTheUserWithMobNo:self.fldMobile.text withPassword:self.fldPassword.text isInTheCustomerListWithCompletion:^(UserBO *objUser, NSError *err) {
        
        if (!err) {
            completion(objUser, err);
        }else{
            completion(nil, err);
        }
    }];
}

- (void)showError
{
    NSLog(@"Anon Error");
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error logging in anonymously" message:APP_DELEGATE.isNetworkReachable?@"Please try again":TRY_AGAIN_NONETWORK_MSG preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Password Validation -
- (BOOL)validateAlphaNumericPasswordField
{
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^(?=.*[a-z])(?=.*\\d)[a-z\\d]*$"
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    NSArray *matches = [regex matchesInString:self.fldPassword.text
                                      options:0
                                        range:NSMakeRange(0, [self.fldPassword.text length])];
    
    if([matches count] > 0)
    {
        // Valid input
        return true;
    }
    else
    {
        return false;
    }
}

#pragma mark - UITextField Delegates -

// return NO to disallow editing.
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == _fldMobile) {
        textField.keyboardType = UIKeyboardTypePhonePad;
        
        textField.inputAccessoryView = [self createInputAccessoryViewWithCancelButton:NO];
    }
    
    return YES;
}

// became first responder
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

// return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}

// may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.fldPassword) {
        if ([self validateAlphaNumericPasswordField] && textField.text.length>=8) {
            //Valid
            
        }else{
            //Invalid Password
         
            [ISMessages showCardAlertWithTitle:@"Invalid Password!" message:@"Your password should be alpha numeric and minimum of 8 charecters" duration:5 hideOnSwipe:YES hideOnTap:YES alertType:ISAlertTypeError alertPosition:ISAlertPositionTop didHide:^(BOOL finished) {
                
            }];

        }
    }else if (textField.text.length != 10){
        
        [ISMessages showCardAlertWithTitle:@"Invalid Mobile Number!" message:@"Please enter valid mobile number" duration:5 hideOnSwipe:YES hideOnTap:YES alertType:ISAlertTypeError alertPosition:ISAlertPositionTop didHide:^(BOOL finished) {
            
        }];
    }
}

// return NO to not change text
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSLog(@"Length = %ld And Location = %ld", range.length, range.location);
    
    if (textField == _fldMobile) {
        if (range.length == 0 && range.location<10) {
            return YES;
        }
        else if (range.length == 1 && range.location < 10)
        {
            return YES;
        }
        else{
            return NO;
        }
    }
    return YES;
}

// called when clear button pressed. return NO to ignore (no notifications)
- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    return YES;
}

// called when 'return' key pressed. return NO to ignore.
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
#pragma mark - Button Action -

- (IBAction)btnTermsOfUseClicked:(UIButton *)sender {
    
    self.btnTermsCheck.selected = !self.btnTermsCheck.isSelected;
    
    APP_DELEGATE.isTermsCondnChecked = self.btnTermsCheck.isSelected;
  
    [[NSUserDefaults standardUserDefaults] setBool:self.btnTermsCheck.isSelected forKey:TERMS_CHECK_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];

    if (self.btnTermsCheck.isSelected) {
        
        TermsCondnViewController *termsPopUp = INSTANTIATE_SIDE_VC(@"TermsCondnVC");
        self.definesPresentationContext = YES; //self is presenting view controller
        termsPopUp.isFromLogin = YES;
        termsPopUp.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        
        [self presentViewController:termsPopUp animated:YES completion:^{
            
        }];

    }
}

- (IBAction)btnSubmitClicked:(MDCRaisedButton *)sender
{
    if (self.btnTermsCheck.isSelected) {
        [self.view endEditing:YES];
        
        if (([self validateAlphaNumericPasswordField] && _fldPassword.text.length>=8) && (_fldMobile.text.length == 10)) {
            
            [self loginAsAnonymousInFirebase];
        }else{
            NSLog(@"Validation failed");
        }

    }else{
        
        [ISMessages showCardAlertWithTitle:@"Accept Terms & Condition" message:@"Please check the terms & condition" duration:5 hideOnSwipe:YES hideOnTap:YES alertType:ISAlertTypeError alertPosition:ISAlertPositionTop didHide:^(BOOL finished) {
            
        }];
    }

}

- (IBAction)btnNewSignupClicked:(UIButton *)sender {
    
}

- (IBAction)btnForgotPasswordClicked:(UIButton *)sender {
    
}

- (void)btnPreviewPasswordClicked
{
    self.fldPassword.secureTextEntry = !self.fldPassword.isSecureTextEntry;
}

#pragma mark -

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
