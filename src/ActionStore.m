//
//  ActionStore.m
//  CoreImageTool
//
//  Created by Marc Liyanage on 03.08.07.
//  Copyright 2007 Marc Liyanage <http://www.entropy.ch>. All rights reserved.
//

#import "ActionStore.h"

@implementation ActionStore

- (BOOL)runWithParameters:(NSArray *)parameters processor:(ImageProcessor *)ip {
	NSString *outFilePath = [parameters objectAtIndex:0];
	return [ip writeResultToPath:outFilePath];
}

@end
