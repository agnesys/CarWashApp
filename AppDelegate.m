//
//  AppDelegate.m
//  YesMakeOver
//
//  Created by Janmenjaya Rout on 19/12/17.
//  Copyright © 2017 Janmenjaya Rout. All rights reserved.
//

#import "AppDelegate.h"
#import <Firebase/Firebase.h>
#import "GlobalConstants.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize arrAllApartments;
@synthesize isTermsCondnChecked;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    arrAllApartments = [[NSMutableArray alloc] init];
    
    [FIRApp configure];
    
    //Firebase databse reference
    self.dbRef = [[FIRDatabase database] reference];
    
    // Get a reference to the storage service using the default Firebase App
    FIRStorage *storage = [FIRStorage storage];
    
    // Create a storage reference from our storage service
    self.firStorageRef = [storage reference];

    self.isTermsCondnChecked = [[NSUserDefaults standardUserDefaults] boolForKey:TERMS_CHECK_KEY];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
