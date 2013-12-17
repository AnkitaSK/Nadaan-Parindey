//
//  NPAppManager.h
//  NadaanParindey
//
//  Created by Pratima Gauns on 15/11/13.
//  Copyright (c) 2013 Marliza Viegas. All rights reserved.
//

#import <Foundation/Foundation.h>

#define letterA @"A"
#define letterB @"B"
#define letterC @"C"
#define letterD @"D"
#define letterE @"E"
#define letterF @"F"
#define letterG @"G"
#define letterH @"H"
#define letterI @"I"
#define letterJ @"J"
#define letterK @"K"
#define letterL @"L"
#define letterM @"M"
#define letterN @"N"
#define letterO @"O"
#define letterP @"P"
#define letterQ @"Q"
#define letterR @"R"
#define letterS @"S"
#define letterT @"T"
#define letterU @"U"
#define letterV @"V"
#define letterW @"W"
#define letterX @"X"
#define letterY @"Y"
#define letterZ @"Z"

//typedef enum letterState
//{
//    letterA, letterB,letterC,letterD,letterE,letterF,letterG,letterH,letterI,letterJ,letterK,letterL,letterM,letterN,letterO,letterP,letterQ,letterR,letterS,letterT,letterU,letterV,letterW,letterX,letterY,letterZ
//}letterStates;

@interface NPAppManager : NSObject
+ (id) sharedAppManager;
@property (nonatomic,retain) NSMutableArray *alphabetsArray;
@end
