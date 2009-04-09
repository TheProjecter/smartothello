#import "SOBoardBasicImplementation.h"


@implementation SOBoardBasicImplementation 
-(int) BlackCount {
   return BlackCount;
}

-(int) WhiteCount {
   return WhiteCount;
}

-(int) EmptyCount {
   return EmptyCount;
}

-(int) BlackFrontierCount {
   return BlackFrontierCount;
}

-(int) WhiteFrontierCount {
   return WhiteFrontierCount;
}

-(int) BlackSafeCount {
   return BlackSafeCount;
}

-(int) WhiteSafeCount {
   return WhiteSafeCount;
}

-(id) init {
   self = [super init];
   if(self) {
      [self ResetBoard];
   }
   return self;
}

-(id) initWithBoad: (id <SOBoardInterface>) board
{
   self = [super init];
   if(self) {
      int x, y;
      for(x = 0; x < SO_BOARD_MAX_X; x++) {
         for(y = 0; y < SO_BOARD_MAX_Y; y++) {
            self->Board[x][y]     = [board GetCellStatus: x: y];
            self->SafeDiscs[x][y] = [board IsDiscSafe: x: y];
         }
      }
      [self UpdateCounts];
   }
   return self;
}

-(void) ResetBoard {
   int x, y;
   for(x = 0; x < SO_BOARD_MAX_X; x++) {
      for(y = 0; y < SO_BOARD_MAX_Y; y++) {
         Board[x][y] = kSOEmpty;
         SafeDiscs[x][y] = FALSE;
      }
   }
   Board[3][3] = Board[4][4] =  kSOWhite;
   Board[3][4] = Board[4][3] =  kSOBlack;
   [self UpdateCounts];
}

-(enum SOBoardCellStatus) GetCellStatus: (int) X : (int) Y {
   return Board[X][Y];
}

-(BOOL) IsDiscSafe: (int) X: (int) Y {
   return SafeDiscs[X][Y];
}

-(void) MakeMove: (BOOL) isBlack
              At: (int) X : (int) Y 
{
   enum SOBoardCellStatus color;
   int cX, cY;
   int dX, dY;
   if(isBlack) {
      color = kSOBlack;
   } else {
      color = kSOWhite;
   }
   Board[X][Y] = color;
   for(dX = -1; dX <= 1; dX++) {
      for(dY = -1; dY <= 1; dY++) {
         if(!(dX == 0 && dY == 0) 
               && [self IsOutFlanking: isBlack
                                   At: X : Y
                                Delta: dX : dY]) {
            cX = X + dX;
            cY = Y + dY;
            while(Board[cX][cY] == -color) {
               Board[cX][cY] = color;
               cX += dX;
               cY += cY;
            }
         }
      }
   }
   [self UpdateCounts];
}
-(BOOL) HasValidMove: (BOOL) isBlack {
   int x, y;
   for(x = 0; x < SO_BOARD_MAX_X; x++) {
      for(y = 0; y < SO_BOARD_MAX_Y; y++) {
         if(kSOAvailable 
               == [self IsValidMove: isBlack At: x : y]) {
            return TRUE;
         }
      }
   }
   return FALSE;
}

-(enum SOBoardMoveResult) IsValidMove: (BOOL) isBlack
                                 At: (int) X : (int) Y 
{
   int dX, dY;
   if(Board[X][Y] != kSOEmpty) {
      return kSOOccupied;
   }
   for(dX = -1; dX <= 1; dX++) {
      for(dY = -1; dY <=1; dY++) {
         if(!(dX == 0 && dY == 0)
               && [self IsOutFlanking: isBlack
                                   At: X : Y
                                Delta: dX : dY]) {
            return kSOAvailable;
         }
      }
   }
   return kSOChangeNone;
}

