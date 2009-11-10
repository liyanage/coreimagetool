//
//  ActionStore.m
//  CoreImageTool
//
//  Created by Marc Liyanage on 03.08.07.
//  Copyright 2007-2009 Marc Liyanage <http://www.entropy.ch>. All rights reserved.
//

#import "ActionStore.h"

@implementation ActionStore

- (BOOL)run {
	ImageProcessor *ip = [self keyedImageProcessor];
	if (!ip) return NO;
	NSString *outFilePath = [self parameterAtIndex:1];
	NSString *type = [self parameterAtIndex:2];
	NSNumber *quality = nil;
	if ([self parameterCount] > 3) {
		quality = [NSNumber numberWithFloat:[[self parameterAtIndex:3] floatValue]];
	}
	[[self valueForKey:@"logger"] logVerbose: [NSString stringWithFormat:@"store: type %@ to path %@", type, outFilePath]];
	return [ip writeResultToPath:outFilePath type:type quality:quality];
}

- (int)requiredParameterCount:(NSArray *)lookaheadArguments {
	if ([lookaheadArguments count] > 3) {
		if ([[lookaheadArguments objectAtIndex:2] isEqualToString:@"public.jpeg"]) {
			if ([[lookaheadArguments objectAtIndex:3] floatValue] != 0.0) {
				return 4;
			}
		}
	}
	return 3;
}

@end
