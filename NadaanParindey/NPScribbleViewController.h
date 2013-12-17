//
//  NPScribbleViewController.h
//  NadaanParindey
//
//  Created by Marliza Viegas on 25/10/13.
//  Copyright (c) 2013 Marliza Viegas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NPScribble.h"
#import "NPBlowManager.h"

@interface NPScribbleViewController : UIViewController<NPBlowManagerDelegate>

@property (nonatomic, retain) NPBlowManager *blowManager;
@property (nonatomic, retain) NPScribble *scribble;
@property (nonatomic, readwrite) BOOL isBlowEnabled;


- (IBAction)EnableBlow:(id)sender;

- (IBAction)showHome:(id)sender;

@end
