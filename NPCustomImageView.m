//
//  NPCustomImageView.m
//  NadaanParindey
//
//  Created by Bharat on 25/10/13.
//  Copyright (c) 2013 Marliza Viegas. All rights reserved.
//

#import "NPCustomImageView.h"
#include <QuartzCore/QuartzCore.h>

@implementation NPCustomImageView

- (BOOL) doHitTestForPoint:(CGPoint)point {
    
	CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
	CGBitmapInfo info = kCGImageAlphaPremultipliedLast;
    
	UInt32 bitmapData[1];
	bitmapData[0] = 0;
    
	CGContextRef context =
    CGBitmapContextCreate(bitmapData,
						  1,
						  1,
						  8,
						  4,
						  colorspace,
						  info);
    
	CGContextTranslateCTM(context, -point.x, -point.y);
	[self.layer renderInContext:context];
    
	CGContextFlush(context);
    
	BOOL res = (bitmapData[0] != 0);
    
	CGContextRelease(context);
	CGColorSpaceRelease(colorspace);
    
	return res;
}

#pragma mark -

- (BOOL) isUserInteractionEnabled {
    return YES;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    return [self doHitTestForPoint:point];
}

@end
