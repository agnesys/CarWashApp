//
//  UserSession.m
//  YesMakeOver
//
//  Created by Janmenjaya Rout on 30/12/17.
//  Copyright © 2017 Janmenjaya Rout. All rights reserved.
//

#import "UserSession.h"

static UserSession *obj_Session;

@implementation UserSession

@synthesize userID;
@synthesize dictUser;
@synthesize currentUser;

+(UserSession *)sharedInstance
{
    if(obj_Session == nil)
    {
        obj_Session = [[UserSession alloc] init];
        //        obj_NOAuser.birthday = [NSDate dateWithTimeIntervalSince1970:0];
    }
    //    [self addObserver:obj_NOAuser forKeyPath:@"birthday" options:NSKeyValueObservingOptionOld context:nil];
    return obj_Session;
}


@end
