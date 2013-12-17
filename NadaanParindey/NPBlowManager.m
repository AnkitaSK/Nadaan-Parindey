//
//  NPBlowManager.m
//  NadaanParindey
//
//  Created by Marliza Viegas on 25/10/13.
//  Copyright (c) 2013 Marliza Viegas. All rights reserved.
//

#import "NPBlowManager.h"

@implementation NPBlowManager
@synthesize recorder;
@synthesize levelTimer;
@synthesize lowPassResults;

-(void)initializeBlow{
	
	
	NSURL *url = [NSURL fileURLWithPath:@"/dev/null"];
	
  	NSDictionary *settings = [NSDictionary dictionaryWithObjectsAndKeys:
							  [NSNumber numberWithFloat: 44100.0],AVSampleRateKey,
							  [NSNumber numberWithInt: kAudioFormatAppleLossless], AVFormatIDKey,
							  [NSNumber numberWithInt: 1],                         AVNumberOfChannelsKey,
							  [NSNumber numberWithInt: AVAudioQualityMax],         AVEncoderAudioQualityKey,
							  nil];
	
  	NSError *error;
	
  	recorder = [[AVAudioRecorder alloc] initWithURL:url settings:settings error:&error];
	
  	if (recorder) {
  		[recorder prepareToRecord];
  		recorder.meteringEnabled = YES;
  		[recorder record];
		levelTimer = [NSTimer scheduledTimerWithTimeInterval: 0.1 target: self selector: @selector(levelTimerCallback:) userInfo: nil repeats: YES];
  	} else
  		NSLog(@"%@",[error description]);
}

- (void)levelTimerCallback:(NSTimer *)timer {
//	[recorder updateMeters];
//	
//	const double ALPHA = 0.05;
//	double peakPowerForChannel = pow(10, (0.05 * [recorder peakPowerForChannel:0]));
//	lowPassResults = ALPHA * peakPowerForChannel + (1.0 - ALPHA) * lowPassResults;
//	
//	NSLog(@"Average input: %f Peak input: %f", [recorder averagePowerForChannel:0], [recorder peakPowerForChannel:0]);
//	NSLog(@"lowPassResults: %f", lowPassResults);
//	if (lowPassResults > 0.35 && lowPassResults < 0.75)
//   // if (lowPassResults < 0.95)
//	{
//		NSLog(@"Mic blow detected");
//		[self.delegate blowDetected];
//		
//	}
    
    
    [recorder updateMeters];
	
	const double ALPHA = 0.05;
	double peakPowerForChannel = pow(10, (0.05 * [recorder peakPowerForChannel:0]));// dB to linear amplitude conversion
    
    //to find avg of amplitude
    double ampRange = 1. - peakPowerForChannel;
    double avgRange = 1. /ampRange;
    
	lowPassResults = ALPHA * peakPowerForChannel + (1.0 - ALPHA) * lowPassResults;
    
   // lowPassResults = ALPHA * avgRange + (1.0 - ALPHA) * lowPassResults;

	
	NSLog(@"Average input: %f Peak input: %f", [recorder averagePowerForChannel:0], [recorder averagePowerForChannel:0]);
	NSLog(@"lowPassResults: %f", lowPassResults);
	if (lowPassResults > 0.35 && lowPassResults < 0.75)
//    if (lowPassResults > 0.23)
        // if (lowPassResults < 0.95)
	{
		NSLog(@"Mic blow detected");
		[self.delegate blowDetected];
        //[self stopRecorder];
		
	}
    
}

-(void)stopRecorder{
	
	[recorder stop];
}


@end
