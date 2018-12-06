//
//  exStatusbar.h
//  exStatusbar
//
//  Created by Hadi Tavakoli on 10/26/16.
//  Copyright © 2016 MyFlashLab. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ANE_NAME @"com.myflashlab.air.extensions.statusbar"

// dispatch events
#define FRAME_CHANGED @"onFrameChanged"

@interface exStatusbar : NSObject

+ (void) dispatchEventEcode:(NSString *) ecode andElevel:(NSString *) elevel;
//+ (id)delegateInstance; // is needed for visual extensions only

@end
