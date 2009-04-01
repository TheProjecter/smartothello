#import <Foundation/NSObject.h>

#define BOARD_MAX_X 8
#define BOARD_MAX_Y 8 


enum BoardCellStatus{
   kSpace,
   kBlack,
   kWhite
};

enum BoardMoveResult {
   kSuccess,
   kOccupied,
   kChangeNone
};

@interface BoardInterface: NSObject {
}
-(enum BoardCellStatus) getStatusAt:(int) X : (int) Y;
-(enum BoardMoveResult) put:(BOOL) isBlack 
                         At: (int) X : (int) Y;
@end
