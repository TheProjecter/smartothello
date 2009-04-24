//
//  ComputerMove.h
//  Smart Othello
//
//  Created by Jucao Liang on 09-3-19.
//  Copyright 2009 Mobile Fun Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

// Defines a class for holding a look ahead move and rank.
@interface ComputerMove : NSObject {
	int row;
	int col;
	int rank;
}
@property int row;
@property int col;
@property int rank;
- (id)initWithRow:(int)newRow Column:(int)newCol;
@end