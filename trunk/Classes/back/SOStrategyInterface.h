#import "SOMove.h"
#import "SOBoardInterface.h"

@protocol SOStrategyInterface
-(struct SOMove) CalculateNextMove: (id <SOBoardInterface>)    board
                           Against: (struct SOMove)            opponentMove
                                  : (enum SOBoardCellStatus)   opponentColor;
@end
