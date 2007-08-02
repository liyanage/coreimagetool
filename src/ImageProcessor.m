//
//  ImageProcessor.m
//  CoreImageTool
//
//  Created by Marc Liyanage on 01.08.07.
//  Copyright 2007 Marc Liyanage <http://www.entropy.ch>. All rights reserved.
//

#import "ImageProcessor.h"


@implementation ImageProcessor

+ (ImageProcessor *)processorForInputFile:(NSString *)inFilePath {
	ImageProcessor *ip = [[[ImageProcessor alloc] initWithInputFile:inFilePath] autorelease];
	return ip;
}


- (ImageProcessor *)initWithInputFile:(NSString *)inPath {
	self = [super init];
	if (!self) return nil;

	[self setValue:inPath forKey:@"inFilePath"];
	
	if (![self setupImage]) {
		[self release];
		return nil;
	};
	
	return self;
}


- (void) dealloc {
	[inFilePath release];
	[self freeContext];
	[ci release];
	[super dealloc];
}


- (BOOL)setupImage {

	NSFileManager *fm = [NSFileManager defaultManager];
	if (![fm fileExistsAtPath:inFilePath]) {
		NSLog(@"Input File '%@' does not exist", inFilePath);
		return NO;
	}

	ci = [[CIImage imageWithContentsOfURL:[NSURL fileURLWithPath:inFilePath]] retain];
	if (!ci) {
		NSLog(@"Unable to load input file '%@'", inFilePath);
		return NO;
	}

	return YES;

}



- (void)applyCropX:(float)x Y:(float)y W:(float)w H:(float)h {
	CIFilter *filter = [self prepareFilter:@"CICrop"];
	[filter setValue:[CIVector vectorWithX:x Y:y Z:w W:h] forKey:@"inputRectangle"];
	[self setValue:[filter valueForKey: @"outputImage"] forKey:@"ci"];
}



- (void)applyUnsharpMaskRadius:(float)radius Intensity:(float)intensity {
	CIFilter *filter = [self prepareFilter:@"CIUnsharpMask"];
	[filter setValue:[NSNumber numberWithFloat:radius] forKey:@"inputRadius"];
	[filter setValue:[NSNumber numberWithFloat:intensity] forKey:@"inputIntensity"];
	[self setValue:[filter valueForKey: @"outputImage"] forKey:@"ci"];
}


- (void)applyLanczosScale:(float)scale AspectRatio:(float)aspectRatio {
	CIFilter *filter = [self prepareFilter:@"CILanczosScaleTransform"];
	[filter setValue:[NSNumber numberWithFloat:scale] forKey:@"inputScale"];
	[filter setValue:[NSNumber numberWithFloat:aspectRatio] forKey:@"inputAspectRatio"];
	[self setValue:[filter valueForKey: @"outputImage"] forKey:@"ci"];
}



- (CIFilter *)prepareFilter:(NSString *)name {
	CIFilter *filter = [CIFilter filterWithName:name];
	if (!filter) {
		NSLog(@"Unable to get filter with name '%@'", name);
		return nil;
	}
	[filter setDefaults];
	[filter setValue:ci forKey:@"inputImage"];
	return filter;
}








- (BOOL)writeResultToPath:(NSString *)outFilePath {

	CIImage *resultImage = ci;
	CGRect extent = [resultImage extent];
	BOOL result = [self createBitmapContextWithWidth:extent.size.width Height:extent.size.height];
	if (!result) return NO;

	NSDictionary *outputContextOptions = [NSDictionary dictionaryWithObjectsAndKeys: [NSNumber numberWithBool: NO], kCIContextUseSoftwareRenderer, nil];
	CIContext *ciContext = [CIContext contextWithCGContext:context options:outputContextOptions];
	if (!ciContext) {
		NSLog(@"Unable to create CIContext");
		return NO;
	}
	
	CGImageRef outputCGImage = [ciContext createCGImage:resultImage fromRect:extent];
	if (!outputCGImage) {
		NSLog(@"Unable to create CGImageRef");
		return NO;
	}

	CGImageDestinationRef dest = CGImageDestinationCreateWithURL(
		(CFURLRef)[NSURL fileURLWithPath:outFilePath],
		CFSTR("public.jpeg"),
		1,
		NULL
	);

	if (!dest) {
		NSLog(@"Unable to create destination file with output path '%@'", outFilePath);
		return NO;
	}

	CGImageDestinationAddImage(dest, outputCGImage, nil);
	result = CGImageDestinationFinalize(dest);
	CFRelease(dest);

	if (!result) {
		NSLog(@"Unable to write image to '%@'", outFilePath);
		return NO;
	}

	return YES;
}











- (BOOL)createBitmapContextWithWidth:(int)pixelsWide Height:(int)pixelsHigh {

	CGColorSpaceRef colorSpace;
	void *bitmapData;
	int bitmapByteCount;
	int bitmapBytesPerRow;
	
	[self freeContext];
 
	bitmapBytesPerRow = (pixelsWide * 4);
	bitmapByteCount = (bitmapBytesPerRow * pixelsHigh);
 
	colorSpace = CGColorSpaceCreateWithName(kCGColorSpaceGenericRGB);
	bitmapData = malloc(bitmapByteCount);

	if (!bitmapData) {
		NSLog(@"Unable to allocate memory for bitmap CGContextRef");
		return NO;
	}

	context = CGBitmapContextCreate(
		bitmapData,
		pixelsWide,
		pixelsHigh,
		8, // bits per component
		bitmapBytesPerRow,
		colorSpace,
		//kCGImageAlphaPremultipliedLast
		kCGImageAlphaNoneSkipLast
	);

	if (!context) {
		free (bitmapData);
		NSLog(@"Unable to create bitmap CGContextRef");
		return NO;
	}
	
	CGColorSpaceRelease(colorSpace);
	return YES;
}


- (void)freeContext {
	if (!context) return;
    char *bitmapData = CGBitmapContextGetData(context);
    CGContextRelease(context);
	context = NULL;
    if (bitmapData) free(bitmapData); 
}






@end
