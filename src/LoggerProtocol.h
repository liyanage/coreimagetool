/*
 *  LoggerProtocol.h
 *  CoreImageTool
 *
 *  Created by Marc Liyanage on 05.08.07.
 *  Copyright 2007 Marc Liyanage <http://www.entropy.ch>. All rights reserved.
 *
 */

#import <Foundation/Foundation.h>

@protocol Logger <NSObject>

- (void)logVerbose:(NSString *)message;
- (void)setVerbose:(BOOL)verbose;

@end
