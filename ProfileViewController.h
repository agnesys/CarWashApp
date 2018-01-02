//
//  ProfileViewController.h
//  YesMakeOver
//
//  Created by Janmenjaya Rout on 23/12/17.
//  Copyright © 2017 Janmenjaya Rout. All rights reserved.
//

#import "BaseViewController.h"
#import "MDCFlatButton.h"
#import "MDCRaisedButton.h"

@interface ProfileViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITableView *tblProfile;

@property (weak, nonatomic) IBOutlet MDCRaisedButton *btnMakePayment;
