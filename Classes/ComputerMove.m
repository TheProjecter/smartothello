//
//  ComputerMove.m
//  Smart Othello
//
//  Created by Jucao Liang on 09-3-19.
//  Copyright 2009 Mobile Fun Studio. All rights reserved.
//

#import "ComputerMove.h"

@implementation ComputerMove
@synthesize row;
@synthesize col;
@synthesize rank;

- (id)initWithRow:(int)newRow Column:(int)newCol {
    if (self = [super init]) {
        // Initialization code
		row = newRow;
		col = newCol;
		rank = 0;
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}

@end