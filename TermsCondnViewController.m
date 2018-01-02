//
//  TermsCondnViewController.m
//  YesMakeOver
//
//  Created by Janmenjaya Rout on 23/12/17.
//  Copyright © 2017 Janmenjaya Rout. All rights reserved.
//

#import "TermsCondnViewController.h"

@interface TermsCondnViewController ()

@end

@implementation TermsCondnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self extraDesign];
    
    if (self.isFromLogin) {
        self.view.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.5];
    }else{
        
        self.shouldShowMenu = YES;
        [self designNavigationBarWithTitle:@"Terms & Conditions" withNavBarImage:@"" shouldShowBack:NO];

    }
    
    [self loadTermsConditions];
}

- (void)extraDesign
{

    self.btnClose.hidden = !self.isFromLogin;
    self.yRefWebView.constant = self.isFromLogin?24.0f:64.0f;
    
    self.btnClose.layer.cornerRadius = CGRectGetWidth(self.btnClose.frame)/2.0;
    self.btnClose.layer.borderWidth = 2.0f;
    self.btnClose.layer.borderColor = [UIColor colorWithWhite:1.0 alpha:0.5].CGColor;
    
    self.webVwTermsCond.layer.borderColor = [UIColor colorWithWhite:0.6 alpha:0.6].CGColor;
    self.webVwTermsCond.layer.borderWidth = 5.0f;
    self.webVwTermsCond.layer.masksToBounds = YES;
}

- (void)loadTermsConditions
{
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"terms" ofType:@"html"];
    NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    [self.webVwTermsCond loadHTMLString:htmlString baseURL: [[NSBundle mainBundle] bundleURL]];
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

- (IBAction)btnCloseClicked:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
