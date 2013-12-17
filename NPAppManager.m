//
//  NPAppManager.m
//  NadaanParindey
//
//  Created by Pratima Gauns on 15/11/13.
//  Copyright (c) 2013 Marliza Viegas. All rights reserved.
//

#import "NPAppManager.h"



static NPAppManager * sharedAppManager = nil;
@implementation NPAppManager
+ (id) sharedAppManager{
	@synchronized(sharedAppManager){
		if (nil == sharedAppManager) {
			sharedAppManager = [[super alloc] init];
		}
	}
	
	return sharedAppManager;
}

- (id)init {
    self = [super init];
    if (self) {
    
        NSLog(@"App Manager has been initialized.");
        self.alphabetsArray = [[NSMutableArray alloc] initWithObjects:letterA,
                               letterB,
                               letterC,
                               letterD,
                               letterE,
                               letterF,
                               letterG,
                               letterH,
                               letterI,
                               letterJ,
                               letterK,
                               letterL,
                               letterM,
                               letterN,
                               letterO,
                               letterP,
                               letterQ,
                               letterR,
                               letterS,
                               letterT,
                               letterU,
                               letterV,
                               letterW,
                               letterX,
                               letterY,
                               letterZ, nil];
    }
    
   
    return self;
}
@end
