//
//  SmartOthelloBoard.h
//  Smart Othello
//
//  Created by Jucao Liang on 09-4-24, based on Zyan's SOBoardBasicImplementation.h
//  Copyright 2009 Mobile Fun Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

@interface SmartOthelloBoard : NSObject {
    enum SOBoardCellStatus Board[SO_BOARD_MAX_X][SO_BOARD_MAX_Y];
    BOOL SafeDiscs[SO_BOARD_MAX_X][SO_BOARD_MAX_Y];
    int BlackCount;
    int WhiteCount;
    int EmptyCount;
    int BlackFrontierCount;
    int WhiteFrontierCount;
    int BlackSafeCount;
    int WhiteSafeCount;
}

-(id) init;
-(id) initWithBoard: (SmartOthelloBoard*) board;
-(int) BlackCount;
-(int) WhiteCount;
-(int) EmptyCount;
-(int) BlackFrontierCount;
-(int) WhiteFrontierCount;
-(int) BlackSafeCount;
-(int) WhiteSafeCount;
-(void) ResetBoard;

-(enum SOBoardCellStatus) GetCellStatus: (int) row : (int) col;
-(BOOL) IsDiscSafe: (int) row: (int) col;
-(void) MakeMove: (BOOL) isBlack
              At: (int) row : (int) col;
-(BOOL) HasValidMove: (BOOL) isBlack;
-(enum SOBoardMoveResult) IsValidMove: (BOOL) isBlack
                                 At: (int) row : (int) col;
-(int) GetValidMoveCount: (BOOL) isBlack;

-(SmartOthelloBoard*) Clone;


/**
 ********************************
 */
-(void) UpdateCounts;
-(BOOL) IsOutFlanking: (BOOL) isBlack
                   At: (int) row : (int) col
                Delta: (int) dr : (int) dc;
-(BOOL) IsOutFlankable: (int) row : (int) col;
@end