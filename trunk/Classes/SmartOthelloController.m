//
//  SmartOthelloController.m
//  Smart Othello
//
//  Created by Jucao Liang on 09-3-19.
//  Copyright 2009 Mobile Fun Studio. All rights reserved.
//

#import <stdlib.h>
#import <time.h>
#import <math.h>
#import "SmartOthelloController.h"
#import "MoveRecord.h"

@implementation SmartOthelloController
@synthesize board;
@synthesize lastMoveRow;
@synthesize lastMoveCol;
@synthesize lastMoveColor;
@synthesize currentColor;
@synthesize gameState;
@synthesize isComputerPlaySuspended;

- (id)init {
    if (self = [super init]) {
        // Initialization code
		// Create the game board.
		board = [[SmartOthelloBoard alloc] init];
		
		// Initialize the game state.
		gameState = GameOver;
		
		// Initialize the last move.
		lastMoveRow = 0;
		lastMoveCol = 0;
	}
	return self;
}

- (id)initWithView:(UIView *)v {
    if (self = [super init]) {
        // Initialization code
		// Create the game board.
		board = [[SmartOthelloBoard alloc] init];
		
		view = v;
		
		// Initialize the game state.
		gameState = GameOver;
		
		// Initialize the last move.
		lastMoveRow = 0;
		lastMoveCol = 0;
	}
	return self;
}


- (void)startGame {
	// Initialize the move list.
	moveNumber = 1;
	
	// Initialize the move history.
	if(moveHistory != nil) {
		[moveHistory release];
		moveHistory = [[NSMutableArray alloc] init];
	}
	else {
		moveHistory = [[NSMutableArray alloc] init];
	}
	
	// Initialize the last move color.
	lastMoveColor = kSOWhite;
	
	// Clear the suspend computer play flag.
	isComputerPlaySuspended = NO;
	
	// Initialize the board.
	[board ResetBoard];
	[view setNeedsDisplay];
	
	// Set the first player, always let black to start the game.
	currentColor = kSOBlack;
	
	// Start the first turn.
	[self startTurn];
}

- (void)restartGame {
	// Start the first turn.
	[self startTurn];
}

- (void)endGame {
	// Set the game state.
	gameState = GameOver;
	
	// For a computer vs. user game, determine who played what color.
	int computerColor = kSOEmpty;
	int userColor     = kSOEmpty;
	if ([self isComputerPlayerForColor:kSOBlack] && ![self isComputerPlayerForColor:kSOWhite])
	{
		computerColor = kSOBlack;
		userColor = kSOWhite;
	}
	if ([self isComputerPlayerForColor:kSOWhite] && ![self isComputerPlayerForColor:kSOBlack])
	{
		computerColor = kSOWhite;
		userColor = kSOBlack;
	}
	
	// Update the status message. ??? definitely we need to tell the player who wins the game, currently not support
	if ([ board BlackCount] > [board WhiteCount]) {
		// "Black wins.";
	}
	else if ([board WhiteCount] > [board BlackCount]) {
		// "White wins.";
	}
	else {
		// "Draw.";
	}
}

- (void)startTurn {
	// If the current player cannot make a valid move, forfeit the turn.
	if (![board HasValidMove: currentColor == kSOBlack]) {
		// Switch back to the other player.
		currentColor *= (-1);
		
		// If the original player cannot make a valid move either, the game is over.
		if (![board HasValidMove: currentColor == kSOBlack]) {
			[self endGame];
			return;
		}
	}
	
	// Set the player text for the status display.
	
	// Update the turn display.
	
	// If the current color is under computer control, set up for a
	// computer move.
	if ([self isComputerPlayerForColor:currentColor]) {
		// Set the game state.
		gameState = InComputerMove;
		
		// Check if computer play is currently suspended.
		if (isComputerPlaySuspended) {
		}
		else {
			// calculate the computer move
			timer = [NSTimer scheduledTimerWithTimeInterval:1.0
													  target:self
													selector:@selector(calculateComputerMove:)
													userInfo:nil
													 repeats:NO];
		}
	}
	// Otherwise, set up for a user move.
	else {
		// Set the game state.
		gameState = InPlayerMove;
	}
}

