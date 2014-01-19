//
//  RIStopWatch.h
//  RIStopWatch
//
//  Created by Kris Schultz on 1/17/14.
//  Copyright (c) 2014 Resource. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TimeSource;

@interface RIStopWatch : NSObject

@property (nonatomic, readonly) NSTimeInterval elapsedTime;

@property (nonatomic, readonly) BOOL running;

/**
 Designated initializer
 
 @param timeSource This parameter is optional. If no timeSource is provided RIStopWatch will use its own NSDate-backed time source.
 */
- (id)initWithTimeSource:(id<TimeSource>)timeSource;

- (void)start;

- (void)stop;

- (void)reset;

@end


@protocol TimeSource <NSObject>

- (NSDate *)now;

@end