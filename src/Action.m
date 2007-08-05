//
//  Action.m
//  CoreImageTool
//
//  Created by Marc Liyanage on 02.08.07.
//  Copyright 2007 Marc Liyanage <http://www.entropy.ch>. All rights reserved.
//

#import "Action.h"

@implementation Action


+ (Action *)actionForKey:(NSString *)key {
	NSString *className = [NSString stringWithFormat:@"Action%@", [key capitalizedString]];
	Class actionClass = NSClassFromString(className);
	if (!actionClass) {
		NSLog(@"No action class found for key %@", key);
		return nil;
	}
	return [[[actionClass alloc] init] autorelease];
}


- (void) dealloc {
	[processors release];
	[parameters release];
	[super dealloc];
}


- (BOOL)runWithParameters:(NSArray *)inParameters processors:(NSMutableDictionary *)inProcessors {
	[self setValue:inProcessors forKey:@"processors"];
	[self setValue:inParameters forKey:@"parameters"];
	return [self run];
}


- (BOOL)run {
	[NSException raise:NSGenericException format:@"%@ is abstract", _cmd];
	return nil; // not reached
}


- (int)requiredParameterCount:(NSArray *)lookaheadArguments {
	return 2;
}


- (ImageProcessor *)imageProcessorForKey:(NSString *)key {
	ImageProcessor *ip = [processors objectForKey:key];
	if (!ip) {
		NSLog(@"No image defined for key '%@'", key);
	}
	return ip;
}

- (CIImage *)imageForKey:(NSString *)key {
	return [[self imageProcessorForKey:key] image];
}


- (ImageProcessor *)keyedImageProcessor {
	return [self imageProcessorForKey:[self keyParameter]];
}


- (ImageProcessor *)createImageProcessorForKey:(NSString *)key {
	ImageProcessor *ip = [ImageProcessor processor];
	[processors setValue:ip forKey:key];
	return ip;
}


- (NSString *)keyParameter {
	return [self parameterAtIndex:0];
}

- (NSString *)parameterAtIndex:(int)i {
	int count = [self parameterCount];
	if (i >= count) {
		NSLog(@"only %d parameters available, index %d not valid", count, i);
		return nil;
	}
	return [parameters objectAtIndex:i];
}

- (int)parameterCount {
	return [parameters count];
}


@end
