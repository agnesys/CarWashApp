//
//  Utils.m
//  YesMakeOver
//
//  Created by Janmenjaya Rout on 23/12/17.
//  Copyright © 2017 Janmenjaya Rout. All rights reserved.
//

#import "Utils.h"
#import "SideMenuRootViewController.h"

static Utils *obj_Utils;

@implementation Utils

+(Utils *)sharedInstance
{
    if(obj_Utils == nil)
    {
        obj_Utils = [[Utils alloc] init];
        obj_Utils.ourDefaultDateFormatter = [obj_Utils getDateFormatter:@"yyyy-MM-dd'SGT'HH:mm:ss"];
        obj_Utils.ourLocalDateFormatter = [obj_Utils getDateFormatter:@"yyyy-MM-dd'T'HH:mm:ss"];
    }
    
    return obj_Utils;
}

#pragma mark - NSUserDefaults
/* Save and retrieve string */
+ (void) saveStringData:(NSString *)stringData key:(NSString *)key {
    NSUserDefaults *userDef=[NSUserDefaults standardUserDefaults];
    [userDef setObject:stringData forKey:key];
    [userDef synchronize];
}
+ (NSString *) retrieveSavedStringData:(NSString *)key {
    NSUserDefaults *userDef=[NSUserDefaults standardUserDefaults];
    return [userDef objectForKey:key];
}

+ (void) saveArrayData:(NSArray *)arrayData key:(NSString *)key {
    NSUserDefaults *userDef=[NSUserDefaults standardUserDefaults];
    [userDef setObject:arrayData forKey:key];
    [userDef synchronize];
}

+ (NSArray *)retrieveSavedArrayData:(NSString *)key {
    NSUserDefaults *userDef=[NSUserDefaults standardUserDefaults];
    return [userDef objectForKey:key];
}

#pragma mark - Navigation and orientation related

- (UIViewController*)topViewController {
    return [self topViewControllerWithRootViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}

- (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController {
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        NSLog(@"root VC is tab bar controller");
        UITabBarController* tabBarController = (UITabBarController*)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        NSLog(@"root VC is nav controller");
        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
    } else if ([rootViewController isKindOfClass:[SideMenuRootViewController class]]) {
        NSLog(@"root VC is SideMenuRootViewController, trying to hide menuVC in case it is showing");
        [(SideMenuRootViewController *)rootViewController hideMenuViewController]; // hide, in case showing
        UIViewController* contentViewController = ((SideMenuRootViewController*)rootViewController).contentViewController;
        if ([contentViewController isKindOfClass:[UITabBarController class]]) {
            NSLog(@"contentViewController is tab bar controller");
            UITabBarController* tabBarController = (UITabBarController*)contentViewController;
            return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
        } else if ([contentViewController isKindOfClass:[UINavigationController class]]) {
            NSLog(@"contentViewController is nav controller");
            UINavigationController* navigationController = (UINavigationController*)contentViewController;
            return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
        } else {
            NSLog(@"don't know contentViewController type, but returning it");
            return contentViewController;
        }
    } else if (rootViewController.presentedViewController) {
        NSLog(@"root VC is presented VC");
        // this MAY be the place to detect if it is a popup and handle appropriately
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    } else {
        NSLog(@"don't know top, it is rootVC");
        return rootViewController;
    }
}

#pragma mark - date, time, timer methods
// returns all 0s if endDateTime is earlier than present (time is expired), rather than negative value(s)
- (void)calculateRemainingTimeTill:(NSDate *)endDateTime andUpdateTimerIn:(UIViewController<timerToUpdate> *) VCwithTimer {
    NSDate *today = [NSDate date];
    if ([today compare:endDateTime] == NSOrderedAscending) { // endTime is later
        NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSUInteger units = NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
        NSDateComponents *components = [gregorian components:units fromDate:[NSDate date] toDate:endDateTime options:0];
        NSInteger days      = [components day];
        NSInteger hour      = [components hour];
        NSInteger minutes   = [components minute];
        NSInteger seconds   = [components second];
        [VCwithTimer updateTheFieldsWithDayValues:days withHours:hour withMinutes:minutes withSeconds:seconds];
    } else { // expired
        [VCwithTimer updateTheFieldsWithDayValues:0 withHours:0 withMinutes:0 withSeconds:0];
    }
}

- (NSDate *)findExpiryDateLocal:(NSString *)dateString {
    return [self.ourLocalDateFormatter dateFromString:dateString];
}

- (NSDate *)findExpiryDate:(NSString *)dateString {
    return [self.ourDefaultDateFormatter dateFromString:dateString];
}

- (NSDateFormatter *)getDateFormatter:(NSString *)formatString {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.locale = [NSLocale localeWithLocaleIdentifier:@"en_SG_POSIX"]; // https://gist.github.com/jacobbubu/1836273 for en_SG, with POSIX added as per https://developer.apple.com/library/ios/documentation/Cocoa/Reference/Foundation/Classes/NSDateFormatter_Class/#//apple_ref/occ/instp/NSDateFormatter/locale
    df.dateFormat = formatString;
    df.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"SGT"];
    return df;
}

#pragma mark - debugging aids
+ (void) dumpNSuserDefaults {
    NSLog(@"utils - NSUserDefaults dump: %@", [[NSUserDefaults standardUserDefaults] dictionaryRepresentation]);
}

+ (void) dumpNSuserDefaultsWithFilteredKeys:(NSArray *)fkeys {
    NSMutableArray *desiredKeys = [NSMutableArray array];
    for (NSString *key in [[NSUserDefaults standardUserDefaults] dictionaryRepresentation]) {
        NSUInteger index = [fkeys indexOfObjectPassingTest:^BOOL(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            return [key containsString:((NSString *)obj)];
        }];
        if (index!=NSNotFound) {
            NSLog(@"index = %lu, adding %@", index, key);
            [desiredKeys addObject:key];
        }
    }
    NSDictionary *fDict = [[[NSUserDefaults standardUserDefaults] dictionaryRepresentation] dictionaryWithValuesForKeys:desiredKeys];
    NSLog(@"utils - NSUserDefaultsWithFilteredKeys (%@):%@", fkeys, fDict);
}

- (NSString *) framePrint:(CGRect)f {
    return ([NSString stringWithFormat:@"org-(%f,%f),size(%f,%f)",f.origin.x,f.origin.y,f.size.width,f.size.height]);
}

@end
