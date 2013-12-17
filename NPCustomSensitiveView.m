//
//  NPCustomSensitiveView.m
//  NadaanParindey
//
//  Created by Bharat on 25/10/13.
//  Copyright (c) 2013 Marliza Viegas. All rights reserved.
//

#import "NPCustomSensitiveView.h"
#import "NPCustomImageView.h"


@interface NPCustomSensitiveView ()
@property (nonatomic,strong) NPCustomLetterImage *customLetterA;

@end

@implementation NPCustomSensitiveView



CGPoint pts[5]; // we now need to keep track of the four points of a Bezier segment and the first control point of the next segment
uint ctr;


@synthesize path;
@synthesize incrementalImage;


- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        [self setMultipleTouchEnabled:NO];
        self.path = [UIBezierPath bezierPath];
        [self.path setLineWidth:35.0];
        
		self.pointsHitArray = [[NSMutableArray alloc] init];
		self.pointsMissedArray = [[NSMutableArray alloc] init];
        
    }
    return self;
    
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setMultipleTouchEnabled:NO];
        self.path = [UIBezierPath bezierPath];
        [self.path setLineWidth:2.0];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
//    [self.incrementalImage drawInRect:rect];
//    [[UIColor whiteColor] setStroke];
//    [[UIColor whiteColor] setFill];
    [self.path stroke];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
     NSLog(@"counts of arrays :%d, %d", self.pointsHitArray.count, self.pointsMissedArray.count);
    
    ctr = 0;
    UITouch *touch = [touches anyObject];
    pts[0] = [touch locationInView:self];
    [self.delegate touchBeginByWithHitPoint];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint p = [touch locationInView:self];
    ctr++;
    pts[ctr] = p;

    if (ctr == 4)
    {
		//		NSLog(@"4 points");
        pts[3] = CGPointMake((pts[2].x + pts[4].x)/2.0, (pts[2].y + pts[4].y)/2.0); // move the endpoint to the middle of the line joining the second control point of the first Bezier segment and the first control point of the second Bezier segment
        
        [self.path moveToPoint:pts[0]];
        [self.path addCurveToPoint:pts[3] controlPoint1:pts[1] controlPoint2:pts[2]];
		
        [self setNeedsDisplay];
        // replace points and get ready to handle the next segment
        pts[0] = pts[3];
        pts[1] = pts[4];
        ctr = 1;
    }
    UITouch *cTouch = [touches anyObject];
    CGPoint position = [cTouch locationInView:self];
	[self hitTest:position
		withEvent:nil];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	 UITouch *cTouch = [touches anyObject];
	CGPoint position = [cTouch locationInView:self];
	NSLog(@"End Point x: %f",position.x);
	NSLog(@"End Point y: %f",position.y);
    NSLog(@"counts of arrays :%d, %d", self.pointsHitArray.count, self.pointsMissedArray.count);
	[self.delegate touchesEndedByWithHitPoints:self.pointsHitArray MissedPoints:self.pointsMissedArray];
	
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesEnded:touches withEvent:event];
}

- (void)drawBitmap
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, 0.0);
    
    if (!self.incrementalImage) // first time; paint background white
    {
        UIBezierPath *rectpath = [UIBezierPath bezierPathWithRect:self.bounds];
        [[UIColor whiteColor] setFill];
        [rectpath fill];
    }
    [self.incrementalImage drawAtPoint:CGPointZero];
    [[UIColor blueColor] setStroke];
    [self.path stroke];
    self.incrementalImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}

-(id)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
	id hitView = [super hitTest:point withEvent:event];
	if (hitView == self)
	{
		[self.pointsMissedArray addObject:[NSValue valueWithCGPoint:point]];
		NSLog(@"U missed");
		return nil;
		
	}
    [self.pointsHitArray addObject:[NSValue valueWithCGPoint:point]];
	NSLog(@"Congrats... Correct Hit.......................");
	return hitView;
}


@end
