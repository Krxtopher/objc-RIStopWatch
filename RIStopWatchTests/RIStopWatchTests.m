//
//  RIStopWatchTests.m
//  RIStopWatchTests
//
//  Created by Kris Schultz on 1/17/14.
//  Copyright (c) 2014 Resource. All rights reserved.
//

#import <XCTest/XCTest.h>

#define EXP_SHORTHAND
#import "Expecta.h"
#define HC_SHORTHAND
#import <OCHamcrestIOS/OCHamcrestIOS.h>
#define MOCKITO_SHORTHAND
#import <OCMockitoIOS/OCMockitoIOS.h>
#import "RIStopWatch.h"


@interface RIStopWatchTests : XCTestCase

@end


@implementation RIStopWatchTests
{
    RIStopWatch *stopWatch;
}

- (void)setUp
{
    stopWatch = [RIStopWatch new];
}

- (void)test_elapsedTime_givenNewInstance_shouldBeZero
{
    expect(stopWatch.elapsedTime).to.equal(0);
}

- (void)test_elapsedTime_afterStopWatchHasBeenRunning
{
    // Set up
    
    NSDate *fakeStartTime = [NSDate distantPast];
    NSDate *fakeUpdateTime = [fakeStartTime dateByAddingTimeInterval:30];
    
    id<TimeSource> timeSource = mockProtocol(@protocol(TimeSource));
    [given([timeSource now]) willReturn:fakeStartTime];
    
    stopWatch = [[RIStopWatch alloc] initWithTimeSource:timeSource];
    
    // Exercise
    
    [stopWatch start];
    [given([timeSource now]) willReturn:fakeUpdateTime];
    
    // Verify
    
    expect(stopWatch.elapsedTime).to.equal(30);
}

- (void)test_elapsedTime_afterRunStopRun_shouldOnlyCountRunningTime
{
    // Set up
    
    NSDate *startTime = [NSDate distantPast];
    NSDate *stopTime = [startTime dateByAddingTimeInterval:10];
    NSDate *restartTime = [stopTime dateByAddingTimeInterval:25];
    NSDate *finalCheckTime = [restartTime dateByAddingTimeInterval:3];
    
    id<TimeSource> timeSource = mockProtocol(@protocol(TimeSource));
    [given([timeSource now]) willReturn:startTime];
    
    stopWatch = [[RIStopWatch alloc] initWithTimeSource:timeSource];
    
    // Exercise
    
    [stopWatch start];
    
    [given([timeSource now]) willReturn:stopTime];
    [stopWatch stop];
    
    [given([timeSource now]) willReturn:restartTime];
    [stopWatch start];
    
    [given([timeSource now]) willReturn:finalCheckTime];
    
    // Verify
    
    expect(stopWatch.elapsedTime).to.equal(13);
}

- (void)test_running_givenNewInstance_shouldBeNo
{
    expect(stopWatch.running).to.beFalsy();
}

- (void)test_afterCallingStart_shouldBeRunning
{
    [stopWatch start];
    
    expect(stopWatch.running).to.beTruthy();
}

- (void)test_afterCallingStart_shouldNotBeRunning
{
    [stopWatch start];
    [stopWatch stop];
    
    expect(stopWatch.running).to.beFalsy();
}

- (void)test_reset_shouldResetElapsedTime
{
    // Set up
    
    NSDate *fakeStartTime = [NSDate distantPast];
    NSDate *fakeUpdateTime = [fakeStartTime dateByAddingTimeInterval:30];
    
    id<TimeSource> timeSource = mockProtocol(@protocol(TimeSource));
    [given([timeSource now]) willReturn:fakeStartTime];
    
    stopWatch = [[RIStopWatch alloc] initWithTimeSource:timeSource];
    
    // Exercise
    
    [stopWatch start];
    [given([timeSource now]) willReturn:fakeUpdateTime];
    [stopWatch reset];
    
    // Verify
    
    expect(stopWatch.elapsedTime).to.equal(0);
}

- (void)test_reset_shouldNotStopRunningStopWatch
{
    [stopWatch start];
    
    [stopWatch reset];
    
    expect(stopWatch.running).to.beTruthy();
}

- (void)test_reset_shouldNotStartNonRunningStopWatch
{
    [stopWatch reset];
    
    expect(stopWatch.running).to.beFalsy();
}

- (void)test_callingReset_afterRunStopRun_shouldResetElapsedTime
{
    // Set up
    
    NSDate *startTime = [NSDate distantPast];
    NSDate *stopTime = [startTime dateByAddingTimeInterval:10];
    NSDate *restartTime = [stopTime dateByAddingTimeInterval:25];
    NSDate *finalCheckTime = [restartTime dateByAddingTimeInterval:3];
    
    id<TimeSource> timeSource = mockProtocol(@protocol(TimeSource));
    [given([timeSource now]) willReturn:startTime];
    
    stopWatch = [[RIStopWatch alloc] initWithTimeSource:timeSource];
    
    // Exercise
    
    [stopWatch start];
    
    [given([timeSource now]) willReturn:stopTime];
    [stopWatch stop];
    
    [given([timeSource now]) willReturn:restartTime];
    [stopWatch start];
    
    [given([timeSource now]) willReturn:finalCheckTime];
    
    [stopWatch reset];
    
    // Verify
    
    expect(stopWatch.elapsedTime).to.equal(0);
}

- (void)test_initWithTimeSource_whenPassingNilTimeSource
{
    // Set up
    
    stopWatch = [[RIStopWatch alloc] initWithTimeSource:nil];
    
    // Exercise
    
    NSDate *startTime = [NSDate date];
    [stopWatch start];
    
    // Verify
    
    NSDate *now = [NSDate date];
    NSTimeInterval realElapsedTime = [now timeIntervalSinceDate:startTime];
    
    expect(stopWatch.elapsedTime).to.beGreaterThanOrEqualTo(realElapsedTime);
}

- (void)test_init
{
    // Set up
    
    stopWatch = [[RIStopWatch alloc] init];
    
    // Exercise
    
    NSDate *startTime = [NSDate date];
    [stopWatch start];
    
    // Verify
    
    NSDate *now = [NSDate date];
    NSTimeInterval realElapsedTime = [now timeIntervalSinceDate:startTime];
    
    expect(stopWatch.elapsedTime).to.beGreaterThanOrEqualTo(realElapsedTime);
}

@end
