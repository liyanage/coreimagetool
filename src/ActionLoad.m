//
//  ActionLoad.m
//  CoreImageTool
//
//  Created by Marc Liyanage on 02.08.07.
//  Copyright 2007 Marc Liyanage <http://www.entropy.ch>. All rights reserved.
//

#import "ActionLoad.h"

@implementation ActionLoad

- (BOOL)runWithParameters:(NSArray *)parameters processor:(ImageProcessor *)ip {
	NSString *filename = [parameters objectAtIndex:0];
	return [ip setInputFile:filename];
}


@end
