//
//  NPViewController.h
//  NadaanParindey
//
//  Created by Marliza Viegas on 25/10/13.
//  Copyright (c) 2013 Marliza Viegas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NPHomeViewController : UIViewController

@property (nonatomic, retain) UIPopoverController *popOver;

- (IBAction)learnAlphabets:(id)sender;
- (IBAction)scribble:(id)sender;
- (IBAction)learnNumbers:(id)sender;
- (IBAction)showInfo:(id)sender;
@end
