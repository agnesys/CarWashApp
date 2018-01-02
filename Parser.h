//
//  Parser.h
//  YesMakeOver
//
//  Created by Janmenjaya Rout on 29/12/17.
//  Copyright © 2017 Janmenjaya Rout. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserSession.h"

@interface Parser : NSObject

+ (void)parseLoginResponse:(NSDictionary *)response withcompletion:(void(^)(UserBO *user, NSError* err))completion;

+ (void)parseApartmentListResponse:(NSDictionary *)response withcompletion:(void(^)(NSArray *arrApartment, NSError *err))completion;

+ (void)parseComplainListResponse:(NSDictionary *)response withcompletion:(void(^)(NSArray *arrComplains, NSError *err))completion;

@end
