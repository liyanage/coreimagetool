//
//  ImageProcessor.h
//  CoreImageTool
//
//  Created by Marc Liyanage on 01.08.07.
//  Copyright 2007 Marc Liyanage <http://www.entropy.ch>. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>


@interface ImageProcessor : NSObject {
	NSString *inFilePath;
	CIImage *ci;
	CGContextRef context;
}


+ (ImageProcessor *)processor;
+ (ImageProcessor *)processorForInputFile:(NSString *)inFilePath;
- (ImageProcessor *)initWithInputFile:(NSString *)inFilePath;
- (BOOL)setupImage;
- (BOOL)writeResultToPath:(NSString *)outFilePath type:(NSString *)type;
- (BOOL)createBitmapContextWithWidth:(int)pixelsWide Height:(int)pixelsHigh;
- (BOOL)setInputFile:(NSString *)inPath;
- (void)freeContext;

- (CIFilter *)prepareFilter:(NSString *)name;
- (CIImage *)image;
- (void)applyFilter:(CIFilter *)filter;

@end
