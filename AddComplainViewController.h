//
//  AddComplainViewController.h
//  YesMakeOver
//
//  Created by Janmenjaya Rout on 30/12/17.
//  Copyright © 2017 Janmenjaya Rout. All rights reserved.
//

#import "BaseViewController.h"
#import "MDCTextField.h"
#import "MDCRaisedButton.h"

@interface AddComplainViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scrlView;

@property (weak, nonatomic) IBOutlet UIView *viewSection;
@property (weak, nonatomic) IBOutlet MDCTextField *fldVehicleNo;
@property (weak, nonatomic) IBOutlet UITextView *txtVwComplain;

- (IBAction)buttonSubmitClicked:(MDCRaisedButton *)sender;

@end
