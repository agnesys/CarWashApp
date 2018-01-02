//
//  BaseViewController.m
//  YesMakeOver
//
//  Created by Janmenjaya Rout on 22/12/17.
//  Copyright © 2017 Janmenjaya Rout. All rights reserved.
//

#import "BaseViewController.h"
#import "SideMenuRootViewController.h"
#import <Firebase/Firebase.h>
#import <FirebaseAuth/FirebaseAuth.h>
#import "UIViewController+RESideMenu.h"
#import "GlobalConstants.h"
#import "AppDelegate.h"

@interface BaseViewController ()

@end

@implementation BaseViewController
@synthesize viewNavBar;
@synthesize shouldShowMenu;;
@synthesize vwContainerNavBar;
@synthesize lblNavTitle;
@synthesize customBgImg;
@synthesize lblNoData;
@synthesize btnMenu;
@synthesize inputAccView;
@synthesize imgVwBg;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)designNavigationBarWithTitle:(NSString *)title withNavBarImage:(NSString *)navBarImg shouldShowBack:(BOOL)shouldShowBack
{
    
    imgVwBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height)];
    
    if (self.customBgImg.length) {
        imgVwBg.image = [UIImage imageNamed:customBgImg];
    }else{
        imgVwBg.image = [UIImage imageNamed:@"bg_main"];
    }
    
    imgVwBg.backgroundColor = [UIColor clearColor];
    imgVwBg.userInteractionEnabled = YES;
    [self.view addSubview:imgVwBg];
    [self.view sendSubviewToBack:imgVwBg];
    
    vwContainerNavBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, 64)];
    vwContainerNavBar.backgroundColor = COLOR_BLUE_APP;
    [self.view addSubview:vwContainerNavBar];
    
    UIImageView *imgVwNav = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, 64)];
    
    //Override particualr image based on screen
    if (navBarImg.length) {
        imgVwNav.image = [UIImage imageNamed:navBarImg];
    }else{
        imgVwNav.image = [UIImage imageNamed:@"bg_info_on_nyum_top.png"];
    }
    
    imgVwNav.backgroundColor = [UIColor clearColor];
    imgVwNav.userInteractionEnabled = YES;
    imgVwNav.alpha = self.alphaForNavBar;
    [self.vwContainerNavBar addSubview:imgVwNav];
    
    viewNavBar = [[UIView alloc] initWithFrame:imgVwNav.frame];
    viewNavBar.backgroundColor = [UIColor clearColor];
    [self.vwContainerNavBar addSubview:viewNavBar];
    
    UIButton *btnBack = nil;
    if (shouldShowBack) {
        btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
        btnBack.frame = CGRectMake(10, 20, 44, 44);
        
        if (self.customBackImg.length) {
            [btnBack setImage:[UIImage imageNamed:_customBackImg] forState:UIControlStateNormal];
        }else{
            [btnBack setImage:[UIImage imageNamed:@"back_arrow.png"] forState:UIControlStateNormal];
        }
        
        [btnBack addTarget:self action:@selector(btnBackClicked:) forControlEvents:UIControlEventTouchUpInside];
        [viewNavBar addSubview:btnBack];
    }
    
    if (self.shouldShowMenu) {
        
        btnMenu = [UIButton buttonWithType:UIButtonTypeCustom];
        btnMenu.frame = CGRectMake(10, 20, 54, 44);
        
        [btnMenu setImage:[UIImage imageNamed:@"menu_icon.png"] forState:UIControlStateNormal];
//        [btnMenu addTarget:self action:@selector(presentRightMenuViewController:) forControlEvents:UIControlEventTouchUpInside];
        [btnMenu addTarget:self action:@selector(presentLeftMenuViewController:) forControlEvents:UIControlEventTouchUpInside];
        [viewNavBar addSubview:btnMenu];
    }
    
    float xRefLblTitle = CGRectGetMaxX(btnBack.frame) + 5;
    
    lblNavTitle = [[UILabel alloc] initWithFrame:CGRectMake(xRefLblTitle, 20, (SCREEN_SIZE.width - 2*xRefLblTitle), 44)];
    lblNavTitle.backgroundColor = [UIColor clearColor];
    lblNavTitle.text = title;
    lblNavTitle.font = FONT_CONDENSED_BOLD(19);
    lblNavTitle.numberOfLines = 0;
    lblNavTitle.textColor = [UIColor whiteColor];
    lblNavTitle.textAlignment = NSTextAlignmentCenter;
    [viewNavBar addSubview:lblNavTitle];
}

