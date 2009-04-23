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
      int r, c;
      for(r = 0; r < SO_BOARD_MAX_X; r++) {
         for(c = 0; c < SO_BOARD_MAX_Y; c++) {
            self->Board[r][c]     = [board GetCellStatus: r: c];
            self->SafeDiscs[r][c] = [board IsDiscSafe: r: c];
         }
      }
      [self UpdateCounts];
   }
   return self;
}

-(void) ResetBoard {
   int r, c;
   for(r = 0; r < SO_BOARD_MAX_X; r++) {
      for(c = 0; c < SO_BOARD_MAX_Y; c++) {
         Board[r][c] = kSOEmpty;
         SafeDiscs[r][c] = FALSE;
      }
   }
   Board[3][3] = Board[4][4] =  kSOWhite;
   Board[3][4] = Board[4][3] =  kSOBlack;
   [self UpdateCounts];
}

-(enum SOBoardCellStatus) GetCellStatus: (int) row : (int) col {
   return Board[row][col];
}

-(BOOL) IsDiscSafe: (int) row: (int) col {
   return SafeDiscs[row][col];
}

-(void) MakeMove: (BOOL) isBlack
              At: (int) row : (int) col 
{
   enum SOBoardCellStatus color;
   int r, c;
   int dr, dc;
   if(isBlack) {
      color = kSOBlack;
   } else {
      color = kSOWhite;
   }
   Board[row][col] = color;
   for(dr = -1; dr <= 1; dr++) {
      for(dc = -1; dc <= 1; dc++) {
         if(!(dr == 0 && dc == 0) 
               && [self IsOutFlanking: isBlack
                                   At: row : col
                                Delta: dr : dc]) {
            r = row + dr;
            c = col + dc;
            while(Board[r][c] == -color) {
               Board[r][c] = color;
               r += dr;
               c += dc;
            }
         }
      }
   }
   [self UpdateCounts];
}
-(BOOL) HasValidMove: (BOOL) isBlack {
   int r, c;
   for(r = 0; r < SO_BOARD_MAX_X; r++) {
      for(c = 0; c < SO_BOARD_MAX_Y; c++) {
         if(kSOAvailable 
               == [self IsValidMove: isBlack At: r : c]) {
            return TRUE;
         }
      }
   }
   return FALSE;
}

-(enum SOBoardMoveResult) IsValidMove: (BOOL) isBlack
                                 At: (int) row : (int) col 
{
   int dr, dc;
   if(Board[row][col] != kSOEmpty) {
      return kSOOccupied;
   }
   for(dr = -1; dr <= 1; dr++) {
      for(dc = -1; dc <=1; dc++) {
         if(!(dr == 0 && dc == 0)
               && [self IsOutFlanking: isBlack
                                   At: row : col
                                Delta: dr : dc]) {
            return kSOAvailable;
         }
      }
   }
   return kSOChangeNone;
}

-(int) GetValidMoveCount: (BOOL) isBlack {
   int n = 0;
   int r, c;
   for(r = 0; r < SO_BOARD_MAX_X; r++) {
      for(c = 0; c < SO_BOARD_MAX_Y; c++) {
         if(kSOAvailable == [self IsValidMove: isBlack
                                         At: r : c]) {
            n++;
         }
      }
   }
   return n;
}

