//
//  ValueClassConverterNSNumber.m
//  CoreImageTool
//
//  Created by Marc Liyanage on 05.08.07.
//  Copyright 2007 Marc Liyanage <http://www.entropy.ch>. All rights reserved.
//

#import "ValueClassConverterNSNumber.h"


@implementation ValueClassConverterNSNumber

- (id)convertString:(NSString *)string {
	return [NSNumber numberWithFloat:[string floatValue]];
}

@end
