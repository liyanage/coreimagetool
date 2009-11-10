//
//  ActionFilter.h
//  CoreImageTool
//
//  Created by Marc Liyanage on 03.08.07.
//  Copyright 2007-2009 Marc Liyanage <http://www.entropy.ch>. All rights reserved.
//

#import "Action.h"
#import "FilterParameterParser.h"
#import <QuartzCore/QuartzCore.h>

@interface ActionFilter : Action {

}

+ (BOOL)filterHasParameters:(NSString *)filterName;
- (BOOL)configureFilter:(CIFilter *)filter named:(NSString *)filterName withParameterString:(NSString *)filterParameter;

@end
