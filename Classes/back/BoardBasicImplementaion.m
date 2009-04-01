#import "BoardBasicImplementation.h"


@implementation BoardBasiceImplementation 
- (BoardInterface*) init {
   BoardInterface *intf = [super init];
   for(int i = 0; i < BOARD_MAX_X; i++) {
      for(int j = 0; j < BOARD_MAX_Y: j++) {
         Board[i][j] = kSpace;
      }
   }
   Board[3][3] = Board[4][4] = kWhite;
   Board[3][4] = Board[4][3] = kBlack;
}
- (MoveResult) flipOneDirectionFrom:(int) X And: (int) Y At: (int) deltaX And: (int) deltaY {
   CellStatus expectedStatus, origStatus = Board[X][Y];
   if(kWhite == origStatus) {
      expectedStatus = kBlack;
   } else if (kBlack == origStatus) {
      expectedStatus = kWhite;
   } else {
      return kChangeNone;
   }
   for(int curX=X+deltaX, curY=Y+deltaY; curX >= 0 && curX < BOARD_MAX_X && curY >= 0 && curY < BOARD_MAX_Y; curX+=deltaX, curX+=deltaY) {
      if(kSpace == board[curX][curY]) {
         return kChangeNone;
      } else if(expectedStatus == board[curX][curY]) {
         continue;
      } else if((curX - X) == deltaX && (curY - Y) == deltaY) {
         return kChangeNone;
      } else {
         for(X+=deltaX, Y+=deltaY; X!=curX || Y! = curY; X+=deltaX, Y+=deltaY) {
            board[X][Y] = origStatus;
         }
         return kSuccess;
      }
   }
}
- (MoveResult) put:(BOOL) isBlack At: (int) X And: (int) Y {
   BOOL isChanged = FALSE;
   if(kSpace != Board[X][Y]) {
      return kOccupied;
   }
   if(isBlack) {
      Board[X][Y] = kBlack;
   } else {
      Board[X][Y] = kWhite; 
   }
   if([self flipOneDirectionFrom: X And: Y At: 1 And: 1] == kSuccess) {
      isChanged = TRUE; 
   }
   if([self flipOneDirectionFrom: X And: Y At: 1 And: -1] == kSuccess) {
      isChanged = TRUE; 
   }
   if([self flipOneDirectionFrom: X And: Y At: -1 And: 1] == kSuccess) {
      isChanged = TRUE; 
   }
   if([self flipOneDirectionFrom: X And: Y At: -1 And: -1] == kSuccess) {
      isChanged = TRUE; 
   }
   if([self flipOneDirectionFrom: X And: Y At: 0 And: 1] == kSuccess) {
      isChanged = TRUE; 
   }
   if([self flipOneDirectionFrom: X And: Y At: 0 And: -1] == kSuccess) {
      isChanged = TRUE; 
   }
   if([self flipOneDirectionFrom: X And: Y At: 1 And: 0] == kSuccess) {
      isChanged = TRUE; 
   }
   if([self flipOneDirectionFrom: X And: Y At: -1 And: 0] == kSuccess) {
      isChanged = TRUE; 
   }
   if(!isChanged) {
      Board[X][Y] = kSpace;
      return kChangeNone; 
   } else {
      return kSuccess; 
   }
}

@end

