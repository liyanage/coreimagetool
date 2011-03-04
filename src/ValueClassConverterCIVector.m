//
//  ValueClassConverterCIVector.m
//  CoreImageTool
//
//  Created by Marc Liyanage on 05.08.07.
//  Copyright 2007-2009 Marc Liyanage <http://www.entropy.ch>. All rights reserved.
//

#import "ValueClassConverterCIVector.h"


@implementation ValueClassConverterCIVector

- (id)convertString:(NSString *)string {

	CGFloat values[4];
	NSArray *items = [string componentsSeparatedByString:@","];
	NSUInteger i, count = [items count];
	if (count < 1) {
		NSLog(@"Invalid arguments for CIVector value construction");
		return nil;
	}
	
	for (i = 0; i < count; i++) {
		values[i] = [[items objectAtIndex:i] floatValue];
	}
	
	return [CIVector vectorWithValues:values count:count];
	
}


@end
