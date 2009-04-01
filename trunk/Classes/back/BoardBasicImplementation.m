#import "BoardBasicImplementation.h"


@implementation BoardBasicImplementation 
- (BoardInterface*) init {
   BoardInterface *intf = [super init];
   int i, j;
   for(i = 0; i < BOARD_MAX_X; i++) {
      for(j = 0; j < BOARD_MAX_Y; j++) {
         Board[i][j] = kSpace;
      }
   }
   Board[3][3] = Board[4][4] = kWhite;
   Board[3][4] = Board[4][3] = kBlack;
}
- (enum BoardMoveResult) flipOneDirectionFrom: (int) X : (int) Y 
                                 AtDelta: (int) deltaX : (int) deltaY {
   enum BoardCellStatus expectedStatus, origStatus = Board[X][Y];
   int curX, curY;
   if(kWhite == origStatus) {
      expectedStatus = kBlack;
   } else if (kBlack == origStatus) {
      expectedStatus = kWhite;
   } else {
      return kChangeNone;
   }
   for(curX=X+deltaX, curY=Y+deltaY; curX >= 0 && curX < BOARD_MAX_X && curY >= 0 && curY < BOARD_MAX_Y; curX+=deltaX, curX+=deltaY) {
      if(kSpace == Board[curX][curY]) {
         return kChangeNone;
      } else if(expectedStatus == Board[curX][curY]) {
         continue;
      } else if((curX - X) == deltaX && (curY - Y) == deltaY) {
         return kChangeNone;
      } else {
         for(X+=deltaX, Y+=deltaY; X!=curX || Y != curY; X+=deltaX, Y+=deltaY) {
            Board[X][Y] = origStatus;
         }
         return kSuccess;
      }
   }
}
- (enum BoardMoveResult) put:(BOOL) isBlack At: (int) X : (int) Y {
   BOOL isChanged = FALSE;
   if(kSpace != Board[X][Y]) {
      return kOccupied;
   }
   if(isBlack) {
      Board[X][Y] = kBlack;
   } else {
      Board[X][Y] = kWhite; 
   }
   if([self flipOneDirectionFrom: X : Y AtDelta: 1 : 1] == kSuccess) {
      isChanged = TRUE; 
   }
   if([self flipOneDirectionFrom: X : Y AtDelta: 1 : -1] == kSuccess) {
      isChanged = TRUE; 
   }
   if([self flipOneDirectionFrom: X : Y AtDelta: -1 : 1] == kSuccess) {
      isChanged = TRUE; 
   }
   if([self flipOneDirectionFrom: X : Y AtDelta: -1 : -1] == kSuccess) {
      isChanged = TRUE; 
   }
   if([self flipOneDirectionFrom: X : Y AtDelta: 0 : 1] == kSuccess) {
      isChanged = TRUE; 
   }
   if([self flipOneDirectionFrom: X : Y AtDelta: 0 : -1] == kSuccess) {
      isChanged = TRUE; 
   }
   if([self flipOneDirectionFrom: X : Y AtDelta: 1 : 0] == kSuccess) {
      isChanged = TRUE; 
   }
   if([self flipOneDirectionFrom: X : Y AtDelta: -1 : 0] == kSuccess) {
      isChanged = TRUE; 
   }
   if(!isChanged) {
      Board[X][Y] = kSpace;
      return kChangeNone; 
   } else {
      return kSuccess; 
   }
}
- (enum BoardCellStatus) getStatusAt:(int) X : (int) Y {
   return Board[X][Y]; 
}

@end

