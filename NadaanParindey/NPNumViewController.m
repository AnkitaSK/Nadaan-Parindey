//
//  NPNumViewController.m
//  NadaanParindey
//
//  Created by Marliza Viegas on 25/10/13.
//  Copyright (c) 2013 Marliza Viegas. All rights reserved.
//

#import "NPNumViewController.h"

CGRect  rectPoint1;
CGRect  rectPoint2;
CGRect  rectPoint3;
CGRect  rectPoint4;
CGRect  rectPoint5;
CGRect  rectPoint6;

@interface NPNumViewController ()
@property (nonatomic, readwrite) BOOL  didVisitPointOne;
@property (nonatomic, readwrite) BOOL  didVisitPointTwo;
@property (nonatomic, readwrite) BOOL  didVisitPointThree;
@property (nonatomic, readwrite) BOOL  didVisitPointFour;
@property (nonatomic, readwrite) BOOL  didVisitPointFive;

@end

@implementation NPNumViewController
@synthesize chimeSound;
@synthesize teacherImg;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
		rectPoint1  = CGRectMake(142, 64, 60, 60);
		rectPoint2  = CGRectMake(228, 56, 60, 60);
		rectPoint3  = CGRectMake(233, 384, 60, 60);
		rectPoint4  = CGRectMake(152, 390, 60, 60);
		rectPoint5  = CGRectMake(315, 383, 60, 60);

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	UIColor *backColor = [UIColor colorWithRed:80/255.0 green:173/255.0 blue:217/255.0 alpha:1];
	self.view.backgroundColor = backColor;
	[self addGreyStars];
	[self playSoundChime];
	
	self.allHitPoints = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showHome:(id)sender {
	
	[self.navigationController popToRootViewControllerAnimated:YES];
}


- (void)animateRedCross{
	
	UIImageView *redCross = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Red_Cross.png"]];
	redCross.frame = CGRectMake(500, 375, 200, 200);
	
	redCross.transform = CGAffineTransformMakeScale(0.1, 0.1);
	[UIView beginAnimations:@"fadeInNewView" context:NULL];
	[UIView setAnimationDuration:0.4];
	redCross.transform = CGAffineTransformMakeScale(1,1);
	redCross.alpha = 1.0f;
	[UIView commitAnimations];
	
	[self.view addSubview:redCross];
	
}

- (void)addGreyStars{
	
	UIImageView *greyImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"greyStarwe.png"]];
	[self.view addSubview:greyImage];
	
	[greyImage setFrame:CGRectMake(500, 150, 100, 100)];
	
	UIImageView *greyImage2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"greyStarwe.png"]];
	[self.view addSubview:greyImage2];
	
	[greyImage2 setFrame:CGRectMake(650, 120, 100, 100)];
	
	self.greyImage3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"greyStarwe.png"]];
	[self.view addSubview:self.greyImage3];
	
	[self.greyImage3 setFrame:CGRectMake(800, 150, 100, 100)];
	
	
}


- (void) touchesEndedByWithHitPoints:(NSMutableArray *)hitPoints MissedPoints:(NSMutableArray *)missedPoints{
	[self.allHitPoints addObjectsFromArray:hitPoints];
	
	NSInteger keyPoints = 0;
	
	for (int i = 0; i < [hitPoints count]; i++) {
		NSValue *val = [hitPoints objectAtIndex:i];
		CGPoint point = [val CGPointValue];
		
		if (!self.didVisitPointOne) {
			if (CGRectContainsPoint(rectPoint1, point)) {
				self.didVisitPointOne = TRUE;
				NSLog(@"Point One");
			}
		}
		
		if (!self.didVisitPointTwo) {
			if (CGRectContainsPoint(rectPoint2, point)) {
				self.didVisitPointTwo = TRUE;
				NSLog(@"Point Two");
			}
		}
		
		if (!self.didVisitPointThree) {
			if (CGRectContainsPoint(rectPoint3, point)) {
				self.didVisitPointThree = TRUE;
				NSLog(@"Point Three");
			}
		}
		
		if (!self.didVisitPointFour) {
			if (CGRectContainsPoint(rectPoint4, point)) {
				self.didVisitPointFour = TRUE;
				NSLog(@"Point Four");
			}
		}
		
		if (!self.didVisitPointFive) {
			if (CGRectContainsPoint(rectPoint5, point)) {
				self.didVisitPointFive = TRUE;
				NSLog(@"Point Five");
			}
		}
		
				
		
		
	}
	if (self.didVisitPointOne && self.didVisitPointTwo && self.didVisitPointThree && self.didVisitPointFour && self.didVisitPointFive ) {
		// validate now
		NSLog(@"Vlidate now");
		[self validateWithNoOfHits:[hitPoints count] NoOfMisses:[missedPoints count]];
	}
	
}

