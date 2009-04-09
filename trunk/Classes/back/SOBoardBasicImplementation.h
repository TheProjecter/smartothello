#import <Foundation/NSObject.h>
#import "SOBoardInterface.h"

@interface SOBoardBasicImplementation: NSObject <SOBoardInterface> {
   @private
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
/**
 * Inherit from SOBoardInterface
 */
-(id) init;
-(id) initWithBoad: (id <SOBoardInterface>) board;
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

/**
 ********************************
 */
-(void) UpdateCounts;
-(BOOL) IsOutFlanking: (BOOL) isBlack
                   At: (int) row : (int) col
                Delta: (int) dr : (int) dc;
-(BOOL) IsOutFlankable: (int) row : (int) col;
@end
