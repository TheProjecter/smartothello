//
//  SmartOthelloController.h
//  Smart Othello
//
//  Created by Jucao Liang on 09-3-19.
//  Copyright 2009 Mobile Fun Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"
#import "SmartOthelloBoard.h"
#import "ComputerMove.h"

@interface SmartOthelloController : NSObject {
	// The game board.
	SmartOthelloBoard *board;
	
	// The view.
	UIView *view;
	
	// The timer.
	NSTimer *timer;
	
	// Game parameters.
	int gameState;
	int currentColor;
	int moveNumber;
	
	// AI parameters.
	int ForfeitWeight;
    int FrontierWeight;
    int MobilityWeight;
    int StabilityWeight;
    int LookAheadDepth;
	
	// Skill Level.
	int skillLevel;
	
	// Players selection
	int blackPlayer;
	int whitePlayer;
	
	// Defines an array for storing the move history. 
	NSMutableArray *moveHistory;

	// Used to track which player made the last move.
	int lastMoveColor;

	// Used to suspend computer play while moves are undone/redone.
	BOOL isComputerPlaySuspended;
	
	// Used to track the last move.
	int lastMoveRow;
	int lastMoveCol;
}

@property (nonatomic,assign) SmartOthelloBoard *board;
@property int lastMoveRow;
@property int lastMoveCol;
@property int lastMoveColor;
@property int currentColor;
@property int gameState;
@property BOOL isComputerPlaySuspended;

- (id)initWithView:(UIView *)v;
- (void)startGame;
- (void)restartGame;
- (void)endGame;
- (void)startTurn;
- (BOOL)isComputerPlayerForColor:(int)color;
- (void)makeMoveAtRow:(int)row Column:(int)col;
- (void)endMove;
- (void)makeComputerMoveAtRow:(int)row Column:(int)col;
- (void)makePlayerMoveAtRow:(int)row Column:(int)col;
- (void)calculateComputerMove:(NSTimer *)sender;
- (void)restoreGameAtStep:(int)step;
- (void)undoMove;
- (void)boardClickedAtRow:(int)row Column:(int)col;
- (enum SOBoardCellStatus)getsquareContentsAtRow:(int)row Column:(int)col;
- (BOOL)isValidMoveForColor:(int)color Row:(int)row Column:(int)col;
- (void)setSkillLevel:(int)level;
- (void)setBlackPlayer:(int)player;
- (void)setWhitePlayer:(int)player;
- (int)getBlackCount;
- (int)getWhiteCount;
// From Zyan's AI code
-(void) SetAILevel;
-(int) AdjustLookAheadDepth: (SmartOthelloBoard *) newBoard;
-(ComputerMove *) CalculateNextMove: (SmartOthelloBoard *) newBoard
                                  : (int) color
                                  : (int) depth
                                  : (int) alpha
                                  : (int) beta;
-(ComputerMove *) CalculateNextMove: (SmartOthelloBoard *)    newBoard;
// End from Zyan's AI code

@end