#import "BoardBasicImplementation.h"
#import <stdio.h>


int main(void) {
   BoardInterface *board = [[BoardBasicImplementation alloc] init];
   int X, Y;
   BOOL isBlack = TRUE;
   enum BoardMoveResult result;
   while(1) {
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
         result = [board put: isBlack
                          At: X : Y];
         if (result == kChangeNone) {
            printf("Change Nothing! Re-input\n"); fflush(stdout);
         } else if (result == kOccupied) {
            printf("This position is occupied\n"); fflush(stdout);
         }
      } while (kSuccess != result);
      isBlack = !isBlack;
      for(Y=0; Y < BOARD_MAX_Y; Y++) {
         for(X=0; X < BOARD_MAX_X; X++) {
            if(kSpace == [board getStatusAt: X : Y]) {
               printf("-");
            } else if(kWhite == [board getStatusAt: X : Y]) {
               printf("O");
            } else if(kBlack == [board getStatusAt: X : Y]) {
               printf("X");
            }
         }
         printf("\n"); fflush(stdout);
      }
   }
   [board release];
   return 0;
}
