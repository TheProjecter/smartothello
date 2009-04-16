#import "SOBoardBasicImplementation.h"
#import <stdio.h>


int main(void) {
   SOBoardBasicImplementation *board = [[SOBoardBasicImplementation alloc] init];
   int X, Y;
   BOOL isBlack = TRUE;
   enum SOBoardMoveResult result;
   while(1) {
      for(X=0; X < SO_BOARD_MAX_X; X++) {
         for(Y=0; Y < SO_BOARD_MAX_Y; Y++) {
            if(kSOEmpty == [board GetCellStatus: X : Y]) {
               printf("-");
            } else if(kSOWhite == [board GetCellStatus: X : Y]) {
               printf("O");
            } else if(kSOBlack == [board GetCellStatus: X : Y]) {
               printf("X");
            }
         }
         printf("\n"); fflush(stdout);
      }
      if(isBlack) {
         printf("Black"); fflush(stdout);
      } else {
         printf("White"); fflush(stdout);
      }
      printf("'s Turn\n"); fflush(stdout);
      do
      {
         printf("Row: "); fflush(stdout);
         scanf("%d", &X);
         printf("Col: "); fflush(stdout);
         scanf("%d", &Y);
         result = [board IsValidMove: isBlack
                                  At: X : Y];
         if (result == kSOChangeNone) {
            printf("Change Nothing! Re-input\n"); fflush(stdout);
         } else if (result == kSOOccupied) {
            printf("This position is occupied\n"); fflush(stdout);
         } else {
            [board MakeMove: isBlack
                         At: X : Y];
         }
      } while (kSOAvailable != result);
      isBlack = !isBlack;
   }
   [board release];
   return 0;
}
