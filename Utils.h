//
//  Utils.h
//  YesMakeOver
//
//  Created by Janmenjaya Rout on 23/12/17.
//  Copyright © 2017 Janmenjaya Rout. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol timerToUpdate

@required
- (void)updateTheFieldsWithDayValues:(NSInteger)days withHours:(NSInteger)hours withMinutes:(NSInteger)minutes withSeconds:(NSInteger)seconds;

@end

@interface Utils : NSObject

+(Utils *)sharedInstance;

@property NSDateFormatter *ourDefaultDateFormatter;
@property NSDateFormatter *ourLocalDateFormatter;

#pragma mark - NSUserDefault
// NSUserDefault helper methods
+ (void) saveStringData:(NSString *)stringData key:(NSString *)key;
+ (NSString *)retrieveSavedStringData:(NSString *)key;

+ (void) saveArrayData:(NSArray *)arrayData key:(NSString *)key;
+ (NSArray *)retrieveSavedArrayData:(NSString *)key;

#pragma mark - Navigation and orientation related

- (UIViewController*)topViewController;

- (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController;

#pragma mark - date, time, timer methods
// timerToUpdate protocol defined below
- (void)calculateRemainingTimeTill:(NSDate *)endDateTime andUpdateTimerIn:(UIViewController<timerToUpdate> *) VCwithTimer;

// use the ourDefaultDateFormatter for data formats from drupal, this one for others
- (NSDateFormatter *)getDateFormatter:(NSString *)formatString;

- (NSDate *)findExpiryDate:(NSString *)dateString;

- (NSDate *)findExpiryDateLocal:(NSString *)dateString;

#pragma mark - debugging aids
+ (void) dumpNSuserDefaults;
+ (void) dumpNSuserDefaultsWithFilteredKeys:(NSArray *)fkeys;
- (NSString *) framePrint:(CGRect)f;

@end
