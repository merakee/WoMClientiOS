//
//  LocalMacros.h
//  Untility: General
//
//  Created by Bijit Halder on 4/6/12.
//  Copyright (c) 2012 Indriam Inc. All rights reserved.
//

// iphone or ipad macro
#ifdef UI_USER_INTERFACE_IDIOM //()
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#else
#define IS_IPAD (false)
#endif
#define IS_IPHONE (!IS_IPAD)



#ifdef DEBUG
#   define DBLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ## __VA_ARGS__);
#define CMLog(format, ...) NSLog(@"%s:%@", __PRETTY_FUNCTION__,[NSString stringWithFormat:format, ## __VA_ARGS__]);
#define MARK    CMLog(@"%s", __PRETTY_FUNCTION__);
#define START_TIMER NSTimeInterval start = [NSDate timeIntervalSinceReferenceDate];
#define END_TIMER(msg)  NSTimeInterval stop = [NSDate timeIntervalSinceReferenceDate]; CMLog([NSString stringWithFormat:@"%@ Time = %f", msg, stop-start]);
#define IS_DEBUG TRUE
#else
#   define DBLog(...)
#define CMLog(format, ...)
#define MARK
#define START_TIMER
#define END_TIMER(msg)
#define IS_DEBUG FALSE
#endif

#define HEXCOLOR(c) [UIColor colorWithRed : ((c>>24)&0xFF)/255.0 green : ((c>>16)&0xFF)/255.0 blue : ((c>>8)&0xFF)/255.0 alpha : ((c)&0xFF)/255.0]

#define IS_IPHONE5  [[UIScreen mainScreen] bounds].size.height == 568

/* --------------------
   //usage
   CMLog(@&amp;quot;My iPhone is an %@, v %@&amp;quot;, [[UIDevice currentDevice] model], [[UIDevice currentDevice] systemVersion]);

   //usage example
   - (NSData *)loadDataFromURL:(NSString *)dataURL
   {
   START_TIMER;
   NSData *data = [self doSomeStuff:dataURL];
   END_TIMER(@&amp;quot;loadDataFromURL&amp;quot;);
   return data;

   //usage
   UIColor* color = HEXCOLOR(0xff00ff00);

   }

 */