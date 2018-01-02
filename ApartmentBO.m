//
//  ApartmentBO.m
//  YesMakeOver
//
//  Created by Janmenjaya Rout on 30/12/17.
//  Copyright © 2017 Janmenjaya Rout. All rights reserved.
//

#import "ApartmentBO.h"

@implementation ApartmentBO

- (id)init
{

    self = [super init];
    if (self) {
        //do your code
        
        _arrAprtmntSegments = [[NSMutableArray alloc] init];
        _arrOnDemandAprtmntSegments = [[NSMutableArray alloc] init];
    }
    return self;
}

@end
