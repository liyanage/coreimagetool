//
//  ImageProcessor.m
//  CoreImageTool
//
//  Created by Marc Liyanage on 01.08.07.
//  Copyright 2007 Marc Liyanage <http://www.entropy.ch>. All rights reserved.
//

#import "ImageProcessor.h"


@implementation ImageProcessor

+ (ImageProcessor *)processor {
	return [[[ImageProcessor alloc] init] autorelease];
}


+ (ImageProcessor *)processorForInputFile:(NSString *)inFilePath {
	ImageProcessor *ip = [[[ImageProcessor alloc] initWithInputFile:inFilePath] autorelease];
	return ip;
}

- (ImageProcessor *)initWithInputFile:(NSString *)inPath {
	self = [super init];
	if (!self) return nil;

	if (![self setInputFile:inPath]) {
		[self release];
		return nil;
	}

	return self;
}


- (BOOL)setInputFile:(NSString *)inPath {
	[self setValue:inPath forKey:@"inFilePath"];
	return [self setupImage]; 
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

	[self setValue:[CIImage imageWithContentsOfURL:[NSURL fileURLWithPath:inFilePath]] forKey:@"ci"];
	if (!ci) {
		NSLog(@"Unable to load input file '%@'", inFilePath);
		return NO;
	}

	return YES;

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



- (void)applyFilter:(CIFilter *)filter {
	[self setValue:[filter valueForKey: @"outputImage"] forKey:@"ci"];
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
