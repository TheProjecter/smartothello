#import "BoardInterface.h"

@interface BoardBasiceImplementation: BoardInterface {
   @private
      enum CellStatus Board[BOARD_MAX_X][BOARD_MAX_Y];
}
- (BoardInterface*) init;

- (enum MoveResult) put: (BOOL) isBlack 
                     At: (int) X And: (int) Y;

- (enum CellStatus) getStatusAt:(int) X : (int) Y;

- (enum MoveResult) flipOneDirectionFrom: (int) X : (int) Y 
                                 AtDelta: (int) deltaX : (int) deltaY;
@end
