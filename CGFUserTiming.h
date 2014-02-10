//
//  CGFUserTiming.h
//  CGFTiming Demo
//
//  Created by Björn Kaiser on 21.10.13.
//  Copyright (c) 2013 Björn Kaiser. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGFUserTiming : NSObject
{

}

@property (strong, nonatomic, readonly) NSMutableDictionary *timings;
@property NSTimeInterval dispatchPeriod;

+ (instancetype) sharedInstance;
- (void) startTimingForAction:(NSString*)action userInfo:(NSDictionary*)userInfo;
- (void) stopTimingForAction:(NSString*)action;

@end
