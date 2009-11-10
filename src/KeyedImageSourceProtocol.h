//
//  ImageProcessorSupplierProtocol.h
//  CoreImageTool
//
//  Created by Marc Liyanage on 05.08.07.
//  Copyright 2007-2009 Marc Liyanage <http://www.entropy.ch>. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@protocol KeyedImageSource <NSObject>

- (CIImage *)imageForKey:(NSString *)key;

@end
