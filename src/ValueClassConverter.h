//
//  ValueClassConverter.h
//  CoreImageTool
//
//  Created by Marc Liyanage on 05.08.07.
//  Copyright 2007 Marc Liyanage <http://www.entropy.ch>. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "KeyedImageSourceProtocol.h"

@interface ValueClassConverter : NSObject {
	id<KeyedImageSource> imageSource;
}


+ (id)convertString:(NSString *)string toValueOfClass:(NSString *)className imageSource:(id<KeyedImageSource>) imageSource;
- (id)convertString:(NSString *)string;

@end
