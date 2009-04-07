#import "BoardInterface.h"

@interface BoardBasicImplementation: BoardInterface {
   @private
      enum BoardCellStatus Board[BOARD_MAX_X][BOARD_MAX_Y];
}
- (id) init;

- (enum BoardMoveResult) put: (BOOL) isBlack 
                     At: (int) X : (int) Y;

- (enum BoardCellStatus) getStatusAt:(int) X : (int) Y;

- (enum BoardMoveResult) flipOneDirectionFrom: (int) X : (int) Y 
                                 AtDelta: (int) deltaX : (int) deltaY;
@end
