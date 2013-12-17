//
//  NPNumViewController.h
//  NadaanParindey
//
//  Created by Marliza Viegas on 25/10/13.
//  Copyright (c) 2013 Marliza Viegas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreAudio/CoreAudioTypes.h>
#import <AudioToolbox/AudioToolbox.h>
#import "NPCustomSensitiveView.h"

@interface NPNumViewController : UIViewController<CustomSensitiveDelegate>



@property (retain, nonatomic) IBOutlet NPCustomSensitiveView *numViewOne;
@property (nonatomic, assign) UIImageView *star1;
@property (nonatomic, assign) UIImageView *star2;
@property (nonatomic, assign) UIImageView *star3;
@property (retain, nonatomic) IBOutlet UIImageView *teacherImg;
@property (retain, nonatomic) UIImageView *greyImage3;
@property (nonatomic, retain)	NSMutableArray	*allHitPoints;
@property (nonatomic, readwrite) SystemSoundID chimeSound;
- (IBAction)showHome:(id)sender;

@end
