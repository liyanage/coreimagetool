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


- (BOOL)runWithParameters:(NSArray *)parameters processor:(ImageProcessor *)ip {
	[NSException raise:NSGenericException format:@"%@ is abstract", _cmd];
	return nil; // not reached
}


- (int)parameterCount {
	return 1;
}

@end
