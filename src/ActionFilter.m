//
//  ActionFilter.m
//  CoreImageTool
//
//  Created by Marc Liyanage on 03.08.07.
//  Copyright 2007 Marc Liyanage <http://www.entropy.ch>. All rights reserved.
//

#import "ActionFilter.h"


@implementation ActionFilter


- (BOOL)run {
	ImageProcessor *ip = [self keyedImageProcessor];
	if (!ip) return NO;

	NSString *filterName = [self parameterAtIndex:1];
	NSString *filterParameter = [self parameterCount] > 2 ? [self parameterAtIndex:2] : nil;
	[[self valueForKey:@"logger"] logVerbose: [NSString stringWithFormat:@"filter: %@ %@", filterName, filterParameter]];

	CIFilter *filter = [ip prepareFilter:filterName];
	if (!filter) return NO;

	if (![self configureFilter:filter named:filterName withParameterString:filterParameter]) return NO;
	[ip applyFilter:filter];
	return YES;
}


- (int)requiredParameterCount:(NSArray *)lookaheadArguments {
	
	if ([lookaheadArguments count] < 2) {
		NSLog(@"not enough arguments for filter action, need at least image key and filter name");
		return 9999;
	}
	NSString *filterName = [lookaheadArguments objectAtIndex:1];
	return [[self class] filterHasParameters:filterName] ? 3 : 2;
}


+ (BOOL)filterHasParameters:(NSString *)filterName {
	return ![[NSArray arrayWithObjects:
		@"CIColorInvert",
		@"CIMaskToAlpha",
		@"CIMedianFilter",
		nil
	] containsObject:filterName];
}


- (BOOL)configureFilter:(CIFilter *)filter named:(NSString *)filterName withParameterString:(NSString *)filterParameter {

	if (![[self class] filterHasParameters:filterName]) return YES;

	FilterParameterParser *fpp = [FilterParameterParser parserForFilterName:filterName imageSource:self];
	if (!fpp) return NO;
	
	if (![fpp configureFilter:filter withParameterString:filterParameter]) {
		NSLog(@"Unable to configure filter '%@' with parameters '%@'", filterName, filterParameter);
		return NO;
	}

	return YES;

}


@end
