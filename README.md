# RIStopWatch

RIStopWatch is a simple and useful class for tracking elapsed time.

## Installation

1. Clone or download a copy of this repository.
2. Copy the following three files into your own Xcode project (found under RIStopWatch/):
	- RIStopWatch.h
	- RIStopWatch.m
	- RITimeSource.h
3. Add the following #import statement to top of any class in which you'd like to use an RIStopWatch:

    `#import "RIStopWatch.h"`

## Usage

```objc
RIStopWatch *watch = [RIStopWatch new];
[watch start];
... // 2 seconds later
[watch stop];
NSLog(@"%f", watch.elapsedTime); // "2"
[watch start];
... // 3 seconds later
NSLog(@"%f", watch.elapsedTime); // "5"
[watch reset];
... // 1 second later
NSLog(@"%f", watch.elapsedTime); // "1"
```

For more usage detail see the [RIStopWatch.h header file](RIStopWatch/RIStopWatch.h).

## License
2014 © [Resource LLC](http://resource.com)  
Licensed under the [MIT License](https://github.com/resource/Front-End-Standards/blob/master/LICENSE.md)