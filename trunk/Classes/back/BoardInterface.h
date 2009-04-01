#import <Foundation/NSObject.h>

const int BOARD_MAX_X = 8;
const int BOARD_MAX_Y = 8;

enum CellStatus{
   kSpace,
   kBlack,
   kWhite
};
enum MoveResult {
   kSuccess,
   kOccupied,
   kChangeNone
};

@interface BoardInterface: NSObject {
}
-(int) getStatusAt:(int) X And: (int) Y;
-(MoveResult) put:(BOOL) isBlack At: (int) X And: (int) Y;
@end
