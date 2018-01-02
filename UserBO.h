//
//  UserBO.h
//  YesMakeOver
//
//  Created by Janmenjaya Rout on 29/12/17.
//  Copyright © 2017 Janmenjaya Rout. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SubscriptionBO.h"

@interface UserBO : NSObject

@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *apartmentName;
@property (nonatomic, strong) NSString *blockName;
@property (nonatomic, strong) NSString *customerMobNo;
@property (nonatomic, strong) NSString *customerName;
@property (nonatomic, strong) NSString *customerEmail;
@property (nonatomic, strong) NSString *flatNo;
@property (nonatomic, strong) NSString *parkingSlotNo;
@property (nonatomic, strong) NSString *parkingName;
@property (nonatomic, strong) NSString *outstandingAmount;
@property (nonatomic, strong) NSMutableArray *arrSubscription;

@end
