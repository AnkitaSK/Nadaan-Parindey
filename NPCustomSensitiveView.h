//
//  NPCustomSensitiveView.h
//  NadaanParindey
//
//  Created by Bharat on 25/10/13.
//  Copyright (c) 2013 Marliza Viegas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NPCustomLetterImage.h"

/* Protocol */
@protocol CustomSensitiveDelegate <NSObject>

- (void) userTappedView:(UIView*) v withTapCount:(NSInteger)tapCount;
- (void) touchesEndedByWithHitPoints:(NSMutableArray *)hitPoints MissedPoints:(NSMutableArray *)missedPoints;
- (void) touchBeginByWithHitPoint; // next and pre buttons are made disabled
@end

@interface NPCustomSensitiveView : UIView {
    
    id _delegate;
    
}

@property(nonatomic, assign) IBOutlet id delegate;
@property(nonatomic, retain)	  UIBezierPath *path;
@property(nonatomic, retain)     UIImage *incrementalImage;
@property (nonatomic, retain) NSMutableArray	*pointsHitArray;
@property (nonatomic, retain) NSMutableArray	*pointsMissedArray;

@end
