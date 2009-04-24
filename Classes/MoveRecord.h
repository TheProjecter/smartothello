//
//  ComputerMove.h
//  Smart Othello
//
//  Created by Jucao Liang on 09-3-19.
//  Copyright 2009 Mobile Fun Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SmartOthelloBoard.h"

// Defines a class for holding move history data.
@interface MoveRecord : NSObject {
	SmartOthelloBoard *board;
	int color;
}
@property (nonatomic, retain) SmartOthelloBoard *board;
@property int color;
- (id)initWithBoard:(SmartOthelloBoard *)newBoard Color:(int)newColor;
@end