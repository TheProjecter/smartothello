#define BOARD_MAX_X 8
#define BOARD_MAX_Y 8 


enum BoardCellStatus{
   kSpace = 0,
   kBlack = -1,
   kWhite = 1
};

enum BoardMoveResult {
   kAvailable,
   kOccupied,
   kChangeNone
};

@protocol BoardInterface

-(int) BlackCount;
-(int) WhiteCount;
-(int) EmptyCount;
-(int) BlackFrontierCount;
-(int) WhiteFrontierCount;
-(int) BlackSafeCount;
-(int) WhiteSafeCount;
-(void) ResetBoard;

-(enum BoardCellStatus) GetCellStatus: (int) X : (int) Y;
-(BOOL) IsDiscSafe: (int) X: (int) Y;

/**
 * It doesn't check if the move is valid
 */
-(void) MakeMove: (BOOL) isBlack
              At: (int) X : (int) Y;
-(BOOL) HasValidMove: (BOOL) isBlack;
-(enum BoardMoveResult) IsValidMove: (BOOL) isBlack
                 At: (int) X : (int) Y;
-(int) GetValidMoveCount: (BOOL) isBlack;
@end
