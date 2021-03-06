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

#import <Foundation/Foundation.h>


@protocol RITimeSource;

@interface RIStopWatch : NSObject


#pragma mark - Properties


/**
 The elapsedTime value indicates the accumulated running time of the stopwatch since the last reset.
 */
@property (nonatomic, readonly) NSTimeInterval elapsedTime;

/**
 Indicates whether the stopwatch is running (YES) or stopped (NO).
 */
@property (nonatomic, readonly) BOOL running;


#pragma mark - Creation & Initialization


/**
 Designated initializer
 
 @param timeSource This parameter is optional. If no timeSource is provided RIStopWatch will use its own NSDate-backed time source.
 */
- (id)initWithTimeSource:(id<RITimeSource>)timeSource;


#pragma mark - Stop Watch Control


- (void)start;

- (void)stop;

/**
 Resets the elapsedTime to 0. If the stopwatch is running when reset is called the watch will continue to run.
 */
- (void)reset;


@end


