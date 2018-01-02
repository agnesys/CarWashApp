//
//  TermsCondnViewController.h
//  YesMakeOver
//
//  Created by Janmenjaya Rout on 23/12/17.
//  Copyright © 2017 Janmenjaya Rout. All rights reserved.
//

#import "BaseViewController.h"

@interface TermsCondnViewController : BaseViewController

@property (nonatomic, assign) BOOL isFromLogin;
@property (weak, nonatomic) IBOutlet UIWebView *webVwTermsCond;
@property (weak, nonatomic) IBOutlet UIButton *btnClose;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *yRefWebView;


- (IBAction)btnCloseClicked:(UIButton *)sender;

@end
