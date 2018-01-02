//
//  ApartmentBO.h
//  YesMakeOver
//
//  Created by Janmenjaya Rout on 30/12/17.
//  Copyright © 2017 Janmenjaya Rout. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServiceBO.h"

@interface ApartmentBO : NSObject

@property (nonatomic, strong) NSString *aprtmntId;
@property (nonatomic, strong) NSString *aprtmntName;
@property (nonatomic, strong) NSString *blocks;
@property (nonatomic, strong) NSString *parking;
@property (nonatomic, strong) NSMutableArray *arrAprtmntSegments;
@property (nonatomic, strong) NSMutableArray *arrOnDemandAprtmntSegments;


@end
