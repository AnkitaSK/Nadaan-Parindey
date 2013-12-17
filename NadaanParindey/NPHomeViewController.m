//
//  NPViewController.m
//  NadaanParindey
//
//  Created by Marliza Viegas on 25/10/13.
//  Copyright (c) 2013 Marliza Viegas. All rights reserved.
//

#import "NPHomeViewController.h"
#import "NPAlphabetViewController.h"
#import "NPNumViewController.h"
#import "NPScribbleViewController.h"
#import "NPInstructionsViewController.h"

@interface NPHomeViewController ()

@end

@implementation NPHomeViewController
@synthesize popOver;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)learnAlphabets:(id)sender {
	
	NPAlphabetViewController *alphabetViewController = [[NPAlphabetViewController alloc] initWithNibName:@"NPAlphabetViewController" bundle:nil];
	[self.navigationController pushViewController:alphabetViewController animated:YES];
}

- (IBAction)scribble:(id)sender {
	
	NPScribbleViewController *scribbleViewController = [[NPScribbleViewController alloc] initWithNibName:@"NPScribbleViewController" bundle:nil];
	[self.navigationController pushViewController:scribbleViewController animated:YES];
}

- (IBAction)learnNumbers:(id)sender {
	NPNumViewController *numViewController = [[NPNumViewController alloc] initWithNibName:@"NPNumViewController" bundle:nil];
	[self.navigationController pushViewController:numViewController animated:YES];
}

-(IBAction)showInfo:(id)sender{
	
	UIButton *infoButton = (UIButton *)sender;
	NPInstructionsViewController *instructionsViewController = [[NPInstructionsViewController alloc] initWithNibName:@"NPInstructionsViewController" bundle:nil];
	self.popOver = [[UIPopoverController alloc] initWithContentViewController:instructionsViewController];
	[self.popOver setPopoverContentSize:CGSizeMake(300, 300) animated:YES];

	[self.popOver presentPopoverFromRect:[infoButton frame] inView:self.view permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
}
@end