-(BOOL) IsOutFlanking: (BOOL) isBlack
                  At: (int) row : (int) col
               Delta: (int) dr : (int) dc
{
   int r = row + dr;
   int c = col + dc;
   enum SOBoardCellStatus color;
   if(isBlack) {
      color = kSOBlack;
   } else {
      color = kSOWhite;
   }
   while (r >= 0 && r < SO_BOARD_MAX_X && c >= 0 && c < SO_BOARD_MAX_Y && Board[r][c] == -color) {
      r += dr;
      c += dc;
   }
   if (r < 0 || r > 7 || c < 0 || c > 7 || (r - dr == row && c - dc == col) || Board[r][c] != color) {
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
   EmptyCount = 0;

   int r, c;
   int dr, dc;
   BOOL statusChanged = TRUE;
   while (statusChanged) {
      statusChanged = FALSE;
      for (r  = 0; r < SO_BOARD_MAX_X; r++) {
         for (c = 0; c < SO_BOARD_MAX_Y; c++) {
            if(Board[r][c] != kSOEmpty
                  && !SafeDiscs[r][c]
                  && ![self IsOutFlankable: r :c]) {
               SafeDiscs[r][c] = TRUE;
               statusChanged = TRUE;
            }
         }
      }
   }

   for (r = 0; r < SO_BOARD_MAX_X; r++) {
      for (c = 0; c < SO_BOARD_MAX_Y; c++) {
         BOOL isFrontier = FALSE;
         if (Board[r][c] != kSOEmpty) {
            for (dr = -1; dr <= 1; dr++) {
               for (dc = -1; dc <= 1; dc++) {
                  if (!(dr == 0 && dc==0)
                        && r + dr >= 0
                        && r + dr < SO_BOARD_MAX_X
                        && c + dc >= 0
                        && c + dc < SO_BOARD_MAX_Y
                        && Board[r+dr][c+dc] == kSOEmpty) {
                     isFrontier = TRUE;
                  }
               }
            }
         }

         if(Board[r][c] == kSOBlack) {
            BlackCount++;
            if (isFrontier) {
               BlackFrontierCount++;
            }
            if (SafeDiscs[r][c]) {
               BlackSafeCount++;
            }
         } else if (Board[r][c] == kSOWhite) {
            WhiteCount++;
            if (isFrontier) {
               WhiteFrontierCount++;
            }
            if (SafeDiscs[r][c]) {
               WhiteSafeCount++;
            }
         } else {
            EmptyCount++;
         }
      }
   }
}

-(BOOL) IsOutFlankable: (int) row : (int) col {
   int color = Board[row][col];
   int r, c;
   BOOL hasSpaceSide1 = FALSE, hasSpaceSide2 = FALSE;
   BOOL hasUnsafeSide1 = FALSE, hasUnsafeSide2 = FALSE;

   // West, East
   for (c = 0; c < row && !hasSpaceSide1; c++) {
      if (Board[row][c] == kSOEmpty) {
         hasSpaceSide1 = TRUE;
      } else if (Board[row][c] != color
            || !SafeDiscs[row][c]) {
         hasUnsafeSide1 = TRUE;
      }
   }

   for (c = col + 1; c < SO_BOARD_MAX_Y && !hasSpaceSide2; c++) {
      if (Board[row][c] == kSOEmpty) {
         hasSpaceSide2 = TRUE;
      } else if (Board[row][c] != color
            || !SafeDiscs[row][c]) {
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
   for (r = 0; r < row && !hasSpaceSide1; r++) {
      if (Board[r][col] == kSOEmpty) {
         hasSpaceSide1 = TRUE;
      } else if (Board[r][col] != color || !SafeDiscs[r][col]) {
         hasUnsafeSide1 = TRUE;
      }
   }
   // South side.
   for (r = row + 1; r < SO_BOARD_MAX_X && !hasSpaceSide2; r++) {
      if (Board[r][col] == kSOEmpty) {
         hasSpaceSide2 = TRUE;
      } else if (Board[r][col] != color || !SafeDiscs[r][col]) {
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
   for (r = row - 1, c = col - 1;
         r >= 0 && c >= 0 && !hasSpaceSide1;
         r--, c--) {
      if (Board[r][c] == kSOEmpty) {
         hasSpaceSide1 = TRUE;
      } else if (Board[r][c] != color || !SafeDiscs[r][c]) {
         hasUnsafeSide1 = TRUE;
      }
   }
   for (r = row + 1, c = col + 1;
         r < SO_BOARD_MAX_X && c < SO_BOARD_MAX_Y && !hasSpaceSide2;
         r++, c++) {
      if (Board[r][c] == kSOEmpty) {
         hasSpaceSide2 = TRUE;
      } else if (Board[r][c] != color || !SafeDiscs[r][c]) {
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
   for (r = row - 1, c = col + 1;
         r >= 0 && c < SO_BOARD_MAX_Y && !hasSpaceSide1;
         r--, c++) {
      if (Board[r][c] == kSOEmpty) {
         hasSpaceSide1 = TRUE;
      } else if (Board[r][c] != color || !SafeDiscs[r][c]) {
         hasUnsafeSide1 = TRUE;
      }
   }
   for (r = row + 1, c = col - 1;
         r < SO_BOARD_MAX_X && c >= 0 && !hasSpaceSide2;
         r++, c--) {
      if (Board[r][c] == kSOEmpty) {
         hasSpaceSide2 = TRUE;
      } else if (Board[r][c] != color || !SafeDiscs[r][c]) {
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

-(NSObject <SOBoardInterface>*) Clone {
   return [[SOBoardBasicImplementation alloc] initWithBoad: self];
}

@end