-(int) GetValidMoveCount: (BOOL) isBlack {
   int n = 0;
   int x, y;
   for(x = 0; x < SO_BOARD_MAX_X; x++) {
      for(y = 0; y < SO_BOARD_MAX_Y; y++) {
         if(kSOAvailable == [self IsValidMove: isBlack
                                         At: x : y]) {
            n++;
         }
      }
   }
   return n;
}

-(BOOL) IsOutFlanking: (BOOL) isBlack
                  At: (int) X : (int) Y
               Delta: (int) dX : (int) dY
{
   int x = X + dX;
   int y = Y + dY;
   enum SOBoardCellStatus color;
   if(isBlack) {
      color = kSOBlack;
   } else {
      color = kSOWhite;
   }
   while (x >= 0 && x < SO_BOARD_MAX_X && y >= 0 && y < SO_BOARD_MAX_Y && Board[x][y] == -color) {
      x += dX;
      y += dY;
   }
   if (x < 0 || x > 7 || y < 0 || y > 7 || (x - dX == X && y - dY == Y) || Board[x][y] != color) {
      return FALSE;
   }
   return TRUE;
}

-(void) UpdateCounts {
   BlackCount = 0;
   BlackFrontierCount = 0;
   BlackSafeCount = 0;
   WhiteCount = 0;
   WhiteFrontierCount = 0;
   WhiteSafeCount = 0;

   int i, j;
   int dr, dc;
   BOOL statusChanged = TRUE;
   while (statusChanged) {
      statusChanged = FALSE;
      for (i  = 0; i < SO_BOARD_MAX_X; i++) {
         for (j = 0; j < SO_BOARD_MAX_Y; j++) {
            if(Board[i][j] != kSOEmpty
                  && !SafeDiscs[i][j]
                  && [self IsOutFlankable: i :j]) {
               SafeDiscs[i][j] = TRUE;
               statusChanged = TRUE;
            }
         }
      }
   }

   for (i = 0; i < SO_BOARD_MAX_X; i++) {
      for (j = 0; j < SO_BOARD_MAX_Y; j++) {
         BOOL isFrontier = FALSE;
         if (Board[i][j] != kSOEmpty) {
            for (dr = -1; dr <= 1; dr++) {
               for (dc = -1; dc <= 1; dc++) {
                  if (!(dr == 0 && dc==0)
                        && i + dr >= 0
                        && i + dr < SO_BOARD_MAX_X
                        && j + dc >= 0
                        && j + dc < SO_BOARD_MAX_Y
                        && Board[i][j] == kSOEmpty) {
                     isFrontier = FALSE;
                  }
               }
            }
         }

         if(Board[i][j] == kSOBlack) {
            BlackCount++;
            if (isFrontier) {
               BlackFrontierCount++;
            }
            if (SafeDiscs[i][j]) {
               BlackSafeCount++;
            }
         } else if (Board[i][j] == kSOWhite) {
            WhiteCount++;
            if (isFrontier) {
               WhiteFrontierCount++;
            }
            if (SafeDiscs[i][j]) {
               WhiteSafeCount++;
            }
         } else {
            EmptyCount++;
         }
      }
   }
}

