//
//  NPAlphabetViewController.m
//  NadaanParindey
//
//  Created by Marliza Viegas on 25/10/13.
//  Copyright (c) 2013 Marliza Viegas. All rights reserved.
//

#import "NPAlphabetViewController.h"
#import "NPAppManager.h"

#define ALPHABETFILE @"AlphabetFile"
#define PLIST @"plist"
#define DictionaryName @"Letters"
#define X @"X"
#define Y @"Y"
#define W @"W"
#define H @"H"

CGRect rectPoint [10];
int currentStateCount; // to keep track of current alphabet

@interface NPAlphabetViewController ()
@property (retain, nonatomic) IBOutlet UIButton *nextButton;
@property (retain, nonatomic) IBOutlet UIButton *previousButton;

@property (nonatomic, readwrite) BOOL  didVisitPointOne;
@property (nonatomic, readwrite) BOOL  didVisitPointTwo;
@property (nonatomic, readwrite) BOOL  didVisitPointThree;
@property (nonatomic, readwrite) BOOL  didVisitPointFour;
@property (nonatomic, readwrite) BOOL  didVisitPointFive;
@property (nonatomic, readwrite) BOOL  didVisitPointSix;

@property (nonatomic,strong) NPCustomLetterImage *customLetter;
@property (nonatomic, retain) NSMutableArray *letterSizeArray;
@property (nonatomic, retain) NPAppManager *appManager;

@property (nonatomic,retain) NSString * currentLetter;
@property (nonatomic,retain) UIImage * letterImage;

@property (nonatomic,retain) NSMutableArray * visitedPointsArray;
@end

@implementation NPAlphabetViewController

@synthesize star1;
@synthesize star2;
@synthesize star3;
@synthesize teacherImg;
@synthesize chimeSound;
@synthesize appleSound;
@synthesize applauseSound;
@synthesize appleImg;
@synthesize redCross;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

        self.letterSizeArray = [[NSMutableArray alloc] init];
        
        // make use of singleton class
        self.appManager = [[NPAppManager sharedAppManager]init];
    }
    return self;
}

-(void) viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	UIColor *backColor = [UIColor colorWithRed:80/255.0 green:173/255.0 blue:217/255.0 alpha:1];
    //UIColor *backColor = [UIColor colorWithRed:80/255.0 green:173/255.0 blue:217/255.0 alpha:0.3];
	self.view.backgroundColor = backColor;
    
    // for letter A
    [self retrivePointsFromPlistForLetter:[self.appManager.alphabetsArray objectAtIndex:currentStateCount]];
    self.customLetter = [[NPCustomLetterImage alloc] initWithImage:self.letterImage];
    [self.alphaAView addSubview:self.customLetter];

    // retrive from plist
    self.currentLetter = letterA;
    
	[self addGreyStars];
	[self playSoundChime];
	[self playSoundApple];
	[self playApplause];
	
	self.allHitPointsArray = [[NSMutableArray alloc] init];
    self.allMissPointsArray = [[NSMutableArray alloc] init];
}