//Override method
- (void)btnBackClicked:(UIButton *)sender
{
    if (_cameFromSideMenu) {
        // find a way to set content VC as nav controller before tab bar VC
        self.sideMenuViewController.contentViewController = ((SideMenuRootViewController *)self.sideMenuViewController).mainContentVC; //INSTANTIATE_VC(@"contentViewController");
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (UIImage *)imageResizeToFitDeviceWidth:(UIImage*)img
{
    float multiplier    = SCREEN_SIZE.width/img.size.width;
    
    float neededWidth   = img.size.width * multiplier;
    float neededHeight  = img.size.height * multiplier;
    
    CGSize newSize = CGSizeMake(neededWidth, neededHeight);
    
    CGFloat scale = [[UIScreen mainScreen]scale];
    /*You can remove the below comment if you dont want to scale the image in retina   device .Dont forget to comment UIGraphicsBeginImageContextWithOptions*/
    //UIGraphicsBeginImageContext(newSize);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, scale);
    [img drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)imageResizeToFitWidth:(float)imgVwWidth withImage:(UIImage*)img
{
    float multiplier    = imgVwWidth/img.size.width;
    
    float neededWidth   = img.size.width * multiplier;
    float neededHeight  = img.size.height * multiplier;
    
    CGSize newSize = CGSizeMake(neededWidth, neededHeight);
    
    CGFloat scale = [[UIScreen mainScreen]scale];
    /*You can remove the below comment if you dont want to scale the image in retina   device .Dont forget to comment UIGraphicsBeginImageContextWithOptions*/
    //UIGraphicsBeginImageContext(newSize);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, scale);
    [img drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


-(void) designNoDataWithTitle:(NSString *)title inController:(UIViewController *)viewController
{
    if (lblNoData) {
        [lblNoData removeFromSuperview];
        lblNoData = nil;
    }
    
    lblNoData = [[UILabel alloc] initWithFrame:CGRectMake(20, viewController.view.center.y - 80, [[UIScreen mainScreen] bounds].size.width-40, 60)];
    lblNoData.text = title;
    lblNoData.numberOfLines = 0;
    lblNoData.font = FONT_AVENIR_NEXT_ITALIC(20);
    lblNoData.textColor = [UIColor grayColor];
    lblNoData.textAlignment = NSTextAlignmentCenter;
    [viewController.view addSubview:lblNoData];
}

-(void) removeNoDataLabel
{
    if (lblNoData) {
        [lblNoData removeFromSuperview];
        lblNoData = nil;
    }
}


- (void)showAlertWithTitle:(NSString *)title withMessage:(NSString *)msg withButtonTitle:(NSString *)btnTitle
{
    
}

- (UIView *)createInputAccessoryViewWithCancelButton:(BOOL)shouldShow{
 
    inputAccView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, 44)];
    inputAccView.tintColor = [UIColor whiteColor];
    inputAccView.barTintColor = COLOR_ORANGE_APP;
    
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(resignKeyBoard)];
    
    UIBarButtonItem *flexiableItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:shouldShow?@selector(doneDidPressForKeyBoardToolBar):@selector(resignKeyBoard)];
    
    if (shouldShow) {
        [inputAccView setItems:[NSArray arrayWithObjects:cancel, flexiableItem, done, nil]];
    }else{
        [inputAccView setItems:[NSArray arrayWithObjects:flexiableItem, done, nil]];
    }
    
    
    return inputAccView;
}

- (void)resignKeyBoard
{
    [self.view endEditing:YES];
}

- (void)doneDidPressForKeyBoardToolBar
{
    //Over ride method 
}

- (NSString *)getStrinValueOfDate:(NSDate *)date withFormat:(NSString *)format
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:format];
    NSString *strDate = [df stringFromDate:date];
    
    return strDate;
}

- (NSDate *)getDateValueOfStringDate:(NSString *)strDate withFormat:(NSString *)format
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:format];
    NSDate *date = [df dateFromString:strDate];
    
    return date;
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
