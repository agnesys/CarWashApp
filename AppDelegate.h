//
//  AppDelegate.h
//  YesMakeOver
//
//  Created by Janmenjaya Rout on 19/12/17.
//  Copyright © 2017 Janmenjaya Rout. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FirebaseDatabase/FirebaseDatabase.h>
#import <FirebaseStorage/FirebaseStorage.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) FIRDatabaseReference *dbRef;
@property (nonatomic, strong) FIRStorageReference *firStorageRef;


@property (nonatomic, assign) BOOL isUserSignedIn;

@property (nonatomic, assign) BOOL isNetworkReachable;

@property (nonatomic, assign) BOOL isNetworkAvailableWhenAppStarts_info;
@property (nonatomic, assign) BOOL isNetworkAvailableWhenAppStarts_eco;
@property (nonatomic, assign) BOOL isNetworkAvailableWhenAppStarts_school;
@property (nonatomic, assign) BOOL isNetworkAvailableWhenAppStarts_product;
@property (nonatomic, assign) BOOL isNetworkAvailableWhenAppStarts_donation;
@property (nonatomic, assign) BOOL isNetworkAvailableWhenAppStarts_game;

@property (nonatomic, strong) NSMutableArray *arrAllApartments;

@property (nonatomic, assign) BOOL isTermsCondnChecked;