-(void) retrivePointsFromPlistForLetter: (NSString *) letter
{
    //self.currentLetter = letter;
    
    NSDictionary *dictRoot = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:ALPHABETFILE ofType:PLIST]];
    
    // pull dict out of it
    NSDictionary *dictList = [dictRoot objectForKey:DictionaryName];
    
    // pull values from Letters passed eg: 'A'
    NSArray *letterInfoData = [NSArray arrayWithArray:[dictList objectForKey:letter]];
    NSMutableArray * pointsX = [[NSMutableArray alloc] init];
    NSMutableArray * pointsY = [[NSMutableArray alloc] init];
    NSMutableArray * pointsW = [[NSMutableArray alloc] init];
    NSMutableArray * pointsH = [[NSMutableArray alloc] init];
    
    self.visitedPointsArray = [[NSMutableArray alloc] init];
    
    self.letterImage = [UIImage imageNamed:[letterInfoData objectAtIndex:0]];
    for (int i=1; i< letterInfoData.count; i++)
    {
        NSMutableDictionary *details = [letterInfoData objectAtIndex:i];
        [pointsX addObject:[details objectForKey:X]];
        [pointsY addObject:[details objectForKey:Y]];
        [pointsW addObject:[details objectForKey:W]];
        [pointsH addObject:[details objectForKey:H]];
        
        rectPoint [i] = CGRectMake(0, 0, 0, 0); // reset rectPoint array
        
    }
    
    for (int l=0; l<pointsX.count; l++)
    {
        [self.visitedPointsArray addObject:@(0)];
    }
    
    NSLog(@"Check for array: %@", self.visitedPointsArray);
    for (int j= 0; j< pointsX.count; j++) // take count of any array
    {
        rectPoint [j] = CGRectMake([[pointsX objectAtIndex:j] floatValue], [[pointsY objectAtIndex:j] floatValue], [[pointsW objectAtIndex:j] floatValue], [[pointsH objectAtIndex:j] floatValue]);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showHome:(id)sender {
	
    [self clearView:nil];
    [self resetValues];
	[self.navigationController popToRootViewControllerAnimated:YES];
}


- (void)animateApple{
	AudioServicesPlaySystemSound(self.appleSound);
    
	self.appleImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Apple.png"]];
	self.appleImg.frame = CGRectMake(0, 0, 200, 200);
	
	self.appleImg.transform = CGAffineTransformMakeTranslation(500, 0);
	[UIView beginAnimations:@"fadeInNewView" context:NULL];
	[UIView setAnimationDuration:0.4];
	self.appleImg.transform = CGAffineTransformMakeTranslation(500,400);
	self.appleImg.alpha = 1.0f;
	[UIView commitAnimations];
	
	[self.view addSubview:self.appleImg];
	
}

- (void)animateRedCross{
	
	self.redCross = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Red_Cross.png"]];
	self.redCross.frame = CGRectMake(700, 400, 200, 200);
	
	self.redCross.transform = CGAffineTransformMakeScale(0.1, 0.1);
	[UIView beginAnimations:@"fadeInNewView" context:NULL];
	[UIView setAnimationDuration:0.2];
	self.redCross.transform = CGAffineTransformMakeScale(1,1);
	self.redCross.alpha = 1.0f;
	[UIView commitAnimations];
	
	[self.view addSubview:self.redCross];
	
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

# pragma mark -- NPCustomSensitiveView Delegate methods
- (void) touchesEndedByWithHitPoints:(NSMutableArray *)hitPoints MissedPoints:(NSMutableArray *)missedPoints
{
    int trackCount;
    NSLog(@"array counts %d, %d", hitPoints.count, self.allHitPointsArray.count);
	[self.allHitPointsArray addObjectsFromArray:hitPoints];
	
	NSInteger keyPoints = 0;
    
    for (int k =0 ; k< self.visitedPointsArray.count; k++)
    {
        for (int i =0; i< [hitPoints count]; i++)
        {
            NSValue *val = [hitPoints objectAtIndex:i];
            CGPoint point = [val CGPointValue];
            
            if (CGRectContainsPoint(rectPoint [k], point))
            {
                //
                [self.visitedPointsArray replaceObjectAtIndex:k withObject:@(1)];
            }
        }
    }
	
    for (int i =0; i< self.visitedPointsArray.count; i++)
    {
        if ([[self.visitedPointsArray objectAtIndex:i] isEqual:@(0)])
        {
            break;
        }
        else
        {
            if ([[self.visitedPointsArray objectAtIndex:i] isEqual:@(1)] && i!= self.visitedPointsArray.count-1)
            {
                continue;
            }
            else
            {
                if ([[self.visitedPointsArray objectAtIndex:i] isEqual:@(1)])
                {
                    [self validateWithNoOfHits:[hitPoints count] NoOfMisses:[missedPoints count]];
                }
            }
        }
        
    }
    
    [hitPoints removeAllObjects];
    [missedPoints removeAllObjects];
}

-(void) touchBeginByWithHitPoint
{
    [self.nextButton setEnabled:NO];
    [self.previousButton setEnabled:NO];
}

- (void) validateWithNoOfHits:(NSInteger)noOfHits NoOfMisses:(NSInteger) noOfMisses{
	
//	if (noOfMisses == 0) {
//		NSLog(@"3 stars");
//		[self addGoldStar:3];
//	}
//	else if (noOfMisses > 0 && noOfMisses < 100){
//		NSLog(@"2 stars");
//		[self addGoldStar:2];
//        
//	}
//	else if (noOfMisses > 100 && noOfMisses < 150){
//		NSLog(@"1 star");
//		[self addGoldStar:1];
//        
//	}
//	else if (noOfMisses > 150){
//		NSLog(@"No star");
//		[self addGoldStar:0];
//        
//	}
    
    
    if (noOfMisses == 0) {
		NSLog(@"3 stars");
		[self addGoldStar:3];
	}
	else if (noOfMisses > 0 && noOfMisses < 10){
		NSLog(@"2 stars");
		[self addGoldStar:2];
        
	}
	else if (noOfMisses > 10 && noOfMisses < 15){
		NSLog(@"1 star");
		[self addGoldStar:1];
        
	}
	else if (noOfMisses > 30){
		NSLog(@"No star");
		[self addGoldStar:0];
        
	}

    
    
    [self resetValues];
    [self.nextButton setEnabled:YES];
    [self.previousButton setEnabled:YES];
}


-(void)addGoldStar:(NSInteger)starsNum{
	
	if (starsNum == 1) {
        self.star1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"star1.png"]];
		self.star1.alpha = 0.0;
		[self.star1 setFrame:CGRectMake(500, 150, 100, 100)];
        
		[self.view addSubview:self.star1];
		[self animateStar:self.star1];
		[self performSelector:@selector(animateApple) withObject:nil afterDelay:5.0];
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
		[self performSelector:@selector(animateApple) withObject:nil afterDelay:5.0];
        
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
		[self performSelector:@selector(animateApple) withObject:nil afterDelay:5.0];
        
	}
	else if (starsNum == 0) {
        
		[self performSelector:@selector(animateRedCross) withObject:nil afterDelay:5.0];
        
	}
    
   
	AudioServicesPlaySystemSound(self.applauseSound);
    
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

-(void) playSoundApple {
	NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"appleSound" ofType:@"m4a"];
	NSURL *soundURL = [NSURL fileURLWithPath:soundPath];
	AudioServicesCreateSystemSoundID((CFURLRef)soundURL, &appleSound);
	
}

