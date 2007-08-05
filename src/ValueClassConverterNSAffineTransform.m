//
//  ValueClassConverterNSAffineTransform.m
//  CoreImageTool
//
//  Created by Marc Liyanage on 05.08.07.
//  Copyright 2007 Marc Liyanage <http://www.entropy.ch>. All rights reserved.
//

#import "ValueClassConverterNSAffineTransform.h"

// http://developer.apple.com/documentation/Cocoa/Conceptual/CocoaDrawingGuide/Transforms/chapter_4_section_3.html#//apple_ref/doc/uid/TP40003290-CH204-BCIIICJI

// http://developer.apple.com/documentation/GraphicsImaging/Conceptual/drawingwithquartz2d/dq_affine/chapter_6_section_7.html


// identity: transform:1,0,0,1,0,0

@implementation ValueClassConverterNSAffineTransform

- (id)convertString:(NSString *)string {

	NSArray *items = [string componentsSeparatedByString:@","];
	if ([items count] != 6) {
		NSLog(@"transform parameter needs m11,m12,m21,m22,tX,tY value");
		return nil;
	}
	
	NSAffineTransformStruct ts;
	ts.m11 = [[items objectAtIndex:0] floatValue];
	ts.m12 = [[items objectAtIndex:1] floatValue];
	ts.m21 = [[items objectAtIndex:2] floatValue];
	ts.m22 = [[items objectAtIndex:3] floatValue];
	ts.tX  = [[items objectAtIndex:4] floatValue];
	ts.tY  = [[items objectAtIndex:5] floatValue];

	NSAffineTransform *t = [NSAffineTransform transform];
	[t setTransformStruct:ts];
	return t;
	
}




@end

