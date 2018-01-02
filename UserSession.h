//
//  UserSession.h
//  YesMakeOver
//
//  Created by Janmenjaya Rout on 30/12/17.
//  Copyright © 2017 Janmenjaya Rout. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserBO.h"

@interface UserSession : NSObject

+(UserSession *)sharedInstance;

@property (nonatomic, copy) NSString *userID;
@property (nonnull, strong) NSDictionary *dictUser;
@property (nonatomic, strong) UserBO *currentUser;

@end
