//
//  CommandLineDriver.m
//  CoreImageTool
//
//  Created by Marc Liyanage on 02.08.07.
//  Copyright 2007 Marc Liyanage <http://www.entropy.ch>. All rights reserved.
//

#import "CommandLineDriver.h"


@implementation CommandLineDriver


+ (int)runWithArguments:(const char*[])argv count:(int)argc {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	CommandLineDriver *cld = [CommandLineDriver driverForArguments:argv count:argc];
	int result = [cld run];
	[pool release];
	return result;
}


+ (CommandLineDriver *)driverForArguments:(const char*[])argv count:(int)argc {
	return [[[CommandLineDriver alloc] initWithArguments:argv count:argc] autorelease];
}


- (CommandLineDriver *)initWithArguments:(const char*[])argv count:(int)argc {
	self = [super init];
	if (!self) return nil;

	arguments = [[NSMutableArray alloc] init];
	programName = [[NSString stringWithUTF8String:argv[0]] retain];
	int i;
	for (i = 1; i < argc; i++) {
		[arguments addObject:[NSString stringWithUTF8String:argv[i]]];
	}
	
	return self;

}

- (void) dealloc {
	[programName release];
	[arguments release];
	[super dealloc];
}


- (int)run {

	ImageProcessor *ip = [ImageProcessor processor];

	unsigned int i, count = [arguments count];
	for (i = 0; i < count; i++) {
		NSString *actionKey = [arguments objectAtIndex:i];
		Action *action = [Action actionForKey:actionKey];
		if (!action) continue;

		int parameterCount = [action parameterCount];
		int availableArguments = [arguments count] - (i + 1);
		if (availableArguments < parameterCount) {
			NSLog(@"action '%@' expects %d parameters but only %d arguments remain", actionKey, parameterCount, availableArguments);
			return 1;
		}

		NSMutableArray *actionParameters = [NSMutableArray array];
		int j;
		for (j = 0; j < parameterCount; j++) {
			i++;
			[actionParameters addObject:[arguments objectAtIndex:i]];
		}
		
		BOOL result = [action runWithParameters:actionParameters processor:ip];
		if (!result) {
			NSLog(@"action '%@' failed", actionKey);
			return 1;
		}
	}

	return 0;
}


@end
