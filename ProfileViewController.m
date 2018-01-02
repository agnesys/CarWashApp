//
//  ProfileViewController.m
//  YesMakeOver
//
//  Created by Janmenjaya Rout on 23/12/17.
//  Copyright © 2017 Janmenjaya Rout. All rights reserved.
//

#import "ProfileViewController.h"
#import "CustomerSubcriptionCell.h"
#import "UserSession.h"
#import "APIManager.h"
#import "GlobalConstants.h"
#import "AppDelegate.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.shouldShowMenu = YES;
    [self designNavigationBarWithTitle:@"Profile" withNavBarImage:@"" shouldShowBack:NO];

    [self designAfterStoryboard];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self fetchAllApartments];
    });
}

- (void)fetchAllApartments
{
    [APIManager fetchAllApartmentsWithCompletion:^(NSArray *aprtmntList, NSError *err) {
        
        if ([APP_DELEGATE.arrAllApartments count]) {
            [APP_DELEGATE.arrAllApartments removeAllObjects];
        }
        
        [APP_DELEGATE.arrAllApartments addObjectsFromArray:aprtmntList];
    }];
}

- (void)designAfterStoryboard
{
    [self.btnMakePayment setBackgroundColor:COLOR_ORANGE_APP forState:UIControlStateNormal];
    [self.btnMakePayment setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.btnMakePayment.inkColor = [UIColor colorWithWhite:0.8 alpha:1.0];
    
    self.tblProfile.separatorColor = [UIColor clearColor];
}

#pragma mark - UITableView Delegates -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 266;
    }else{
        return 165;
    }
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 100.0f;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        static NSString *cellIdentifier = @"DetailCell";
        
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        UIView *viewContent = (UIView *)[cell viewWithTag:550];
        
        UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:viewContent.bounds];
        viewContent.layer.masksToBounds = NO;
        viewContent.layer.shadowColor = [UIColor blackColor].CGColor;
        viewContent.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
        viewContent.layer.shadowOpacity = 0.5f;
        viewContent.layer.shadowPath = shadowPath.CGPath;
        
        UILabel *lblName    = (UILabel *)[cell viewWithTag:1000];
        UILabel *lblMobile  = (UILabel *)[cell viewWithTag:1001];
        UILabel *lblApatmnt = (UILabel *)[cell viewWithTag:1002];
        UILabel *lblBlock   = (UILabel *)[cell viewWithTag:1003];
        UILabel *lblFlat    = (UILabel *)[cell viewWithTag:1004];
        UILabel *lblParking = (UILabel *)[cell viewWithTag:1005];
        UILabel *lblEmail   = (UILabel *)[cell viewWithTag:1006];
        UILabel *lblAmount  = (UILabel *)[cell viewWithTag:1007];
        

        lblName.text    = [UserSession sharedInstance].currentUser.customerName;
        lblMobile.text  = [UserSession sharedInstance].currentUser.customerMobNo;
        lblApatmnt.text = [UserSession sharedInstance].currentUser.apartmentName;
        lblBlock.text   = [UserSession sharedInstance].currentUser.blockName;
        lblFlat.text    = [UserSession sharedInstance].currentUser.flatNo;
        lblParking.text = [UserSession sharedInstance].currentUser.parkingName;
        lblEmail.text   = [UserSession sharedInstance].currentUser.customerEmail;
        lblAmount.text  = [UserSession sharedInstance].currentUser.outstandingAmount;
        
