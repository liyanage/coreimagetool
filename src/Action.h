//
//  Action.h
//  CoreImageTool
//
//  Created by Marc Liyanage on 02.08.07.
//  Copyright 2007 Marc Liyanage <http://www.entropy.ch>. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageProcessor.h"

@interface Action : NSObject {
}

+ (Action *)actionForKey:(NSString *)key;
- (BOOL)runWithParameters:(NSArray *)parameters processor:(ImageProcessor *)ip;
- (int)parameterCount;


@end
