#import "SOStrategyComputer.h"

#define MAX_INT  (int)((unsigned int)(-1) - 1)
#define MAX_RANK (MAX_INT - 64)

@implementation SOStrategyComputer
-(void) SetAILevel: (enum SOStrategyComputerAILevel) level {
   switch (level) {
      case kSOAIBeginner:
         ForfeitWeight      =  2;
         FrontierWeight     =  1;
         MobilityWeight     =  0;
         StabilityWeight    =  3;
         break;
      case kSOAIIntermediate:
         ForfeitWeight      =  3;
         FrontierWeight     =  1;
         MobilityWeight     =  0;
         StabilityWeight    =  5;
         break;
      case kSOAIAdvanced:
         ForfeitWeight      =  7;
         FrontierWeight     =  2;
         MobilityWeight     =  1;
         StabilityWeight    = 10;
         break;
      case kSOAIExpert:
         ForfeitWeight      = 35;
         FrontierWeight     = 10;
         MobilityWeight     =  5;
         StabilityWeight    = 50;
         break;
      default:
         ForfeitWeight      =  0;
         FrontierWeight     =  0;
         MobilityWeight     =  0;
         StabilityWeight    =  0;
         break;
   }
   LookAheadDepth = level + 3;
}

-(id) initWithAILevel: (enum SOStrategyComputerAILevel) level {
   self = [super init];
   if(self) {
      [self SetAILevel: level];
   }
   return self;

}

-(id) init {
   self = [super init];
   if (self) {
      [self SetAILevel: kSOAIBeginner];
   }
   return self;
}

-(int) AdjustLookAheadDepth: (id <SOBoardInterface>) board
{
   return LookAheadDepth;
}

-(struct SOComputerMove) CalculateNextMove: (id <SOBoardInterface>) board
                                  : (int) color
                                  : (int) depth
                                  : (int) alpha
                                  : (int) beta 
{
   // Rank is set to -color * MAX_RANK
   // Move is set to -1, -1
   struct SOComputerMove bestMove
      = { {-1, -1}, -color * MAX_RANK};

   return bestMove;
}

-(struct SOMove) CalculateNextMove: (id <SOBoardInterface>)    board
                           Against: (struct SOMove)            opponentMove 
                                  : (enum SOBoardCellStatus)   opponentColor
{
   int alpha = MAX_RANK + 64;
   int beta  = -alpha;
   [self AdjustLookAheadDepth: board];
   return [self CalculateNextMove: board
                                 : -opponentColor
                                 : 1
                                 : alpha
                                 : beta].Move;
}
@end
