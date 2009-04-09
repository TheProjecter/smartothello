#import <Foundation/NSObject.h>
#import "BoardInterface.h"

@interface BoardBasicImplementation: NSObject <BoardInterface> {
   @private
      enum BoardCellStatus Board[BOARD_MAX_X][BOARD_MAX_Y];
      BOOL SafeDiscs[BOARD_MAX_X][BOARD_MAX_Y];
      int BlackCount;
      int WhiteCount;
      int EmptyCount;
      int BlackFrontierCount;
      int WhiteFrontierCount;
      int BlackSafeCount;
      int WhiteSafeCount;
}
/**
 * Inherit from BoardInterface
 */
-(id) init;
-(id) initWithBoad: (id <BoardInterface>) board;
-(int) BlackCount;
-(int) WhiteCount;
-(int) EmptyCount;
-(int) BlackFrontierCount;
-(int) WhiteFrontierCount;
-(int) BlackSafeCount;
-(int) WhiteSafeCount;
-(void) ResetBoard;

-(enum BoardCellStatus) GetCellStatus: (int) X : (int) Y;
-(BOOL) IsDiscSafe: (int) X: (int) Y;
-(void) MakeMove: (BOOL) isBlack
              At: (int) X : (int) Y;
-(BOOL) HasValidMove: (BOOL) isBlack;
-(enum BoardMoveResult) IsValidMove: (BOOL) isBlack
                                 At: (int) X : (int) Y;
-(int) GetValidMoveCount: (BOOL) isBlack;

/**
 ********************************
 */
-(void) UpdateCounts;
-(BOOL) IsOutFlanking: (BOOL) isBlack
                   At: (int) X : (int) Y
                Delta: (int) dX : (int) dY;
-(BOOL) IsOutFlankable: (int) X : (int) Y;
@end
