//
//  ActionVersion.m
//  CoreImageTool
//
//  Created by Marc Liyanage on 05.08.07.
//  Copyright 2007-2009 Marc Liyanage <http://www.entropy.ch>. All rights reserved.
//

#import "ActionVersion.h"

@implementation ActionVersion

- (BOOL)run {
	NSLog(@"version: CoreImageTool %s", VERSION);
	return YES;
}

- (int)requiredParameterCount:(NSArray *)lookaheadArguments {
	return 0;
}


@end
