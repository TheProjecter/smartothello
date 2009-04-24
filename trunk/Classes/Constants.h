// Defines constants used by board.
#define Black -1
#define Empty 0
#define White 1
#define DIMENSION 8

// Defines the difficulty settings.
#define Beginner        0
#define Intermediate    1
#define Advanced        2
#define Expert          3

// Defines the game states.
#define GameOver			0 // The game is over (also used for the initial state).
#define InMoveAnimation	    1 // A move has been made and the animation is active.
#define InPlayerMove		2 // Waiting for the user to make a move.
#define InComputerMove		3 // Waiting for the computer to make a move.
#define MoveCompleted		4 // A move has been completed (including the animation, if active).

// Defines the maximum move rank value (used for ranking an end game).
#define maxRank  32703 //(32767-64)

// Define the keys for settings.
#define SmartOthelloSkillLevelKey        @"SmartOthelloSkillLevelKey"
#define SmartOthelloBlackPlayerKey       @"SmartOthelloBlackPlayerKey"
#define SmartOthelloWhitePlayerKey       @"SmartOthelloWhitePlayerKey"
#define SmartOthelloShowPossibleMovesKey @"SmartOthelloShowPossibleMovesKey"
#define SmartOthelloPlaySoundKey         @"SmartOthelloPlaySoundKey"
#define SmartOthelloShakeToRestartKey    @"SmartOthelloShakeToRestartKey"

// Define the players.
#define PlayerHuman    0
#define PlayerComputer 1

// Define the accelerometer parameters
#define kAccelerationThreshold		2.2
#define kUpdateInterval			(1.0f/10.0f)

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

#define MAX_INT  (int)((unsigned int)(-1) >> 1)
#define MAX_RANK (MAX_INT - 64)

enum SOStrategyComputerAILevel {
   kSOAIBeginner = 0,
   kSOAIIntermediate,
   kSOAIAdvanced,
   kSOAIExpert
};