//
//  AsynTestHelper.h
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 7/15/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

// Set the flag for a block completion handler
#define StartAsyncBlock() __block BOOL waitingForAsyncBlock = YES

// Set the flag to stop the loop
#define StopAsyncBlock() waitingForAsyncBlock = NO

// Wait and loop until flag is set
#define WaitUntilAsyncBlockCompletes() WaitWhile(waitingForAsyncBlock)

// Macro - Wait for condition to be NO/false in blocks and asynchronous calls
#define WaitWhile(condition)\
do {\
while(condition) {\
[[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];\
}\
} while(0)

