//
//  ActionStore.m
//  CoreImageTool
//
//  Created by Marc Liyanage on 03.08.07.
//  Copyright 2007 Marc Liyanage <http://www.entropy.ch>. All rights reserved.
//

#import "ActionStore.h"

@implementation ActionStore

- (BOOL)run {
	ImageProcessor *ip = [self keyedImageProcessor];
	if (!ip) return NO;
	NSString *outFilePath = [self parameterAtIndex:1];
	NSString *type = [self parameterAtIndex:2];
	[[self valueForKey:@"logger"] logVerbose: [NSString stringWithFormat:@"store: type %@ to path %@", type, outFilePath]];
	return [ip writeResultToPath:outFilePath type:type];
}

- (int)requiredParameterCount:(NSArray *)lookaheadArguments {
	return 3;
}

@end
