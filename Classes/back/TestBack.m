#import "SOBoardBasicImplementation.h"
#import "SOStrategyComputer.h"
#import <stdio.h>

struct SOMove GetMove(
      id <SOStrategyInterface>   computer,
      id <SOBoardInterface>      board,
      BOOL                       isBlack,
      BOOL                       isComputerBlack)
{
   if ((isComputerBlack && isBlack) || (!isComputerBlack && !isBlack)) {
      return [computer CalculateNextMove: board Against: isBlack ? kSOBlack : kSOWhite];
   } else {
      struct SOMove move;
      printf("Row: "); fflush(stdout);
      scanf("%d", &move.row);
      printf("Col: "); fflush(stdout);
      scanf("%d", &move.col);
      return move;
   }
}

int main(void) {
   SOBoardBasicImplementation *board    = [[SOBoardBasicImplementation alloc] init];
   SOStrategyComputer         *computer = [[SOStrategyComputer alloc] initWithAILevel: kSOAIExpert];
   int X, Y;
   BOOL isBlack         = TRUE;
   BOOL isComputerBlack = FALSE;
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
         struct SOMove move = GetMove(computer, board, isBlack, isComputerBlack);
         result = [board IsValidMove: isBlack
                                  At: move.row : move.col];
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
   [computer release];
   return 0;
}
