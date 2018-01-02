//
//  ViewController.h
//  YesMakeOver
//
//  Created by Janmenjaya Rout on 19/12/17.
//  Copyright © 2017 Janmenjaya Rout. All rights reserved.
//

#import "BaseViewController.h"
#import <MaterialComponents/MDCTextField.h>
#import <MaterialComponents/MDCFlatButton.h>
#import <MaterialComponents/MDCRaisedButton.h>
#import "MDCTextInputControllerDefault.h"

@interface ViewController : BaseViewController

@property (nonatomic, strong) MDCTextInputControllerDefault *fldMobileControllerFloating;
@property (nonatomic, strong) MDCTextInputControllerDefault *fldPasswordControllerFloating;

@property (weak, nonatomic) IBOutlet MDCTextField *fldMobile;
@property (weak, nonatomic) IBOutlet MDCTextField *fldPassword;
@property (weak, nonatomic) IBOutlet MDCRaisedButton *btnSubmit;
@property (weak, nonatomic) IBOutlet UIButton *btnTermsCheck;


- (IBAction)btnTermsOfUseClicked:(UIButton *)sender;

- (IBAction)btnSubmitClicked:(MDCRaisedButton *)sender;
- (IBAction)btnNewSignupClicked:(UIButton *)sender;
- (IBAction)btnForgotPasswordClicked:(UIButton *)sender;



