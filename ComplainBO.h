//
//  ComplainBO.h
//  YesMakeOver
//
//  Created by Janmenjaya Rout on 25/12/17.
//  Copyright © 2017 Janmenjaya Rout. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ComplainBO : NSObject

@property (nonatomic, copy) NSString *complainId;
@property (nonatomic, copy) NSString *imgUrl;
@property (nonatomic, copy) NSString *complainDesc;
@property (nonatomic, copy) NSString *complainDate;
@property (nonatomic, copy) NSString *complainStatus;
@property (nonatomic, copy) NSString *assignedTo;
@property (nonatomic, copy) NSString *vehicleNo;
@property (nonatomic, copy) NSString *block;


@end
