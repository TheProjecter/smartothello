//
//  SmartOthelloViewController.h
//  SmartOthello
//
//  Created by Jucao Liang on 09-3-17.
//  Copyright 2009 Mobile Fun Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"

@interface SmartOthelloViewController : UIViewController <UIAccelerometerDelegate> {
	id flipDelegate;
	int skillLevel;
	int blackPlayer;
	int whitePlayer;
	BOOL showPossibleMoves;
	BOOL playSound;
	BOOL shakeToRestart;
}
@property (nonatomic,assign) id <MyFlipControllerDelegate> flipDelegate;
@property int skillLevel;
@property int blackPlayer;
@property int whitePlayer;
@property BOOL showPossibleMoves;
@property BOOL playSound;
@property BOOL shakeToRestart;

- (IBAction)toggleView:(id)sender;
- (IBAction)infoButtonClicked:(id)sender;
- (IBAction)newButtonClicked:(id)sender;
- (IBAction)undoButtonClicked:(id)sender;
@end
