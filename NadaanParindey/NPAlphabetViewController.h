//
//  NPAlphabetViewController.h
//  NadaanParindey
//
//  Created by Marliza Viegas on 25/10/13.
//  Copyright (c) 2013 Marliza Viegas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreAudio/CoreAudioTypes.h>
#import <AudioToolbox/AudioToolbox.h>
#import "NPCustomSensitiveView.h"

@interface NPAlphabetViewController : UIViewController<CustomSensitiveDelegate>
- (IBAction)showHome:(id)sender;


@property (retain, nonatomic) IBOutlet NPCustomSensitiveView *alphaAView;
@property (retain, nonatomic) UIImageView *greyImage3;
@property (nonatomic, retain)	NSMutableArray	*allHitPointsArray;
@property (nonatomic, retain)	NSMutableArray	*allMissPointsArray;
@property (nonatomic, readwrite) SystemSoundID chimeSound;
@property (nonatomic, readwrite) SystemSoundID appleSound;
@property (nonatomic, readwrite) SystemSoundID applauseSound;


@property (nonatomic, assign) UIImageView *star1;
@property (nonatomic, assign) UIImageView *star2;
@property (nonatomic, assign) UIImageView *star3;
@property (nonatomic, assign) UIImageView *appleImg;
@property (nonatomic, assign) UIImageView *redCross;

@property (retain, nonatomic) IBOutlet UIImageView *teacherImg;

@property (retain, nonatomic) IBOutlet UIButton *clear;
- (IBAction)clearView:(id)sender;
- (IBAction)goToNextLetter:(UIButton *)sender;

@end
