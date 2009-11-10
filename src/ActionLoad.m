//
//  ActionLoad.m
//  CoreImageTool
//
//  Created by Marc Liyanage on 02.08.07.
//  Copyright 2007-2009 Marc Liyanage <http://www.entropy.ch>. All rights reserved.
//

#import "ActionLoad.h"

@implementation ActionLoad

- (BOOL)run {
	NSString *key = [self keyParameter];
	if (!key) return NO;
	ImageProcessor *ip = [self createImageProcessorForKey:key];
	NSString *filename = [self parameterAtIndex:1];
	[[self valueForKey:@"logger"] logVerbose: [NSString stringWithFormat:@"load: %@", filename]];
	return [ip setInputFile:filename];
}


@end
