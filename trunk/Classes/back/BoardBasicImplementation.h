#import "BoardInterface.h"

@interface BoardBasiceImplementation: BoardInterface {
   @private
      int Board[BOARD_MAX_X];
}
- (BoardInterface*) init;
- (enum MoveResult) put:(BOOL) isBlack At: (int) X And: (int) Y;
- (enum CellStatus) getStatusAt:(int) X And: (int) Y;
- (enum MoveResult) flipOneDirectionFrom:(int) X And: (int) Y At: (int) deltaX And: (int) deltaY;
@end
