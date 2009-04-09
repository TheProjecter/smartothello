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

-(enum SOBoardCellStatus) GetCellStatus: (int) X : (int) Y;
-(BOOL) IsDiscSafe: (int) X: (int) Y;
-(void) MakeMove: (BOOL) isBlack
              At: (int) X : (int) Y;
-(BOOL) HasValidMove: (BOOL) isBlack;
-(enum SOBoardMoveResult) IsValidMove: (BOOL) isBlack
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
