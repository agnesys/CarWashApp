//
//  AddComplainPopUpVC.h
//  YesMakeOver
//
//  Created by Janmenjaya Rout on 26/12/17.
//  Copyright © 2017 Janmenjaya Rout. All rights reserved.
//

#import "BaseViewController.h"
#import "MDCTextField.h"
#import "MDCRaisedButton.h"

@protocol AddComplainPopUpVCDelegate <NSObject>

- (void)btnActionClicked:(UIButton *)sender withOwner:(id)owner;

@end

@interface AddComplainPopUpVC : BaseViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scrlView;

@property (weak, nonatomic) IBOutlet UIView *viewContainer;
@property (weak, nonatomic) IBOutlet MDCTextField *fldDateFrom;
@property (weak, nonatomic) IBOutlet UIImageView *vwRight1;
@property (weak, nonatomic) IBOutlet MDCTextField *fldDateTo;
@property (weak, nonatomic) IBOutlet UIImageView *vwRight2;
@property (weak, nonatomic) IBOutlet MDCTextField *fldApartment;
@property (weak, nonatomic) IBOutlet UIImageView *vwRight3;
@property (weak, nonatomic) IBOutlet MDCTextField *fldBlock;
@property (weak, nonatomic) IBOutlet UIImageView *vwRight4;

@property (weak, nonatomic) IBOutlet MDCRaisedButton *btnCancel;
@property (weak, nonatomic) IBOutlet MDCRaisedButton *btnApply;

@property (nonatomic, weak) id <AddComplainPopUpVCDelegate> delegate;


- (IBAction)btnCacelClicked:(MDCRaisedButton *)sender;
- (IBAction)btnApplyClicked:(MDCRaisedButton *)sender;



@end
