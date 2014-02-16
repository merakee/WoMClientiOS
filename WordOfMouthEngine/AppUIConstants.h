//
//  AppUIConstants.h
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 2/15/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppUIConstants : NSObject



// Core function tabbar
typedef enum {
    kCFVTabbarIndexContent=0,
    kCFVTabbarIndexHistory,
    kCFVTabbarIndexProfile,
    kCFVTabbarIndexSettings
} CFVTabbarIndex;

#define kAUCCoreFunctionTabbarImageContent     @"TabbarImageContent.png"
#define kAUCCoreFunctionTabbarImageHistory     @"Favorites.png"
#define kAUCCoreFunctionTabbarImageProfile     @"Contact.png"
#define kAUCCoreFunctionTabbarImageSettings    @"TabbarImageSettings.png"


@end
