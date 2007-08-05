//
//  CommandLineDriver.h
//  CoreImageTool
//
//  Created by Marc Liyanage on 02.08.07.
//  Copyright 2007 Marc Liyanage <http://www.entropy.ch>. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageProcessor.h"
#import "Action.h"
#import "LoggerProtocol.h"

@interface CommandLineDriver : NSObject <Logger> {
	NSString *programName;
	NSMutableArray *arguments;
	NSMutableDictionary *processors;
	BOOL verbose;
}

+ (int)runWithArguments:(const char*[])argv count:(int)argc;
+ (CommandLineDriver *)driverForArguments:(const char*[])argv count:(int)argc;
- (CommandLineDriver *)initWithArguments:(const char*[])argv count:(int)argc;
- (int)run;

@end
