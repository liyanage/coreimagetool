//
//  ActionVerbose.m
//  CoreImageTool
//
//  Created by Marc Liyanage on 05.08.07.
//  Copyright 2007-2009 Marc Liyanage <http://www.entropy.ch>. All rights reserved.
//

#import "ActionVerbose.h"


@implementation ActionVerbose

- (BOOL)run {
	id l = [self valueForKey:@"logger"];
	[l setVerbose:YES];
	[l logVerbose:@"verbose: on"];
	return YES;
}

- (int)requiredParameterCount:(NSArray *)lookaheadArguments {
	return 0;
}

@end
