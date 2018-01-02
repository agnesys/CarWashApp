//
//  Parser.m
//  YesMakeOver
//
//  Created by Janmenjaya Rout on 29/12/17.
//  Copyright © 2017 Janmenjaya Rout. All rights reserved.
//

#import "Parser.h"
#import "ApartmentBO.h"
#import "ComplainBO.h"

@implementation Parser

+ (void)parseLoginResponse:(NSDictionary *)response withcompletion:(void(^)(UserBO *user, NSError *err))completion
{
    //Always it should be one object as we are filtering based on mobile number and password
    NSString *customerKey = [[response allKeys] firstObject];
    NSDictionary *dictCustomer = response[customerKey];
    
    [UserSession sharedInstance].currentUser = [UserBO new];
    
    [UserSession sharedInstance].currentUser.userId             = customerKey;
    [UserSession sharedInstance].currentUser.customerName        = dictCustomer[@"customerName"];
    [UserSession sharedInstance].currentUser.customerMobNo       = dictCustomer[@"customerMob_no"];
    [UserSession sharedInstance].currentUser.apartmentName       = dictCustomer[@"appartment_name"];
    [UserSession sharedInstance].currentUser.blockName           = dictCustomer[@"block_name"];
    [UserSession sharedInstance].currentUser.flatNo              = dictCustomer[@"flat_no"];
    [UserSession sharedInstance].currentUser.parkingSlotNo       = dictCustomer[@"park_slo_no"];
    [UserSession sharedInstance].currentUser.parkingName         = dictCustomer[@"parking_name"];
    [UserSession sharedInstance].currentUser.customerEmail       = dictCustomer[@"customer_email"];
    [UserSession sharedInstance].currentUser.outstandingAmount   = [dictCustomer[@"amount"] length]?response[@"amount"]:@"NA";
    
    NSDictionary *dictSubscrptn = dictCustomer[@"subscription"];
    
    NSArray *allKeySubscrptn = [dictSubscrptn allKeys];
    
    for (NSString *key in allKeySubscrptn) {
        NSDictionary *dict = dictSubscrptn[key];
        
        SubscriptionBO *subscription = [[SubscriptionBO alloc] init];
        subscription.subcriptionId = key;
        subscription.regNo = dict[@"regNo"];
        subscription.vehicleMake = dict[@"vehicleMake"];
        
        [[UserSession sharedInstance].currentUser.arrSubscription addObject:subscription];
    }
    
    completion([UserSession sharedInstance].currentUser, nil);
}

+ (void)parseApartmentListResponse:(NSDictionary *)response withcompletion:(void(^)(NSArray *arrApartment, NSError *err))completion
{
    //Always it should be one object as we are filtering based on mobile number and password
    NSArray *arrApartmentKey = [response allKeys];

    NSMutableArray *arrAllApartments = [NSMutableArray new];
    
    for (NSString *strKey in arrApartmentKey) {
        
        NSDictionary *dictTemp = response[strKey];
     
        ApartmentBO *objApartment = [ApartmentBO new];
        objApartment.aprtmntId      = strKey;
        objApartment.aprtmntName    = dictTemp[@"appartment_name"];
        objApartment.blocks         = dictTemp[@"blocks"];
        objApartment.parking        = dictTemp[@"parking"];
        
        NSDictionary *dictOnDmndSegments = dictTemp[@"on_demand_segments"];
        
        for (NSString *strSegKey in [dictOnDmndSegments allKeys]) {
            
            NSDictionary *dictSegTemp = dictOnDmndSegments[strSegKey];
            
            ServiceBO *service = [ServiceBO new];
            
            service.amount      = dictSegTemp[@"amount"];
            service.serviceType = dictSegTemp[@"serviceType"];
            service.vehicleType = dictSegTemp[@"vehicleType"];
            
            [objApartment.arrOnDemandAprtmntSegments addObject:service];
        }
        
        NSDictionary *dictSegments = dictTemp[@"segments"];
        
        for (NSString *strSegKey in [dictSegments allKeys]) {
            
            NSDictionary *dictSegTemp = dictSegments[strSegKey];
            
            ServiceBO *service = [ServiceBO new];
            
            service.amount      = dictSegTemp[@"amount"];
            service.serviceType = dictSegTemp[@"serviceType"];
            service.vehicleType = dictSegTemp[@"vehicleType"];
            
            [objApartment.arrAprtmntSegments addObject:service];
        }

        [arrAllApartments addObject:objApartment];
    }
    
    completion(arrAllApartments, nil);
}

+ (void)parseComplainListResponse:(NSDictionary *)response withcompletion:(void(^)(NSArray *arrComplains, NSError *err))completion
{
    NSArray *arrComplainKeys = [response allKeys];
    
    NSMutableArray *arrComplainsHistory = [NSMutableArray new];

    for (NSString *strComplainId in arrComplainKeys) {
        
        NSDictionary *dictComplain = response[strComplainId];
        
        ComplainBO *objComplain = [ComplainBO new];
        objComplain.imgUrl          = @"";
        objComplain.complainId      = strComplainId;
        objComplain.complainDesc    = dictComplain[@"complain"];
        objComplain.assignedTo      = dictComplain[@"assigned_to"];
        objComplain.complainDate    = dictComplain[@"date"];
        objComplain.complainStatus  = dictComplain[@"status"];
        objComplain.vehicleNo       = dictComplain[@"vehicle_no"];
        objComplain.block           = dictComplain[@"block"];
        
        [arrComplainsHistory addObject:objComplain];
    }
    
    completion(arrComplainsHistory, nil);
}

@end
