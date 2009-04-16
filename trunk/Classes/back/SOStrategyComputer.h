#import <Foundation/NSObject.h>
#import "SOBoardInterface.h"
#import "SOStrategyInterface.h"

struct SOComputerMove {
   struct SOMove Move;
   int           Rank;
};

enum SOStrategyComputerAILevel {
   kSOAIBeginner = 0,
   kSOAIIntermediate,
   kSOAIAdvanced,
   kSOAIExpert
};

@interface SOStrategyComputer: NSObject <SOStrategyInterface> {
   @private
      int ForfeitWeight;
      int FrontierWeight;
      int MobilityWeight;
      int StabilityWeight;

      int Difficulty;
      int LookAheadDepth;
}
-(void) SetAILevel: (enum SOStrategyComputerAILevel) level;
-(id) initWithAILevel: (enum SOStrategyComputerAILevel) level;
-(id) init;

-(int) AdjustLookAheadDepth: (id <SOBoardInterface>) board;
-(struct SOComputerMove) CalculateNextMove: (id <SOBoardInterface>) board
                                  : (int) color
                                  : (int) depth
                                  : (int) alpha
                                  : (int) beta;
/**
 * implement protocol SOStrategyInterface
 */
-(struct SOMove) CalculateNextMove: (id <SOBoardInterface>)    board
                           Against: (enum SOBoardCellStatus)   opponentColor;
@end
