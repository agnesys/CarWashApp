//
//  GlobalConstants.h
//  YesMakeOver
//
//  Created by Janmenjaya Rout on 21/12/17.
//  Copyright © 2017 Janmenjaya Rout. All rights reserved.
//

#ifndef GlobalConstants_h
#define GlobalConstants_h

static NSString *kLoginKey                = @"LoginKey";
static NSString *kUDanonymousUID = @"anonymous_uid";
static NSString *kAnonymousUser = @"ANON";  // used for storing read/archived/deleted notifications of anon user


#define COLOR_ORANGE_APP    ([UIColor colorWithRed:235/255.0 green:95/255.0 blue:39/255.0 alpha:1.0])
#define COLOR_BLUE_APP    ([UIColor colorWithRed:0/255.0 green:156/255.0 blue:223/255.0 alpha:1.0])

#define SCREEN_SIZE ([[UIScreen mainScreen] bounds].size)

#define APP_DELEGATE                ((AppDelegate *)[[UIApplication sharedApplication] delegate])
#define UTILS                       [Utils sharedInstance]
#define USER                        [UserSession sharedInstance]

#define INSTANTIATE_VC(xxx)     ([[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:xxx])

#define INSTANTIATE_SIDE_VC(xxx)     ([[UIStoryboard storyboardWithName:@"SideMenu" bundle:nil] instantiateViewControllerWithIdentifier:xxx])

#define TimeStamp [NSString stringWithFormat:@"%.0f",[[NSDate date] timeIntervalSince1970] * 1000]


#define FONT_AVENIR_NEXT(xx)        ([UIFont fontWithName:@"AvenirNext-Regular" size:xx])
#define FONT_AVENIR_NEXT_BOLD(xx)   ([UIFont fontWithName:@"AvenirNext-Bold" size:xx])
#define FONT_AVENIR_NEXT_MEDIUM(xx) ([UIFont fontWithName:@"AvenirNext-Medium" size:xx])
#define FONT_AVENIR_NEXT_LIGHT(xx)  ([UIFont fontWithName:@"AvenirNext-UltraLight" size:xx])
#define FONT_AVENIR_NEXT_ITALIC(xx)  ([UIFont fontWithName:@"AvenirNext-Italic" size:xx])

#define FONT_CONDENSED_BOLD(xx)     ([UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:xx])


#define TRY_AGAIN_NONETWORK_MSG @"Please try again later when the internet connection is back"


#define TERMS_CHECK_KEY     @"TermsKey"

#endif /* GlobalConstants_h */

