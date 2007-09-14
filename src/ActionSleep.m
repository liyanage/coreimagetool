//
//  ActionSleep.m
//  CoreImageTool
//
//  Created by Marc Liyanage on 23.08.07.
//  Copyright 2007 Marc Liyanage <http://www.entropy.ch>. All rights reserved.
//

#import "ActionSleep.h"


@implementation ActionSleep

- (BOOL)run {
	
	unsigned int seconds = [[self parameterAtIndex:0] intValue];

	NSLog(@"sleep: %d seconds...", seconds);
	[NSThread sleepUntilDate:[NSDate dateWithTimeIntervalSinceNow:(NSTimeInterval)seconds]];
	return YES;
}

- (int)requiredParameterCount:(NSArray *)lookaheadArguments {
	return 1;
}


@end
