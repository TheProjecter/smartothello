#import "BoardBasicImplementation.h"
#import <stdio.h>

int main(void) {
   BoardInterface *board = [[BoardBasicImplementation alloc] init];
   int X, Y;
   BOOL isBlack = TRUE;
   enum BoardMoveResult result;
   while(1) {
      if(isBlack) {
         printf("Black");
      } else {
         printf("White");
      }
      printf("'s Turn\n");
      do
      {
         printf("Row: "); scanf("%d", &X);
         printf("Col: "); scanf("%d", &Y);
         result = [board put: isBlack
                          At: X : Y];
         if (result == kChangeNone) {
            printf("Change Nothing! Re-input\n");
         } else if (result == kOccupied) {
            printf("This position is occupied\n");
         }
      } while (kSuccess != result);
      isBlack = !isBlack;
      for(X=0; X < BOARD_MAX_X; X++) {
         for(Y=0; Y < BOARD_MAX_Y; Y++) {
            if(kSpace == [board getStatusAt: X : Y]) {
               printf("-");
            } else if(kWhite == [board getStatusAt: X : Y]) {
               printf("O");
            } else if(kBlack == [board getStatusAt: X : Y]) {
               printf("X");
            }
         }
         printf("\n");
      }
   }
   [board release];
   return 0;
}
