//
//  ValueClassConverterCIImage.m
//  CoreImageTool
//
//  Created by Marc Liyanage on 05.08.07.
//  Copyright 2007-2009 Marc Liyanage <http://www.entropy.ch>. All rights reserved.
//

#import "ValueClassConverterCIImage.h"

@implementation ValueClassConverterCIImage

- (id)convertString:(NSString *)string {
	NSString *imageKey = string;
	
	CIImage *ci = [[self valueForKey:@"imageSource"] imageForKey:imageKey];
	if (!ci) {
		NSLog(@"Unable to load image with key '%@'", imageKey);
		return nil;
	}
	return ci;
}

@end
