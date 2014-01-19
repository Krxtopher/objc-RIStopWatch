//
//  RIStopWatch.m
//  RIStopWatch
//
//  Created by Kris Schultz on 1/17/14.
//  Copyright (c) 2014 Resource. All rights reserved.
//

#import "RIStopWatch.h"


#pragma mark - A Default TimeSource Implementation


@interface DefaultTimeSource : NSObject <TimeSource>
@end

@implementation DefaultTimeSource

- (NSDate *)now { return [NSDate date]; }

@end


#pragma mark - RIStopWatch Implementation


@interface RIStopWatch()

@property (nonatomic, readwrite) BOOL running;

@property (nonatomic, strong) NSDate *sessionStartTime;

@property (nonatomic) NSTimeInterval sessionElapsedTime;

@property (nonatomic, strong) id<TimeSource>timeSource;

@property (nonatomic) NSTimeInterval accumulatedTime;

@end


@implementation RIStopWatch

#pragma mark - Properties


- (NSTimeInterval)elapsedTime
{
    return self.sessionElapsedTime + self.accumulatedTime;
}

- (NSTimeInterval)sessionElapsedTime
{
    if (!self.sessionStartTime) return 0;
    
    NSDate *now = [self.timeSource now];
    
    return [now timeIntervalSinceDate:self.sessionStartTime];
}


#pragma mark - Creation & Initialization


- (id)initWithTimeSource:(id<TimeSource>)timeSource
{
    self = [super init];
    if (self) {
        _timeSource = timeSource ? timeSource : [DefaultTimeSource new];
        _accumulatedTime = 0;
        _sessionElapsedTime = 0;
    }
    return self;
}

- (id)init
{
    return [self initWithTimeSource:nil];
}


#pragma mark - Stop Watch Control


- (void)start
{
    self.running = YES;
    self.sessionStartTime = [self.timeSource now];
}

- (void)stop
{
    self.running = NO;
    self.accumulatedTime += self.elapsedTime;
}

- (void)reset
{
    self.sessionStartTime = [self.timeSource now];
    self.accumulatedTime = 0;
}

@end