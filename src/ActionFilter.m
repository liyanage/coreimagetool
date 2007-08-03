//
//  ActionFilter.m
//  CoreImageTool
//
//  Created by Marc Liyanage on 03.08.07.
//  Copyright 2007 Marc Liyanage <http://www.entropy.ch>. All rights reserved.
//

#import "ActionFilter.h"


@implementation ActionFilter

- (BOOL)runWithParameters:(NSArray *)parameters processor:(ImageProcessor *)ip {
	NSString *filterName = [parameters objectAtIndex:0];
	NSString *filterParameter = [parameters objectAtIndex:1];
	NSLog(@"%@ %@", filterName, filterParameter);

	CIFilter *filter = [ip prepareFilter:filterName];
	if (!filter) return NO;
	
	FilterParameterParser *fpp = [FilterParameterParser parserForFilterName:filterName];
	if (!fpp) return NO;
	
	if (![fpp configureFilter:filter withParameterString:filterParameter]) {
		NSLog(@"Unable to configure filter '%@' with parameters '%@'", filterName, filterParameter);
		return NO;
	}
	[ip applyFilter:filter];

	return YES;

}

- (int)parameterCount {
	return 2;
}

@end
