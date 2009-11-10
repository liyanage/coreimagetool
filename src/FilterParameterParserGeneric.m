//
//  FilterParserGeneric.m
//  CoreImageTool
//
//  Created by Marc Liyanage on 03.08.07.
//  Copyright 2007-2009 Marc Liyanage <http://www.entropy.ch>. All rights reserved.
//

#import "FilterParameterParserGeneric.h"


@implementation FilterParameterParserGeneric


- (BOOL)configureFilter:(CIFilter *)filter withParameterString:(NSString *)parameterString {

	if ([parameterString isEqualToString:@"none"]) {
		return YES;
	}

	NSDictionary *parameters = [self splitParameterString:parameterString];
	NSDictionary *attributes = [filter attributes];

	id key, enumerator = [parameters keyEnumerator];
	while ((key = [enumerator nextObject])) {
		NSDictionary *parameterInfo = [attributes objectForKey:key];
		if (!parameterInfo) {
			NSLog(@"filter '%@' has no '%@' parameter", filter, key);
			return NO;
		}
		

		NSString *parameterClassName = [parameterInfo objectForKey:kCIAttributeClass];
		id value = [self string:[parameters valueForKey:key] toValueOfClass:parameterClassName];
		if (!value) return NO;
		[filter setValue:value forKey:key];
	}
	
	return YES;

}

@end
