//
//  ValueClassConverter.m
//  CoreImageTool
//
//  Created by Marc Liyanage on 05.08.07.
//  Copyright 2007-2009 Marc Liyanage <http://www.entropy.ch>. All rights reserved.
//

#import "ValueClassConverter.h"


@implementation ValueClassConverter


+ (id)convertString:(NSString *)string toValueOfClass:(NSString *)className imageSource:(id<KeyedImageSource>) imageSource {
	NSString *handlerClassName = [NSStringFromClass(self) stringByAppendingString:className];
	Class handlerClass = NSClassFromString(handlerClassName);
	
	if (!handlerClass) {
		NSLog(@"Unable to find handler class for data type '%@'", className);
		return nil;
	}

	ValueClassConverter *converter = [[[handlerClass alloc] init] autorelease];
	[converter setValue:imageSource forKey:@"imageSource"];
	return [converter convertString:string];
}


- (void) dealloc {
	[imageSource release];
	[super dealloc];
}


- (id)convertString:(NSString *)string {
	[NSException raise:NSGenericException format:@"%@ is abstract", NSStringFromSelector(_cmd)];
	return nil; // not reached
}



@end

