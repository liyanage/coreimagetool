//
//  FilterParameterParserCICrop.m
//  CoreImageTool
//
//  Created by Marc Liyanage on 03.08.07.
//  Copyright 2007 Marc Liyanage <http://www.entropy.ch>. All rights reserved.
//

#import "FilterParameterParserCICrop.h"


@implementation FilterParameterParserCICrop

- (BOOL)configureFilter:(CIFilter *)filter withParameterString:(NSString *)parameterString {
	NSDictionary *parameters = [self splitParameterString:parameterString];
	
	NSString *cropRect = [parameters valueForKey:@"inputRectangle"];
	NSArray *items = [cropRect componentsSeparatedByString:@","];
	if ([items count] != 4) {
		NSLog(@"CICrop filter requires x,y,w,h argument");
		return NO;
	}

	float x = [[items objectAtIndex:0] floatValue];
	float y = [[items objectAtIndex:1] floatValue];
	float w = [[items objectAtIndex:2] floatValue];
	float h = [[items objectAtIndex:3] floatValue];

	[filter setValue:[CIVector vectorWithX:x Y:y Z:w W:h] forKey:@"inputRectangle"];

	return YES;
}


@end
