//
//  ValueClassConverterCIColor.m
//  CoreImageTool
//
//  Created by Marc Liyanage on 05.08.07.
//  Copyright 2007-2009 Marc Liyanage <http://www.entropy.ch>. All rights reserved.
//

#import "ValueClassConverterCIColor.h"


@implementation ValueClassConverterCIColor

- (id)convertString:(NSString *)string {

	NSArray *items = [string componentsSeparatedByString:@","];
	if ([items count] != 4) {
		NSLog(@"CIColor value needs r,g,b,a parameter");
		return nil;
	}

	return [CIColor colorWithRed:[[items objectAtIndex:0] floatValue]
						   green:[[items objectAtIndex:1] floatValue]
		                    blue:[[items objectAtIndex:2] floatValue]
		                   alpha:[[items objectAtIndex:3] floatValue]];
	
	
}


@end
