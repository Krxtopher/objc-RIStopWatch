// Copyright (c) 2014 Resource LLC

// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#import "RIStopWatch.h"
#import "RITimeSource.h"


#pragma mark - A Default TimeSource Implementation


@interface RIDefaultTimeSource : NSObject <RITimeSource>
@end

@implementation RIDefaultTimeSource

- (NSDate *)now { return [NSDate date]; }

@end


#pragma mark - RIStopWatch Implementation


@interface RIStopWatch()

@property (nonatomic, readwrite) BOOL running;

@property (nonatomic, strong) NSDate *sessionStartTime;

@property (nonatomic) NSTimeInterval sessionElapsedTime;

@property (nonatomic, strong) id<RITimeSource>timeSource;

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
    if (!self.running || !self.sessionStartTime) return 0;
    
    NSDate *now = [self.timeSource now];
    
    return [now timeIntervalSinceDate:self.sessionStartTime];
}


#pragma mark - Creation & Initialization


- (id)initWithTimeSource:(id<RITimeSource>)timeSource
{
    self = [super init];
    if (self) {
        _timeSource = timeSource ? timeSource : [RIDefaultTimeSource new];
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
    self.accumulatedTime += self.elapsedTime;
    self.running = NO;
}

- (void)reset
{
    self.sessionStartTime = [self.timeSource now];
    self.accumulatedTime = 0;
}

@end