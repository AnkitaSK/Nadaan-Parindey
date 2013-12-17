//
//  NPScribble.m
//  NadaanParindey
//
//  Created by Marliza Viegas on 25/10/13.
//  Copyright (c) 2013 Marliza Viegas. All rights reserved.
//

#import "NPScribble.h"
#import <QuartzCore/QuartzCore.h>
#import "NPBlowManager.h"


#define DEFAULT_COLOR               [UIColor whiteColor]
#define DEFAULT_WIDTH               15.0f
#define DEFAULT_BACKGROUND_COLOR    [UIColor clearColor]

static const CGFloat kPointMinDistance = 15;

static const CGFloat kPointMinDistanceSquared = kPointMinDistance * kPointMinDistance;

@interface NPScribble ()

#pragma mark Private Helper function

CGPoint midPoint(CGPoint p1, CGPoint p2);

@end

@implementation NPScribble

@synthesize lineColor;
@synthesize lineWidth;
@synthesize empty = _empty;

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        self.lineWidth = DEFAULT_WIDTH;
        self.lineColor = DEFAULT_COLOR;
        // NOTE: do not change the backgroundColor here, so it can be set in IB.
        self.empty = YES;
		path = CGPathCreateMutable();
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame {
	
	frame.origin.x = 50;
	frame.origin.y = 50;
	frame.size.width = frame.size.width - 100;
	frame.size.height = frame.size.height - 100;
	
    self = [super initWithFrame:frame];
    
    if (self) {
        self.lineWidth = DEFAULT_WIDTH;
        self.lineColor = DEFAULT_COLOR;
        self.backgroundColor = DEFAULT_BACKGROUND_COLOR;
        self.empty = YES;
		path = CGPathCreateMutable();
    }
    
    return self;
}


#pragma mark Private Helper function

CGPoint midPoint(CGPoint p1, CGPoint p2) {
    return CGPointMake((p1.x + p2.x) * 0.5, (p1.y + p2.y) * 0.5);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	if (self.shouldErase == YES) {
		return;
	}
    UITouch *touch = [touches anyObject];
    
    previousPoint1 = [touch previousLocationInView:self];
    previousPoint2 = [touch previousLocationInView:self];
    currentPoint = [touch locationInView:self];
    
    [self touchesMoved:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	
	if (self.shouldErase == YES) {
		return;
	}
    UITouch *touch = [touches anyObject];
	
	CGPoint point = [touch locationInView:self];
	
	/* check if the point is farther than min dist from previous */
    CGFloat dx = point.x - currentPoint.x;
    CGFloat dy = point.y - currentPoint.y;
	
    if ((dx * dx + dy * dy) < kPointMinDistanceSquared) {
        return;
    }
    
    
    previousPoint2 = previousPoint1;
    previousPoint1 = [touch previousLocationInView:self];
    currentPoint = [touch locationInView:self];
    
    CGPoint mid1 = midPoint(previousPoint1, previousPoint2);
    CGPoint mid2 = midPoint(currentPoint, previousPoint1);
	CGMutablePathRef subpath = CGPathCreateMutable();
    CGPathMoveToPoint(subpath, NULL, mid1.x, mid1.y);
    CGPathAddQuadCurveToPoint(subpath, NULL, previousPoint1.x, previousPoint1.y, mid2.x, mid2.y);
    CGRect bounds = CGPathGetBoundingBox(subpath);
	
	CGPathAddPath(path, NULL, subpath);
	CGPathRelease(subpath);
    
    CGRect drawBox = bounds;
    drawBox.origin.x -= self.lineWidth * 2.0;
    drawBox.origin.y -= self.lineWidth * 2.0;
    drawBox.size.width += self.lineWidth * 4.0;
    drawBox.size.height += self.lineWidth * 4.0;
    
    [self setNeedsDisplayInRect:drawBox];
}

- (void)drawRect:(CGRect)rect {
    [self.backgroundColor set];
    UIRectFill(rect);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
	CGContextAddPath(context, path);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, self.lineWidth);
    CGContextSetStrokeColorWithColor(context, self.lineColor.CGColor);
    
    CGContextStrokePath(context);
    
    self.empty = NO;
	
	if (self.shouldErase == YES) {
		
		CGContextClearRect(context, self.bounds);
//		CGContextFlush(context);
		CGPathRelease(path);
        path = CGPathCreateMutable();
		[self performSelector:@selector(setErase) withObject:nil afterDelay:.3];
		
	}
	
}

-(void)clearContext{
	if (self.shouldErase == NO) {
		self.shouldErase = YES;
	}
	
    [self setNeedsDisplay];
	
	
}
- (void) setErase{
	self.shouldErase = NO;
}
-(void)dealloc {
	CGPathRelease(path);
	[super dealloc];
}
@end
