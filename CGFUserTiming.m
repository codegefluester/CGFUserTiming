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
        _timings = [NSMutableDictionary new];
        
        // Automatically dispatch timings every 15 seconds
        [NSTimer scheduledTimerWithTimeInterval:15 target:self selector:@selector(dispatchTimings) userInfo:nil repeats:YES];
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
}

- (void) dispatchTimings
{
#warning Create a subclass of CGFUserTiming and overwrite this method to implement your custom dispatch code
    NSLog(@"Dispatching timings\n%@", self.timings);
}

@end
