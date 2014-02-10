//
//  CGFUserTiming.m
//  CGFTiming Demo
//
//  Created by Björn Kaiser on 21.10.13.
//  Copyright (c) 2013 Björn Kaiser. All rights reserved.
//

#import "CGFUserTiming.h"

@interface CGFUserTiming ()

@property (readwrite) NSMutableDictionary *timings;

- (void) dispatchTimings;

@end

@implementation CGFUserTiming

static CGFUserTiming *_sharedInstance;

+ (instancetype) sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [CGFUserTiming new];
    });
    
    return _sharedInstance;
}

- (instancetype) init
{
    NSAssert(_sharedInstance == nil, @"Don't allocate a new instance of CGFUserTiming, use [CGFUserTiming sharedInstance] instead");
    
    self = [super init];
    if (self)
    {
        _sharedInstance.timings = [NSMutableDictionary new];
        _sharedInstance.dispatchPeriod = 60.0f;
    }
    
    return self;
}

- (void) startTimingForAction:(NSString*)action userInfo:(NSDictionary*)userInfo
{
    NSMutableDictionary *dict = [NSMutableDictionary new];
    
    [dict setObject:[NSDate date] forKey:@"start"];
    if(userInfo != nil) [dict setObject:userInfo forKey:@"userInfo"];
    
    [self.timings setObject:dict forKey:action];
    
    dict = nil;
}

- (void) stopTimingForAction:(NSString*)action
{
    NSMutableDictionary *dict = [self.timings objectForKey:action];
    [dict setObject:[NSDate date] forKey:@"end"];
    [self.timings setObject:dict forKey:action];
    dict = nil;
    [self performSelectorInBackground:@selector(dispatchTimings) withObject:nil];
}

- (void) dispatchTimings
{
    NSLog(@"Overwrite me in your subclass to implement custom dispatching");
}

@end
