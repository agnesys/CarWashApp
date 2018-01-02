//
//  UserBO.m
//  YesMakeOver
//
//  Created by Janmenjaya Rout on 29/12/17.
//  Copyright © 2017 Janmenjaya Rout. All rights reserved.
//

#import "UserBO.h"

@implementation UserBO

@synthesize apartmentName;
@synthesize blockName;
@synthesize customerMobNo;
@synthesize customerName;
@synthesize customerEmail;
@synthesize flatNo;
@synthesize parkingSlotNo;
@synthesize parkingName;
@synthesize arrSubscription;

- (id)init
{
    self = [super init];
    if (self) {
        //
    }
    
    arrSubscription = [[NSMutableArray alloc] init];
    
    return self;
}

@end
