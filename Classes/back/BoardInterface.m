#import "BoardInterface.h"

@implementation BoardInterface {
}
-(enum BoardCellStatus) getStatusAt:(int) X : (int) Y {
   return kSpace;
}
-(enum BoardMoveResult) put:(BOOL) isBlack 
                         At: (int) X : (int) Y {
                            return kChangeNone;
                         }
@end
