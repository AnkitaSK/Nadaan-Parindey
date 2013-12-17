//
//  NPCustomLetterA.m
//  NadaanParindey
//
//  Created by Pratima Gauns on 15/11/13.
//  Copyright (c) 2013 Marliza Viegas. All rights reserved.
//

#import "NPCustomLetterImage.h"

@implementation NPCustomLetterImage

//- (id)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        self.backgroundColor = [UIColor clearColor];
//        self.image = [UIImage imageNamed:@"Bold_A.png"];
//    }
//    return self;
//}

-(id) initWithImage:(UIImage *)image
{
    self = [super initWithImage:image];
    if (self)
    {
        self.image = image;
    }
    
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
