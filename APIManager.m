//
//  APIManager.m
//  YesMakeOver
//
//  Created by Janmenjaya Rout on 27/12/17.
//  Copyright © 2017 Janmenjaya Rout. All rights reserved.
//

#import "APIManager.h"
#import "GlobalConstants.h"
#import "AppDelegate.h"
#import <Firebase.h>
#import "Parser.h"

@implementation APIManager

+ (void)checkTheUserWithMobNo:(NSString *)mobile withPassword:(NSString *)pass isInTheCustomerListWithCompletion:(void(^)(UserBO *objUser, NSError *err))completion
{
    NSString *userId = [FIRAuth auth].currentUser.uid;
    
    FIRDatabaseReference *dbRef = [APP_DELEGATE.dbRef child:@"customer"];
    FIRDatabaseQuery *query = [[dbRef queryOrderedByChild:@"customerMob_no"] queryEqualToValue:mobile];
    
    [query observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
       
        if ([snapshot exists]) {
            NSDictionary *dictResponse = snapshot.value;
            NSLog(@"dictResponse: %@", dictResponse);
            
            [Parser parseLoginResponse:dictResponse withcompletion:^(UserBO *user, NSError *err) {
                completion(user, nil);
            }];
            
        }else{
            NSError *err = [NSError errorWithDomain:@"No User found" code:-1 userInfo:@{@"info":@"No User found"}];
            completion(nil, err);
        }
    }];

}

+ (void)fetchAllApartmentsWithCompletion:(void(^)(NSArray *aprtmntList, NSError *err))completion
{
    FIRDatabaseReference *dbRef = [APP_DELEGATE.dbRef child:@"appartment"];
    
    [dbRef observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        
        if ([snapshot exists]) {
            NSDictionary *dictResponse = snapshot.value;
            NSLog(@"dictResponse: %@", dictResponse);
            
            [Parser parseApartmentListResponse:dictResponse withcompletion:^(NSArray *arrApartment, NSError *err) {
                completion(arrApartment, nil);
            }];
            
        }else{
            NSError *err = [NSError errorWithDomain:@"No Apartment found" code:-1 userInfo:@{@"info":@"No Apartment found"}];
            completion(nil, err);
        }
    }];
    
}


+ (void)registerComplainWithComplainDetails:(NSDictionary *)complain withCompletion:(void(^)(NSError *err))completion
{
    FIRDatabaseReference *dbRef = [[APP_DELEGATE.dbRef child:@"Complains"] childByAutoId];
    
    [dbRef updateChildValues:complain withCompletionBlock:^(NSError * _Nullable error, FIRDatabaseReference * _Nonnull ref) {
        if (!error) {
            completion(nil);
        }else{
            completion(error);
        }
    }];
}


+ (void)fetchAllComplainsWithCompletion:(void(^)(NSArray *arrComplain, NSError *err))completion
{
    FIRDatabaseReference *dbRef = [APP_DELEGATE.dbRef child:@"Complains"];

    [dbRef observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        
        if ([snapshot exists]) {
            NSDictionary *dictResponse = snapshot.value;
            NSLog(@"dictResponse: %@", dictResponse);
            
            [Parser parseComplainListResponse:dictResponse withcompletion:^(NSArray *arrComplains, NSError *err) {
                completion(arrComplains, nil);
            }];
            
        }else{
            NSError *err = [NSError errorWithDomain:@"No User found" code:-1 userInfo:@{@"info":@"No User found"}];
            completion(nil, err);
        }

    }];
}

+ (void)updatePasswordFieldForTheUserWithPassword:(NSString *)strpass withCompletion:(void(^)(NSDictionary *user, NSError *err))completion
{
    
}


@end
