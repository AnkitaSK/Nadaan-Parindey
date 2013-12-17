//
//  NPBlowManager.h
//  NadaanParindey
//
//  Created by Marliza Viegas on 25/10/13.
//  Copyright (c) 2013 Marliza Viegas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>


@protocol NPBlowManagerDelegate <NSObject>

- (void) blowDetected;

@end

@interface NPBlowManager : NSObject

@property (nonatomic, retain) 	AVAudioRecorder *recorder;
@property (nonatomic, retain)	NSTimer *levelTimer;
@property (nonatomic, assign)	double lowPassResults;
@property (nonatomic, assign) id<NPBlowManagerDelegate> delegate;

-(void)initializeBlow;
-(void)stopRecorder;
@end