- (void) validateWithNoOfHits:(NSInteger)noOfHits NoOfMisses:(NSInteger) noOfMisses{
	
	if (noOfMisses == 0) {
		NSLog(@"3 stars");
		[self addGoldStar:3];
	}
	else if (noOfMisses > 0 && noOfMisses < 25){
		NSLog(@"2 stars");
		[self addGoldStar:2];
		
	}
	else if (noOfMisses > 25 && noOfMisses < 40){
		NSLog(@"1 star");
		[self addGoldStar:1];
		
	}
	else if (noOfMisses > 40){
		NSLog(@"No star");
		[self addGoldStar:0];
		
	}
}


-(void)addGoldStar:(NSInteger)starsNum{
	
	if (starsNum == 1) {
		self.star1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"star1.png"]];
		self.star1.alpha = 0.0;
		[self.star1 setFrame:CGRectMake(500, 150, 100, 100)];
		
		[self.view addSubview:self.star1];
		[self animateStar:self.star1];
//		[self performSelector:@selector(animateApple) withObject:nil afterDelay:5.0];
	}
	else if (starsNum == 2) {
		self.star1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"star1.png"]];
		self.star1.alpha = 0.0;
		[self.star1 setFrame:CGRectMake(500, 150, 100, 100)];
		
		[self.view addSubview:self.star1];
		[self animateStar:self.star1];
		
		self.star2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"star1.png"]];
		[self performSelector:@selector(animateStar:) withObject:self.star2 afterDelay:1.0];
		self.star2.alpha = 0.0;
		[self.star2 setFrame:CGRectMake(650, 120, 100, 100)];
		
		[self.view addSubview:self.star2];
//		[self performSelector:@selector(animateApple) withObject:nil afterDelay:5.0];
		
	}
	else if (starsNum == 3) {
		self.star1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"star1.png"]];
		self.star1.alpha = 0.0;
		[self.star1 setFrame:CGRectMake(500, 150, 100, 100)];
		
		[self.view addSubview:self.star1];
		[self animateStar:self.star1];
		
		self.star2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"star1.png"]];
		[self performSelector:@selector(animateStar:) withObject:self.star2 afterDelay:1.0];
		self.star2.alpha = 0.0;
		[self.star2 setFrame:CGRectMake(650, 120, 100, 100)];
		[self.view addSubview:self.star2];
		
		self.star3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"star1.png"]];
		[self performSelector:@selector(animateStar:) withObject:self.star3 afterDelay:2.0];
		self.star3.alpha = 0.0;
		[self.star3 setFrame:CGRectMake(800, 150, 100, 100)];
		
		[self.view addSubview:self.star3];
//		[self performSelector:@selector(animateApple) withObject:nil afterDelay:5.0];
		
	}
	else if (starsNum == 0) {
		
		[self performSelector:@selector(animateRedCross) withObject:nil afterDelay:2.0];
		
	}
}

-(void)animateStar:(UIView*)starView{
	
	AudioServicesPlaySystemSound(self.chimeSound);
	
	starView.alpha = 1;
	starView.transform = CGAffineTransformMakeScale(0.1,0.1);
	[UIView beginAnimations:@"fadeInNewView" context:NULL];
	[UIView setAnimationDuration:0.4];
	starView.transform = CGAffineTransformMakeScale(1,1);
	starView.alpha = 1.0f;
	[UIView commitAnimations];
	
}


-(void) playSoundChime {
	NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"magic-chime-02" ofType:@"mp3"];
	NSURL *soundURL = [NSURL fileURLWithPath:soundPath];
	AudioServicesCreateSystemSoundID((CFURLRef)soundURL, &chimeSound);
	
}
- (void)dealloc {
	[teacherImg release];
	[_numViewOne release];
	[super dealloc];
}
- (void)viewDidUnload {
	[self setTeacherImg:nil];
	[self setNumViewOne:nil];
	[super viewDidUnload];
}

@end
