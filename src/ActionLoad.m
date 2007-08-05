//
//  ActionLoad.m
//  CoreImageTool
//
//  Created by Marc Liyanage on 02.08.07.
//  Copyright 2007 Marc Liyanage <http://www.entropy.ch>. All rights reserved.
//

#import "ActionLoad.h"

@implementation ActionLoad

- (BOOL)run {
	NSString *key = [self keyParameter];
	if (!key) return NO;
	ImageProcessor *ip = [self createImageProcessorForKey:key];
	NSString *filename = [self parameterAtIndex:1];
	return [ip setInputFile:filename];
}


@end