//        lblName.text    = [[UserSession sharedInstance].dictUser valueForKey:@"customerName"];
//        lblMobile.text  = [[UserSession sharedInstance].dictUser valueForKey:@"customerMob_no"];
//        lblMobile.text = [[UserSession sharedInstance].dictUser valueForKey:@"appartment_name"];
//        lblBlock.text   = [[UserSession sharedInstance].dictUser valueForKey:@"block_name"];
//        lblFlat.text    = [[UserSession sharedInstance].dictUser valueForKey:@"flat_no"];
//        lblParking.text = [[UserSession sharedInstance].dictUser valueForKey:@"park_slo_no"];
//        lblEmail.text   = [[UserSession sharedInstance].dictUser valueForKey:@"customer_email"];
//        lblAmount.text  = [[[UserSession sharedInstance].dictUser valueForKey:@"amount"] length]?[[UserSession sharedInstance].dictUser valueForKey:@"amount"]:@"NA";
        
        cell.backgroundColor = [UIColor clearColor];
        cell.backgroundView.backgroundColor = [UIColor clearColor];
        
        return cell;
    }else{
        static NSString *cellIdentifier = @"SubscribeCell";
        
        CustomerSubcriptionCell *cell = (CustomerSubcriptionCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        UIView *viewContent = (UIView *)[cell viewWithTag:450];

        viewContent.layer.shadowColor = [UIColor grayColor].CGColor;
        viewContent.layer.shadowOffset = CGSizeMake(1, 3);
        viewContent.layer.shadowOpacity = 0.5;
        viewContent.layer.shadowRadius = 5.0;
        
        if ([[UserSession sharedInstance].currentUser.arrSubscription count] == 1) {
            cell.heightConstVehicle1.constant = 21;
            
            SubscriptionBO *subscrptn1 = [UserSession sharedInstance].currentUser.arrSubscription[0];
            cell.lblVehcle1.text = subscrptn1.vehicleMake;
            cell.lblVhcleNum1.text = subscrptn1.regNo;
            cell.lblVecle1ActiveStatus.text = @"Active";

        }else if ([[UserSession sharedInstance].currentUser.arrSubscription count] == 2){
            cell.heightConstVehicle1.constant = 21;
            cell.heightConstVehicle2.constant = 21;

            SubscriptionBO *subscrptn1 = [UserSession sharedInstance].currentUser.arrSubscription[0];
            cell.lblVehcle1.text = subscrptn1.vehicleMake;
            cell.lblVhcleNum1.text = subscrptn1.regNo;
            cell.lblVecle1ActiveStatus.text = @"Active";

            SubscriptionBO *subscrptn2 = [UserSession sharedInstance].currentUser.arrSubscription[1];

            cell.lblVehcle2.text = subscrptn2.vehicleMake;
            cell.lblVhcleNum2.text = subscrptn2.regNo;
            cell.lblVecle2ActiveStatus.text = @"Active";

        }else if ([[UserSession sharedInstance].currentUser.arrSubscription count] == 3){
            cell.heightConstVehicle1.constant = 21;
            cell.heightConstVehicle2.constant = 21;
            cell.heightConstVehicle3.constant = 21;

            SubscriptionBO *subscrptn1 = [UserSession sharedInstance].currentUser.arrSubscription[0];
            cell.lblVehcle1.text = subscrptn1.vehicleMake;
            cell.lblVhcleNum1.text = subscrptn1.regNo;
            cell.lblVecle1ActiveStatus.text = @"Active";
            
            SubscriptionBO *subscrptn2 = [UserSession sharedInstance].currentUser.arrSubscription[1];
            
            cell.lblVehcle2.text = subscrptn2.vehicleMake;
            cell.lblVhcleNum2.text = subscrptn2.regNo;
            cell.lblVecle2ActiveStatus.text = @"Active";

            SubscriptionBO *subscrptn3 = [UserSession sharedInstance].currentUser.arrSubscription[2];

            cell.lblVehcle3.text = subscrptn3.vehicleMake;
            cell.lblVhcleNum3.text = subscrptn3.regNo;
            cell.lblVecle3ActiveStatus.text = @"Active";

        }else if ([[UserSession sharedInstance].currentUser.arrSubscription count] == 4){
            
            cell.heightConstVehicle1.constant = 21;
            cell.heightConstVehicle2.constant = 21;
            cell.heightConstVehicle3.constant = 21;
            cell.heightConstVehicle4.constant = 21;
            
            SubscriptionBO *subscrptn1 = [UserSession sharedInstance].currentUser.arrSubscription[0];
            cell.lblVehcle1.text = subscrptn1.vehicleMake;
            cell.lblVhcleNum1.text = subscrptn1.regNo;
            cell.lblVecle1ActiveStatus.text = @"Active";
            
            SubscriptionBO *subscrptn2 = [UserSession sharedInstance].currentUser.arrSubscription[1];
            
            cell.lblVehcle2.text = subscrptn2.vehicleMake;
            cell.lblVhcleNum2.text = subscrptn2.regNo;
            cell.lblVecle2ActiveStatus.text = @"Active";
            
            SubscriptionBO *subscrptn3 = [UserSession sharedInstance].currentUser.arrSubscription[2];
            
            cell.lblVehcle3.text = subscrptn3.vehicleMake;
            cell.lblVhcleNum3.text = subscrptn3.regNo;
            cell.lblVecle3ActiveStatus.text = @"Active";

            SubscriptionBO *subscrptn4 = [UserSession sharedInstance].currentUser.arrSubscription[3];
            
            cell.lblVehcle4.text = subscrptn4.vehicleMake;
            cell.lblVhcleNum4.text = subscrptn4.regNo;
            cell.lblVecle4ActiveStatus.text = @"Active";
        }
        
        cell.backgroundColor = [UIColor clearColor];
        cell.backgroundView.backgroundColor = [UIColor clearColor];

        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
