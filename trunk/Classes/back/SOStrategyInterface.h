#import "SOMove.h"
#import "SOBoardInterface.h"

@protocol SOStrategyInterface
-(struct SOMove) CalculateNextMove: (id <SOBoardInterface>)    board
                           Against: (enum SOBoardCellStatus)   color;
@end