- (BOOL)isComputerPlayerForColor:(int)color {
	return ((color == kSOBlack && blackPlayer == PlayerComputer) || (color == kSOWhite && whitePlayer == PlayerComputer));
}

- (void)makeMoveAtRow:(int)row Column:(int)col {
	// Clean up the move history to ensure that it contains only the
	// moves made prior to this one.
	while ([moveHistory count] > (moveNumber - 1))
		[moveHistory removeObjectAtIndex:([moveHistory count] - 1)];
	
	// Add this move to the move history.
	MoveRecord *moveRecord = [[[MoveRecord alloc] initWithBoard:board Color:currentColor] autorelease];
	[moveHistory addObject:moveRecord];
	
	// Bump the move number.
	moveNumber++;
	
	// Make the move on the board.
	[board MakeMove: currentColor == kSOBlack
                 At: row : col];
	
	// Update the display to reflect the board changes.
	[view setNeedsDisplay];
	
	// Save the player color.
	lastMoveColor = currentColor;
	
	// Save the last move position.
	lastMoveRow = row;
	lastMoveCol = col;
	
	//end the move
	[self endMove];
}

- (void)endMove {
	// Set the game state.
	gameState = MoveCompleted;

	// Switch players and start the next turn.
	currentColor *= (-1);
	[self startTurn];
}

- (void)makeComputerMoveAtRow:(int)row Column:(int)col {
	// Make the move.
	[self makeMoveAtRow:row Column:col];
}

- (void)makePlayerMoveAtRow:(int)row Column:(int)col {
	// Allow the computer to resume play.
	isComputerPlaySuspended = NO;

	// Make the move.
	[self makeMoveAtRow:row Column:col];
}

- (void)calculateComputerMove:(NSTimer *)sender {
	// Load the AI parameters.
	[self SetAILevel];

	// Find the best available move.
	ComputerMove *move = [self CalculateNextMove:board];

	// Perform a callback to make the move.
	[self makeComputerMoveAtRow:[move row] Column:[move col]];
}

- (void)restoreGameAtStep:(int)step {
	// Get the move record.
	MoveRecord *moveRecord = (MoveRecord *)[moveHistory objectAtIndex:step];
	
	// Restore the board and update the display.
	if(board != nil) {
		[board release];
		board = [[SmartOthelloBoard alloc] initWithBoard:moveRecord.board];
	}
	[view setNeedsDisplay];
	
	// Restore the current player.
	currentColor = moveRecord.color;
	
	// Set the current move number.
	moveNumber = step + 1;
	
	// Suspend computer play.
	isComputerPlaySuspended = YES;
}

- (void)undoMove {
	// Can't undo in the initial state.
	if (moveNumber < 2)
		return;
	
	// Save the current game state so we'll know if we need to perform
	// a restart.
	int oldGameState = gameState;
	
	// When undoing the last move, we need to save the current
	// board and player color in the move history so that it can
	// be restored if the move is redone.
	if ([moveHistory count] < moveNumber) {
		// Add the data to the move history.
		MoveRecord *moveRecord = [[[MoveRecord alloc] initWithBoard:board Color:((-1)*lastMoveColor)] autorelease];
		[moveHistory addObject:moveRecord];
	}
	
	// Undo either the previous move or all moves.
	[self restoreGameAtStep:(moveNumber - 2)];
	
	// If the game was over, restore the statistics and restart it.
	if (oldGameState == GameOver) {
		[self restartGame];
	}
	// Otherwise, start play at that move.
	else
		[self startTurn];
}

- (void)boardClickedAtRow:(int)row Column:(int)col {	
	// Check the game state to ensure it's the user's turn.
	if (gameState != InPlayerMove)
		return;
		
	// If the move is valid, make it.
	if (kSOAvailable == [board IsValidMove: currentColor == kSOBlack At: row :col]) {
		// Make the move.
		[self makePlayerMoveAtRow:row Column:col];
	}
}

