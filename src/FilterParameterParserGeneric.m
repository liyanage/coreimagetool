//
//  FilterParserGeneric.m
//  CoreImageTool
//
//  Created by Marc Liyanage on 03.08.07.
//  Copyright 2007 Marc Liyanage <http://www.entropy.ch>. All rights reserved.
//

#import "FilterParameterParserGeneric.h"


@implementation FilterParameterParserGeneric


- (BOOL)configureFilter:(CIFilter *)filter withParameterString:(NSString *)parameterString {
	NSDictionary *parameters = [self splitParameterString:parameterString];

	id key, enumerator = [parameters keyEnumerator];
	while ((key = [enumerator nextObject])) {
		NSString *value = [parameters valueForKey:key];
		NSNumber *number = [NSNumber numberWithFloat:[value floatValue]];
		[filter setValue:number forKey:key];
	}
	
	return YES;

}

@end
