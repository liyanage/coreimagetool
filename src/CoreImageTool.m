#import <Foundation/Foundation.h>
#import "ImageProcessor.h"

CGContextRef MyCreateBitmapContext(int pixelsWide, int pixelsHigh);
void processFilters(ImageProcessor *ip);
void applyCrop(ImageProcessor *ip, NSString *arg);
void applyUnsharpMask(ImageProcessor *ip, NSString *arg);

int main (int argc, const char * argv[]) {

	if (argc < 3) {
		fprintf(stderr, "Usage: %s [options] inputfile outputfile\n", argv[0]);
		return 1;
	}

    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

	const char *inFile = argv[argc - 2];
	NSString *inFilePath = [NSString stringWithUTF8String:inFile];

	ImageProcessor *ip = [ImageProcessor processorForInputFile:inFilePath];
	if (!ip) return 1;

	processFilters(ip);

	const char *outFile = argv[argc - 1];
	NSString *outFilePath = [NSString stringWithUTF8String:outFile];
	[ip writeResultToPath:outFilePath];
	
    [pool release];
    return 0;
}



void processFilters(ImageProcessor *ip) {

	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSString *value;

	value = [defaults objectForKey:@"crop"];
	if (value) applyCrop(ip, value);

	value = [defaults objectForKey:@"unsharpmask"];
	if (value) applyUnsharpMask(ip, value);

}


void applyCrop(ImageProcessor *ip, NSString *arg) {
	NSArray *items = [arg componentsSeparatedByString:@","];
	if ([items count] != 4) {
		NSLog(@"-crop requires x,y,w,h argument");
		return;
	}

	float x = [[items objectAtIndex:0] floatValue];
	float y = [[items objectAtIndex:1] floatValue];
	float w = [[items objectAtIndex:2] floatValue];
	float h = [[items objectAtIndex:3] floatValue];
	
	[ip applyCropX:x Y:y W:w H:h];
}



void applyUnsharpMask(ImageProcessor *ip, NSString *arg) {

	NSArray *items = [arg componentsSeparatedByString:@","];
	if ([items count] != 2) {
		NSLog(@"-unsharpmask requires radius,intensity argument");
		return;
	}

	float radius = [[items objectAtIndex:0] floatValue];
	float intensity = [[items objectAtIndex:1] floatValue];
	
	[ip applyUnsharpMaskRadius:radius Intensity:intensity];

}








