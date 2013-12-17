//
//  NPScribbleViewController.m
//  NadaanParindey
//
//  Created by Marliza Viegas on 25/10/13.
//  Copyright (c) 2013 Marliza Viegas. All rights reserved.
//

#import "NPScribbleViewController.h"
#import "NPBlowManager.h"

@interface NPScribbleViewController ()

@property(nonatomic, readwrite) NSInteger	blowCounter;

@end

@implementation NPScribbleViewController
@synthesize blowManager;
@synthesize scribble;
@synthesize isBlowEnabled;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	self.scribble = [[[NPScribble alloc] initWithFrame:self.view.bounds] autorelease];
	[self.view addSubview:self.scribble];
	
	self.blowManager = [[NPBlowManager alloc] init];
	self.blowManager.delegate = self;
	self.isBlowEnabled = FALSE;
	self.blowCounter = 0;
}

- (void)viewDidDisappear:(BOOL)animated{
	[super viewDidLoad];

	[self.blowManager stopRecorder];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)EnableBlow:(id)sender {
	if (self.isBlowEnabled == FALSE) {
		self.isBlowEnabled = TRUE;
		[self.blowManager initializeBlow];
	}
	else{
		self.isBlowEnabled = FALSE;
	}

}

- (IBAction)showHome:(id)sender {
	
	[self.navigationController popToRootViewControllerAnimated:YES];
}

- (void) blowDetected{
	self.blowCounter++;
	
	if (self.blowCounter == 1) {
		[self.scribble clearContext];
	}
	else{
		self.blowCounter = 0;
	}
	
//	self.scribble = [[NPScribble alloc] init];
}

@end
