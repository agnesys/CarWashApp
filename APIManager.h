//
//  APIManager.h
//  YesMakeOver
//
//  Created by Janmenjaya Rout on 27/12/17.
//  Copyright © 2017 Janmenjaya Rout. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserBO.h"

@interface APIManager : NSObject

+ (void)checkTheUserWithMobNo:(NSString *)mobile withPassword:(NSString *)pass isInTheCustomerListWithCompletion:(void(^)(UserBO *objUser, NSError *err))completion;

+ (void)updatePasswordFieldForTheUserWithPassword:(NSString *)strpass withCompletion:(void(^)(NSDictionary *user, NSError *err))completion;

+ (void)fetchAllApartmentsWithCompletion:(void(^)(NSArray *aprtmntList, NSError *err))completion;

+ (void)registerComplainWithComplainDetails:(NSDictionary *)complain withCompletion:(void(^)(NSError *err))completion;

+ (void)fetchAllComplainsWithCompletion:(void(^)(NSArray *arrComplain, NSError *err))completion;

@end
