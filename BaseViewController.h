//
//  BaseViewController.h
//  YesMakeOver
//
//  Created by Janmenjaya Rout on 22/12/17.
//  Copyright © 2017 Janmenjaya Rout. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalConstants.h"
#import "ISMessages.h"

@interface BaseViewController : UIViewController

@property (nonatomic, strong) UIView *vwContainerNavBar;
@property (nonatomic, strong) UIView *viewNavBar;
@property (nonatomic, assign) BOOL shouldShowMenu;
@property (nonatomic, assign) BOOL cameFromSideMenu;
@property (nonatomic, assign) float alphaForNavBar;
@property (nonatomic, strong) NSString *customBgImg;
@property (nonatomic, strong) NSString *customMenuImg_Normal;
@property (nonatomic, strong) NSString *customMenuImg_Selected;
@property (nonatomic, strong) NSString *customBackImg;
@property (nonatomic, strong) UILabel *lblNavTitle;
@property (strong,nonatomic) UIToolbar *inputAccView;

@property (nonatomic, strong) UILabel *lblNoData;
@property (nonatomic, strong) UIButton *btnMenu;
@property (nonatomic, strong) UIImageView *imgVwBg;

- (void)designNavigationBarWithTitle:(NSString *)title withNavBarImage:(NSString *)navBarImg shouldShowBack:(BOOL)shouldShowBack;

- (UIView *)createInputAccessoryViewWithCancelButton:(BOOL)shouldShow;
- (void)resignKeyBoard;

-(void) designNoDataWithTitle:(NSString *)title inController:(UIViewController *)viewController;
-(void) removeNoDataLabel;


- (UIImage *)imageResizeToFitDeviceWidth:(UIImage*)img;
- (UIImage *)imageResizeToFitWidth:(float)reqWidth withImage:(UIImage*)img;

- (void)btnBackClicked:(UIButton *)sender; // some of our VCs use this parent class method to auto navigate back (without user tapping back button)

- (NSString *)getStrinValueOfDate:(NSDate *)date withFormat:(NSString *)format;

- (NSDate *)getDateValueOfStringDate:(NSString *)strDate withFormat:(NSString *)format;

@end
