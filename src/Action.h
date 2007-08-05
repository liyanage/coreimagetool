//
//  Action.h
//  CoreImageTool
//
//  Created by Marc Liyanage on 02.08.07.
//  Copyright 2007 Marc Liyanage <http://www.entropy.ch>. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageProcessor.h"
#import "KeyedImageSourceProtocol.h"
#import "LoggerProtocol.h"

@interface Action : NSObject <KeyedImageSource> {
	NSMutableDictionary *processors;
	NSArray *parameters;
	id <Logger>logger;
}

+ (Action *)actionForKey:(NSString *)key;
- (BOOL)runWithParameters:(NSArray *)parameters processors:(NSMutableDictionary *)processors;
- (BOOL)run;
- (int)requiredParameterCount:(NSArray *)lookaheadArguments;
- (ImageProcessor *)createImageProcessorForKey:(NSString *)key;
- (ImageProcessor *)keyedImageProcessor;
- (NSString *)keyParameter;
- (NSString *)parameterAtIndex:(int)i;
- (int)parameterCount;
- (ImageProcessor *)imageProcessorForKey:(NSString *)key;

@end
