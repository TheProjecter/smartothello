#import "BoardBasicImplementation.h"
#import <stdio.h>


int main(void) {
   BoardBasicImplementation *board = [[BoardBasicImplementation alloc] init];
   int X, Y;
   BOOL isBlack = TRUE;
   enum BoardMoveResult result;
   while(1) {
      for(X=0; X < BOARD_MAX_X; X++) {
         for(Y=0; Y < BOARD_MAX_Y; Y++) {
            if(kSpace == [board GetCellStatus: X : Y]) {
               printf("-");
            } else if(kWhite == [board GetCellStatus: X : Y]) {
               printf("O");
            } else if(kBlack == [board GetCellStatus: X : Y]) {
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
         if (result == kChangeNone) {
            printf("Change Nothing! Re-input\n"); fflush(stdout);
         } else if (result == kOccupied) {
            printf("This position is occupied\n"); fflush(stdout);
         } else {
            [board MakeMove: isBlack
                         At: X : Y];
         }
      } while (kAvailable != result);
      isBlack = !isBlack;
   }
   [board release];
   return 0;
}
