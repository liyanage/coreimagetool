//
//  FilterParameterParser.h
//  CoreImageTool
//
//  Created by Marc Liyanage on 03.08.07.
//  Copyright 2007 Marc Liyanage <http://www.entropy.ch>. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface FilterParameterParser : NSObject {

}

+ (FilterParameterParser *)parserForFilterName:(NSString *)filterName;
+ (Class)classForFilterName:(NSString *)filterName;

- (BOOL)configureFilter:(CIFilter *)filter withParameterString:(NSString *)parameterString;
- (NSDictionary *)splitParameterString:(NSString *)string;

@end