-(void)playApplause{
	NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"applause-1" ofType:@"mp3"];
	NSURL *soundURL = [NSURL fileURLWithPath:soundPath];
	AudioServicesCreateSystemSoundID((CFURLRef)soundURL, &applauseSound);
    
}

- (void)dealloc {
	[teacherImg release];
	[_clear release];
    [_nextButton release];
    [_previousButton release];
	[super dealloc];
}
- (void)viewDidUnload {
	[self setTeacherImg:nil];
	[super viewDidUnload];
}
- (IBAction)clearView:(id)sender {
    //[self resetValues];
	[self.star1 removeFromSuperview];
	[self.star2 removeFromSuperview];
	[self.star3 removeFromSuperview];
	[self.appleImg removeFromSuperview];
	[self.redCross removeFromSuperview];
}

- (IBAction)goToNextLetter:(UIButton *)sender
{
   
    [self clearView:nil];
    [self.alphaAView.path removeAllPoints];
    
    [self.alphaAView setNeedsDisplay];
    
     NSLog(@"current letter: %@", self.currentLetter);
    
    for (int i= [self.appManager.alphabetsArray indexOfObject:self.currentLetter]; i<[self.appManager.alphabetsArray count]; i++)
    {
        if (self.currentLetter == [self.appManager.alphabetsArray objectAtIndex:i])
        {
            [self.customLetter removeFromSuperview];
            // load next image view
            [self retrivePointsFromPlistForLetter:[self.appManager.alphabetsArray objectAtIndex:i+1]];
            
            self.customLetter = [[NPCustomLetterImage alloc] initWithImage:self.letterImage];
            [self.alphaAView addSubview:self.customLetter];
        }
    }
    
    currentStateCount ++;
    
    self.currentLetter = [self.appManager.alphabetsArray objectAtIndex:currentStateCount];
}

-(IBAction)previousLetter:(id)sender
{
  
    [self clearView:nil];
    [self.alphaAView.path removeAllPoints];
    [self.alphaAView setNeedsDisplay];
    
    NSLog(@"current letter: %@", self.currentLetter);
    for (int i= [self.appManager.alphabetsArray indexOfObject:self.currentLetter]; i> 0; i--)
    {
        if (self.currentLetter == [self.appManager.alphabetsArray objectAtIndex:i])
        {
            [self.customLetter removeFromSuperview];
            // load previous image view
            [self retrivePointsFromPlistForLetter:[self.appManager.alphabetsArray objectAtIndex:i-1]];
            
            self.customLetter = [[NPCustomLetterImage alloc] initWithImage:self.letterImage];
            [self.alphaAView addSubview:self.customLetter];
        }
    }
    
    currentStateCount --;
    
    if (currentStateCount >= 0)
    {
         self.currentLetter = [self.appManager.alphabetsArray objectAtIndex:currentStateCount];
    }

}

-(void) resetValues
{
    self.didVisitPointOne = FALSE;
    self.didVisitPointTwo = FALSE;
    self.didVisitPointThree = FALSE;
    self.didVisitPointFour = FALSE;
    self.didVisitPointFive = FALSE;
    self.didVisitPointSix = FALSE;
	

    [self.allHitPointsArray removeAllObjects];
    [self.allMissPointsArray removeAllObjects];
}
@end
