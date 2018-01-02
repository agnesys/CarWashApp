//
//  ComplainViewController.m
//  YesMakeOver
//
//  Created by Janmenjaya Rout on 23/12/17.
//  Copyright © 2017 Janmenjaya Rout. All rights reserved.
//

#import "ComplainViewController.h"
//#import "ComplainTableViewCell.h"
#import "CustComplainTableViewCell.h"
#import "ComplainBO.h"
#import "UIImageView+WebCache.h"
#import "MDCFeatureHighlightViewController.h"
#import <LGPlusButtonsView/LGPlusButtonsView.h>
#import "AppDelegate.h"
#import "AddComplainPopUpVC.h"
#import "AddComplainViewController.h"
#import "APIManager.h"

@interface ComplainViewController ()<LGPlusButtonsViewDelegate, AddComplainPopUpVCDelegate>
{
    LGPlusButtonsView *lgButton;
    AddComplainPopUpVC *complainPopUp;
}
@property (nonatomic, strong) NSMutableArray *arrComplains;
@end

@implementation ComplainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.shouldShowMenu = YES;
    [self designNavigationBarWithTitle:@"Complain" withNavBarImage:@"" shouldShowBack:NO];
    
    _arrComplains = [[NSMutableArray alloc] init];
    
    [self extraDesignAfterStoryboard];
    [self getAllComplainHistory];
}

- (void)getAllComplainHistory
{
    [APIManager fetchAllComplainsWithCompletion:^(NSArray *arrComplain, NSError *err) {
        
        [self.arrComplains addObjectsFromArray:arrComplain];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tblVwComplain reloadData];
        });
    }];
}

- (void)extraDesignAfterStoryboard
{
    _tblVwComplain.tableFooterView = [UIView new];

    [self designFloatingButton];
}

- (void)designFloatingButton
{
    
    lgButton = [[LGPlusButtonsView alloc] initWithNumberOfButtons:3 firstButtonIsPlusButton:YES showAfterInit:YES];
    lgButton.delegate = self;
    
    
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:lgButton.bounds];
    lgButton.layer.masksToBounds = NO;
    lgButton.layer.shadowColor = [UIColor blackColor].CGColor;
    lgButton.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
    lgButton.layer.shadowOpacity = 0.5f;
    lgButton.layer.shadowPath = shadowPath.CGPath;

    
    lgButton.coverColor = [UIColor colorWithWhite:0.0f alpha:0.7];
    lgButton.position = LGPlusButtonsViewPositionBottomRight;
    lgButton.center = APP_DELEGATE.window.center;
    lgButton.plusButtonAnimationType = LGPlusButtonAnimationTypeRotate;
    lgButton.buttonsAppearingAnimationType = LGPlusButtonsAppearingAnimationTypeCrossDissolveAndPop;
    
    [lgButton setButtonsSize:CGSizeMake(44.f, 44.f) forOrientation:LGPlusButtonsViewOrientationPortrait];
    [lgButton setButtonsLayerCornerRadius:44.f/2.f forOrientation:LGPlusButtonsViewOrientationPortrait];
    [lgButton setButtonsLayerBorderWidth:0.f];
    [lgButton setButtonsLayerBorderColor:[UIColor colorWithWhite:0.0 alpha:1.f]];
    
    [lgButton setButtonsTitles:@[@"", @"", @""] forState:UIControlStateNormal];
    
    [lgButton setButtonsImages:@[[UIImage imageNamed:@"sort_btn"], [UIImage imageNamed:@"custlist_add"], [UIImage imageNamed:@"custlist_filter"]]
                      forState:UIControlStateNormal
                forOrientation:LGPlusButtonsViewOrientationPortrait];
    

    [lgButton setButtonAtIndex:0 backgroundColor:[UIColor clearColor] forState:UIControlStateNormal];

    [lgButton setButtonAtIndex:1 backgroundColor:COLOR_BLUE_APP forState:UIControlStateNormal];
    
    [lgButton setButtonAtIndex:2 backgroundColor:COLOR_BLUE_APP forState:UIControlStateNormal];
    
    [self.view addSubview:lgButton];
}

#pragma mark -  Floating Button Delegate -
- (void)plusButtonsView:(LGPlusButtonsView *)plusButtonsView buttonPressedWithTitle:(NSString *)title description:(NSString *)description index:(NSUInteger)index
{
    if (index != 0) {
        [plusButtonsView hideButtonsAnimated:YES completionHandler:^{
            
        }];
    }
    
    switch (index) {
        case 1:{
            //Add Complain
            NSLog(@"Add");
            
            AddComplainViewController *addComplainVC = INSTANTIATE_SIDE_VC(@"AddComplainVC");
            [self.navigationController pushViewController:addComplainVC animated:YES];
            
            break;
        }
            
        case 2:{
            //Filter Complain
            NSLog(@"Filter");
            
            complainPopUp = INSTANTIATE_SIDE_VC(@"AddComplainPopUpVC");
            complainPopUp.delegate = self;
            self.definesPresentationContext = YES; //self is presenting view controller
            complainPopUp.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            
            [self presentViewController:complainPopUp animated:YES completion:^{
                
            }];

            break;
        }
            
        default:
            break;
    }
}

#pragma mark -

- (void)fillDummyComplainData
{
    NSArray *arrName        = @[@"Matt May", @"John Smith"];
    NSArray *arrImage       = @[@"https://pbs.twimg.com/profile_images/2945120343/cd5878e9bc2d29085b711bbb546a8da7.jpeg", @"https://colorlib.com/polygon/gentelella/images/img.jpg"];
    NSArray *arrTower       = @[@"Amber", @"Tower 1"];
    NSArray *arrApartment   = @[@"Eden Graden", @"Swan lakes"];
    NSArray *arrDate        = @[@"22 Jan 2017", @"27 Mar 2017"];
    NSArray *arrStatus      = @[@"New", @"In Progress"];
    
    for (int count = 0; count < [arrName count]; count ++) {
        
        ComplainBO *objComplain = [ComplainBO new];
        
        objComplain.imgUrl          = arrImage[count];
        objComplain.complainDate    = arrDate[count];
        objComplain.complainDesc    = arrDate[count];
        objComplain.complainStatus  = arrStatus[count];
        objComplain.assignedTo      = @"NA";
        
        [self.arrComplains addObject:objComplain];
    }
}

#pragma mark - UITableView Delegates -

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 77.0f;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 100.0f;
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return [self.arrComplains count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CustComplainCell";
    
    CustComplainTableViewCell *cell = (CustComplainTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    ComplainBO *objComplain = self.arrComplains[indexPath.row];
    
    cell.lblComplain.text       = objComplain.complainDesc;
    cell.lblDate.text           = objComplain.complainDate;
    cell.lblAssignedTo.text     = objComplain.assignedTo;
    cell.lblStatus.text         = objComplain.complainStatus;
        
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - Delegate -
- (void)btnActionClicked:(UIButton *)sender withOwner:(id)owner
{
    if (complainPopUp) {
        complainPopUp.delegate = nil;
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