-(BOOL) IsOutFlankable: (int) X : (int) Y {
   int color = Board[X][Y];
   int i, j;
   BOOL hasSpaceSide1 = FALSE, hasSpaceSide2 = FALSE;
   BOOL hasUnsafeSide1 = FALSE, hasUnsafeSide2 = FALSE;

   // West, East
   for (j = 0; j < X && !hasSpaceSide1; j++) {
      if (Board[X, j] ==kSOEmpty) {
         hasSpaceSide1 = TRUE;
      } else if (Board[X][j] != color
            || !SafeDiscs[X][j]) {
         hasUnsafeSide1 = TRUE;
      }
   }

   for (j = Y + 1; j < SO_BOARD_MAX_Y && !hasSpaceSide2; j++) {
      if (Board[X][j] == kSOEmpty) {
         hasSpaceSide2 = TRUE;
      } else if (Board[X][j] != color
            || !SafeDiscs[X][j]) {
         hasUnsafeSide2 = TRUE;
      }
   }

   if ( (hasSpaceSide1 && hasSpaceSide2)
         || (hasSpaceSide1 && hasUnsafeSide2)
         || (hasUnsafeSide1 && hasUnsafeSide2)) {
      return TRUE;
   }
   // North, South
   hasSpaceSide1  = FALSE;
   hasSpaceSide2  = FALSE;
   hasUnsafeSide1 = FALSE;
   hasUnsafeSide2 = FALSE;
   // North side.
   for (i = 0; i < X && !hasSpaceSide1; i++) {
      if (Board[i][Y] == kSOEmpty) {
         hasSpaceSide1 = TRUE;
      } else if (Board[i][Y] != color || !SafeDiscs[i][Y]) {
         hasUnsafeSide1 = TRUE;
      }
   }
   // South side.
   for (i = X + 1; i < SO_BOARD_MAX_X && !hasSpaceSide2; i++) {
      if (Board[i][Y] == kSOEmpty) {
         hasSpaceSide2 = TRUE;
      } else if (Board[i][Y] != color || !SafeDiscs[i][Y]) {
         hasUnsafeSide2 = TRUE;
      }
   }
   if ((hasSpaceSide1 && hasSpaceSide2 ) 
         || (hasSpaceSide1 && hasUnsafeSide2) 
         || (hasUnsafeSide1 && hasSpaceSide2 )) {
      return TRUE;
   }

   // Northwest, Southeast
   hasSpaceSide1  = FALSE;
   hasSpaceSide2  = FALSE;
   hasUnsafeSide1 = FALSE;
   hasUnsafeSide2 = FALSE;
   for (i = X - 1, j = Y - 1;
         i >= 0 && j >= 0 && !hasSpaceSide1;
         i--, j--) {
      if (Board[i][j] == kSOEmpty) {
         hasSpaceSide1 = TRUE;
      } else if (Board[i][j] != color || !SafeDiscs[i][j]) {
         hasUnsafeSide1 = TRUE;
      }
   }
   for (i = X + 1, j = Y + 1;
         i < SO_BOARD_MAX_X && j < SO_BOARD_MAX_Y && !hasSpaceSide2;
         i++, j++) {
      if (Board[i][j] == kSOEmpty) {
         hasSpaceSide2 = TRUE;
      } else if (Board[i][j] != color || !SafeDiscs[i][j]) {
         hasUnsafeSide2 = TRUE;
      }
   }
   if ((hasSpaceSide1 && hasSpaceSide2 ) 
         || (hasSpaceSide1 && hasUnsafeSide2) 
         || (hasUnsafeSide1 && hasSpaceSide2 )) {
      return TRUE;
   }

   // Northeast, Southwest
   hasSpaceSide1  = FALSE;
   hasSpaceSide2  = FALSE;
   hasUnsafeSide1 = FALSE;
   hasUnsafeSide2 = FALSE;
   for (i = X - 1, j = Y + 1;
         i >= 0 && j < SO_BOARD_MAX_Y && !hasSpaceSide1;
         i--, j++) {
      if (Board[i][j] == kSOEmpty) {
         hasSpaceSide1 = TRUE;
      } else if (Board[i][j] != color || !SafeDiscs[i][j]) {
         hasUnsafeSide1 = TRUE;
      }
   }
   for (i = X + 1, j = Y - 1;
         i < SO_BOARD_MAX_X && j >= 0 && !hasSpaceSide2;
         i++, j--) {
      if (Board[i][j] == kSOEmpty) {
         hasSpaceSide2 = TRUE;
      } else if (Board[i][j] != color || !SafeDiscs[i][j]) {
         hasUnsafeSide2 = TRUE;
      }
   }
   if ((hasSpaceSide1 && hasSpaceSide2 ) 
         || (hasSpaceSide1 && hasUnsafeSide2) 
         || (hasUnsafeSide1 && hasSpaceSide2 )) {
      return TRUE;
   }

   return FALSE;

}

@end
