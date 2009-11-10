//
//  FilterParameterParser.h
//  CoreImageTool
//
//  Created by Marc Liyanage on 03.08.07.
//  Copyright 2007-2009 Marc Liyanage <http://www.entropy.ch>. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "ValueClassConverter.h"
#import "KeyedImageSourceProtocol.h"

@interface FilterParameterParser : NSObject {
	id<KeyedImageSource> imageSource;
}

+ (FilterParameterParser *)parserForFilterName:(NSString *)filterName imageSource:(id<KeyedImageSource>) imageSource;
+ (Class)classForFilterName:(NSString *)filterName;

- (BOOL)configureFilter:(CIFilter *)filter withParameterString:(NSString *)parameterString;
- (NSDictionary *)splitParameterString:(NSString *)string;
- (id)string:(NSString *)string toValueOfClass:(NSString *)className;

@end
