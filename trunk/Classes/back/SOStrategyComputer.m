#import <time.h>
#import <math.h>
#import <stdlib.h>
#import "SOStrategyComputer.h"

#define MAX_INT  (int)((unsigned int)(-1) >> 1)
#define MAX_RANK (MAX_INT - 64)

@implementation SOStrategyComputer
-(void) SetAILevel: (enum SOStrategyComputerAILevel) level {
   switch (level) {
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
   Difficulty     = level;
   LookAheadDepth = level + 3;
}

-(id) initWithAILevel: (enum SOStrategyComputerAILevel) level {
   self = [super init];
   if(self) {
      [self SetAILevel: level];
   }
   return self;

}

-(id) init {
   self = [super init];
   if (self) {
      [self SetAILevel: kSOAIBeginner];
   }
   return self;
}

-(int) AdjustLookAheadDepth: (id <SOBoardInterface>) board
{
   // in the beginning, we have 4 pieces
   int emptyCount = [board EmptyCount];
   int moveCount  = SO_BOARD_MAX_X * SO_BOARD_MAX_Y - emptyCount -4;
   LookAheadDepth = Difficulty + 3;
   if (moveCount >= 55 - Difficulty) {
      LookAheadDepth = emptyCount;
   }
   return LookAheadDepth;
}

-(struct SOMove) CalculateNextMove: (id <SOBoardInterface>)    board
                           Against: (enum SOBoardCellStatus)   opponentColor
{
   int alpha = MAX_RANK + 64;
   int beta  = -alpha;
   [self AdjustLookAheadDepth: board];
   return [self CalculateNextMove: board
                                 : -opponentColor
                                 : 1
                                 : alpha
                                 : beta].Move;
}

-(struct SOComputerMove) CalculateNextMove: (id <SOBoardInterface>) board
                                  : (int) color
                                  : (int) depth
                                  : (int) alpha
                                  : (int) beta 
{
   // Rank is set to -color * MAX_RANK
   // Move is set to -1, -1
   struct SOComputerMove bestMove
      = { {-1, -1}, -color * MAX_RANK};

   // Find out how many valid moves we have so we can initialize the
   // mobility score.
   int validMoves = [board GetValidMoveCount: color == kSOBlack];

   // Start at a random position on the board. This way, if two or
   // more moves are equally good, we'll take one of them at random.
   srand(time(NULL));
   int rowStart = rand() * 8.0 / RAND_MAX;
   int colStart = rand() * 8.0 / RAND_MAX;

   // Check all valid moves.
   int i, j;
   for (i = 0; i < 8; i++)
      for (j = 0; j < 8; j++)
      {
         // Get the row and column.
         int row = (rowStart + i) % 8;
         int col = (colStart + j) % 8;

         if ([board IsValidMove: color == kSOBlack
                             At: row : col])
         {

            // Make the move. 
            struct SOComputerMove testMove = {{row, col}};
            SOBoardInterfaceObject testBoard = [board Clone];
            int score = [testBoard WhiteCount] - [testBoard BlackCount];

            // Check the board.
            int nextColor = -color;
            int forfeit = 0;
            BOOL isEndGame = FALSE;

            [testBoard MakeMove: color == kSOBlack
                             At: testMove.Move.row : testMove.Move.col];

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
                  isEndGame = TRUE;
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
                     testMove.Rank = - MAX_RANK + score;

                  // Positive value for white win.
                  else if (score > 0)
                     testMove.Rank = MAX_RANK + score;

                  // Zero for a draw.
                  else
                     testMove.Rank = 0;
               }

               // It's not an end game so calculate the move rank.
               else
                  testMove.Rank =
                     ForfeitWeight * forfeit +
                     FrontierWeight  * ([testBoard BlackFrontierCount] - [testBoard WhiteFrontierCount]) +
                     MobilityWeight  * color * (validMoves - opponentValidMoves) +
                     StabilityWeight * ([testBoard WhiteSafeCount] - [testBoard BlackSafeCount]) +
                     score;
            }

            // Otherwise, perform a look ahead.
            else
            {
               struct SOComputerMove nextMove = [self CalculateNextMove: testBoard
                                                              : nextColor
                                                              : depth + 1
                                                              : alpha
                                                              : beta];

               // Pull up the rank.
               testMove.Rank = nextMove.Rank;

               // Forfeits are cumulative, so if the move did not
               // result in an end game, add any current forfeit
               // value to the rank.
               if (forfeit != 0 && abs(testMove.Rank) < MAX_RANK)
                  testMove.Rank += ForfeitWeight * forfeit;

               // Adjust the alpha and beta values, if necessary.
               if (color == kSOWhite && testMove.Rank > beta)
                  beta = testMove.Rank;
               if (color == kSOBlack && testMove.Rank < alpha)
                  alpha = testMove.Rank;
            }

            // Perform a cutoff if the rank is outside tha alpha-beta range.
            if (color == kSOWhite && testMove.Rank > alpha)
            {
               testMove.Rank = alpha;
               return testMove;
            }
            if (color == kSOBlack && testMove.Rank < beta)
            {
               testMove.Rank = beta;
               return testMove;
            }

            // If this is the first move tested, assume it is the
            // best for now.
            if (bestMove.Move.row < 0)
               bestMove = testMove;

            // Otherwise, compare the test move to the current
            // best move and take the one that is better for this
            // color.
            else if (color * testMove.Rank > color * bestMove.Rank)
               bestMove = testMove;
            [testBoard release];
         }
      }

   // Return the best move found.
   return bestMove;
}

@end
