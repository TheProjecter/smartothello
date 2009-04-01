#import "BoardInterface.h"

@interface BoardBasiceImplementation: BoardInterface {
   @private
      CellStatus Board[MAX_X][MAX_Y];
}
- (BoardInterface*) init;
- (MoveResult) put:(BOOL) isBlack At: (int) X And: (int) Y;
- (CellStatus) getStatusAt:(int) X And: (int) Y;
- (MoveResult) flipOneDirectionFrom:(int) X And: (int) Y At: (int) deltaX And: (int) deltaY;
@end
