//
//  MoveRecord.m
//  Smart Othello
//
//  Created by Jucao Liang on 09-3-19.
//  Copyright 2009 Mobile Fun Studio. All rights reserved.
//

#import "MoveRecord.h"

@implementation MoveRecord
@synthesize board;
@synthesize color;

- (id)initWithBoard:(SmartOthelloBoard *)newBoard Color:(int)newColor {
    if (self = [super init]) {
        // Initialization code
		board = [[SmartOthelloBoard alloc] initWithBoard:newBoard];
		color = newColor;
    }
    return self;
}

- (void)dealloc {
	[board release];
    [super dealloc];
}

@end