- (enum SOBoardCellStatus)getsquareContentsAtRow:(int)row Column:(int)col {
	return [board GetCellStatus: row :col];
}

- (BOOL)isValidMoveForColor:(int)color Row:(int)row Column:(int)col {
	return (kSOAvailable == [board IsValidMove: color == kSOBlack At: row :col]);
}

- (void)setSkillLevel:(int)level {
	skillLevel = level;
}

- (void)setBlackPlayer:(int)player {
	blackPlayer = player;
}

- (void)setWhitePlayer:(int)player {
	whitePlayer = player;
}

- (int)getBlackCount {
	return [board BlackCount];
}

- (int)getWhiteCount {
	return [board WhiteCount];
}

-(void) SetAILevel {
   int Difficulty = skillLevel;
   switch (Difficulty) {
      case kSOAIBeginner:
         ForfeitWeight      =  2;
         FrontierWeight     =  1;
         MobilityWeight     =  0;
         StabilityWeight    =  3;
         break;
      case kSOAIIntermediate:
         ForfeitWeight      =  3;
         FrontierWeight     =  1;
         MobilityWeight     =  0;
         StabilityWeight    =  5;
         break;
      case kSOAIAdvanced:
         ForfeitWeight      =  7;
         FrontierWeight     =  2;
         MobilityWeight     =  1;
         StabilityWeight    = 10;
         break;
      case kSOAIExpert:
         ForfeitWeight      = 35;
         FrontierWeight     = 10;
         MobilityWeight     =  5;
         StabilityWeight    = 50;
         break;
      default:
         ForfeitWeight      =  0;
         FrontierWeight     =  0;
         MobilityWeight     =  0;
         StabilityWeight    =  0;
         break;
   }

   LookAheadDepth = Difficulty + 3;
	
   // Near the end of the game, when there are relatively few moves
   // left, set the look-ahead depth to do an exhaustive search. ??? not support options yet
   if (moveNumber >= (55 - Difficulty))
      LookAheadDepth = [board EmptyCount];
}

-(int) AdjustLookAheadDepth: (SmartOthelloBoard *) newBoard
{
   // in the beginning, we have 4 pieces
   int emptyCount = [newBoard EmptyCount];
   int moveCount  = SO_BOARD_MAX_X * SO_BOARD_MAX_Y - emptyCount -4;
   LookAheadDepth = skillLevel + 3;
   if (moveCount >= 55 - skillLevel) {
      LookAheadDepth = emptyCount;
   }
   return LookAheadDepth;
}

-(ComputerMove *) CalculateNextMove: (SmartOthelloBoard *)    newBoard
{
   int alpha = MAX_RANK + 64;
   int beta  = -alpha;
   // [self AdjustLookAheadDepth: newBoard];
   return [self CalculateNextMove: newBoard
                                 : currentColor
                                 : 1
                                 : alpha
                                 : beta];
}

