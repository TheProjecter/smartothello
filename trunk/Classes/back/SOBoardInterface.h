#import <Foundation/NSObject.h>
#define SO_BOARD_MAX_X 8
#define SO_BOARD_MAX_Y 8 


enum SOBoardCellStatus{
   kSOEmpty = 0,
   kSOBlack = -1,
   kSOWhite = 1
};

enum SOBoardMoveResult {
   kSOAvailable,
   kSOOccupied,
   kSOChangeNone
};

@protocol SOBoardInterface

-(int) BlackCount;
-(int) WhiteCount;
-(int) EmptyCount;
-(int) BlackFrontierCount;
-(int) WhiteFrontierCount;
-(int) BlackSafeCount;
-(int) WhiteSafeCount;
-(void) ResetBoard;

-(enum SOBoardCellStatus) GetCellStatus: (int) X : (int) Y;
-(BOOL) IsDiscSafe: (int) X: (int) Y;

/**
 * It doesn't check if the move is valid
 */
-(void) MakeMove: (BOOL) isBlack
              At: (int) X : (int) Y;
-(BOOL) HasValidMove: (BOOL) isBlack;
-(enum SOBoardMoveResult) IsValidMove: (BOOL) isBlack
                 At: (int) X : (int) Y;
-(int) GetValidMoveCount: (BOOL) isBlack;
-(NSObject <SOBoardInterface>*) Clone;
@end

typedef NSObject <SOBoardInterface> * SOBoardInterfaceObject;
