//
//  NPScribble.h
//  NadaanParindey
//
//  Created by Marliza Viegas on 25/10/13.
//  Copyright (c) 2013 Marliza Viegas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NPScribble : UIView{

@private
	CGPoint currentPoint;
	CGPoint previousPoint1;
	CGPoint previousPoint2;
	CGFloat lineWidth;
	UIColor *lineColor;
	UIImage *curImage;

	CGMutablePathRef path;
}

@property (nonatomic, retain) UIColor *lineColor;
@property (readwrite) CGFloat lineWidth;
@property (assign, nonatomic) BOOL empty;
@property (assign, nonatomic) BOOL shouldErase;

-(void)clearContext;

@end