-(ComputerMove *) CalculateNextMove: (SmartOthelloBoard *) newBoard
                                  : (int) color
                                  : (int) depth
                                  : (int) alpha
                                  : (int) beta 
{
   // Rank is set to -color * MAX_RANK
   // Move is set to -1, -1
   ComputerMove *bestMove = [[[ComputerMove alloc] initWithRow:(-1) Column:(-1)] autorelease];
   bestMove.rank = -color * MAX_RANK;

   // Find out how many valid moves we have so we can initialize the
   // mobility score.
   int validMoves = [newBoard GetValidMoveCount: color == kSOBlack];

   // Start at a random position on the board. This way, if two or
   // more moves are equally good, we'll take one of them at random.
   int rowStart = arc4random() * 8.0 / RAND_MAX;
   int colStart = arc4random() * 8.0 / RAND_MAX;

   // Check all valid moves.
   int i, j;
   for (i = 0; i < 8; i++)
      for (j = 0; j < 8; j++)
      {
         // Get the row and column.
         int row = (rowStart + i) % 8;
         int col = (colStart + j) % 8;

         if (kSOAvailable == [newBoard IsValidMove: color == kSOBlack
                             At: row : col])
         {

            // Make the move. 
			ComputerMove *testMove = [[[ComputerMove alloc] initWithRow:row Column:col] autorelease];
			SmartOthelloBoard *testBoard = [[[SmartOthelloBoard alloc] initWithBoard:newBoard] autorelease];

            [testBoard MakeMove: color == kSOBlack
                             At: testMove.row : testMove.col];

            int score = [testBoard WhiteCount] - [testBoard BlackCount];

            // Check the board.
            int nextColor = -color;
            int forfeit = 0;
            BOOL isEndGame = NO;

            int opponentValidMoves = [testBoard GetValidMoveCount: nextColor == kSOBlack];
            if (opponentValidMoves == 0)
            {
               // The opponent cannot move, count the forfeit.
               forfeit = color;

               // Switch back to the original color.
               nextColor = -nextColor;

               // If that player cannot make a move either, the
               // game is over.
               if (![testBoard HasValidMove : nextColor == kSOBlack])
                  isEndGame = YES;
            }

            // If we reached the end of the look ahead (end game or
            // max depth), evaluate the board and set the move
            // rank.
            if (isEndGame || depth == LookAheadDepth)
            {
               // For an end game, max the ranking and add on the
               // final score.
               if (isEndGame)
               {
                  // Negative value for black win.
                  if (score < 0)
                     testMove.rank = - MAX_RANK + score;

                  // Positive value for white win.
                  else if (score > 0)
                     testMove.rank = MAX_RANK + score;

                  // Zero for a draw.
                  else
                     testMove.rank = 0;
               }

               // It's not an end game so calculate the move rank.
               else {
                  testMove.rank =
                     ForfeitWeight * forfeit +
                     FrontierWeight  * ([testBoard BlackFrontierCount] - [testBoard WhiteFrontierCount]) +
                     MobilityWeight  * color * (validMoves - opponentValidMoves) +
                     StabilityWeight * ([testBoard WhiteSafeCount] - [testBoard BlackSafeCount]) +
                     score;
               }
            }

            // Otherwise, perform a look ahead.
            else
            {
               ComputerMove *nextMove = [self CalculateNextMove: testBoard
                                                              : nextColor
                                                              : depth + 1
                                                              : alpha
                                                              : beta];

               // Pull up the rank.
               testMove.rank = nextMove.rank;

               // Forfeits are cumulative, so if the move did not
               // result in an end game, add any current forfeit
               // value to the rank.
               if (forfeit != 0 && abs(testMove.rank) < MAX_RANK)
                  testMove.rank += ForfeitWeight * forfeit;

               // Adjust the alpha and beta values, if necessary.
               if (color == kSOWhite && testMove.rank > beta)
                  beta = testMove.rank;
               if (color == kSOBlack && testMove.rank < alpha)
                  alpha = testMove.rank;
            }

            // Perform a cutoff if the rank is outside tha alpha-beta range.
            if (color == kSOWhite && testMove.rank > alpha)
            {
               testMove.rank = alpha;
               return testMove;
            }
            if (color == kSOBlack && testMove.rank < beta)
            {
               testMove.rank = beta;
               return testMove;
            }

            // If this is the first move tested, assume it is the
            // best for now.
            if (bestMove.row < 0)
               bestMove = testMove;

            // Otherwise, compare the test move to the current
            // best move and take the one that is better for this
            // color.
            else if (color * testMove.rank > color * bestMove.rank)
               bestMove = testMove;
         }
      }

   // Return the best move found.
   return bestMove;
}

- (void)dealloc {
	[timer invalidate];
	timer = nil;
	[board release];
	[moveHistory release];
    [super dealloc];
}

@end