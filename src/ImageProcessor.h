//
//  ImageProcessor.h
//  CoreImageTool
//
//  Created by Marc Liyanage on 01.08.07.
//  Copyright 2007 Marc Liyanage <http://www.entropy.ch>. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <QuartzCore/QuartzCore.h>


@interface ImageProcessor : NSObject {

	NSString *inFilePath;
	CIImage *ci;
	CGContextRef context;

}


+ (ImageProcessor *)processorForInputFile:(NSString *)inFilePath;
- (ImageProcessor *)initWithInputFile:(NSString *)inFilePath;
- (BOOL)setupImage;
- (BOOL)writeResultToPath:(NSString *)outFilePath;
- (BOOL)createBitmapContextWithWidth:(int)pixelsWide Height:(int)pixelsHigh;
- (void)freeContext;

- (void)applyCropX:(float)x Y:(float)y W:(float)w H:(float)h;
- (void)applyUnsharpMaskRadius:(float)radius Intensity:(float)intensity;

- (CIFilter *)prepareFilter:(NSString *)name;


@end
