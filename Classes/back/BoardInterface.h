#import <Foundation/NSObject.h>

#define BOARD_MAX_X 8
#define BOARD_MAX_Y 8 


@interface BoardInterface: NSObject {
   @public
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
}
-(enum CellStatus) getStatusAt:(int) X And: (int) Y;
-(enum MoveResult) put:(BOOL) isBlack At: (int) X And: (int) Y;
@end
