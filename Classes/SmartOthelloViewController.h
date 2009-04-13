//
//  SmartOthelloViewController.h
//  SmartOthello
//
//  Created by Jucao Liang on 09-3-17.
//  Copyright 2009 Mobile Fun Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"

@interface SmartOthelloViewController : UIViewController {
	id flipDelegate;
	int skillLevel;
	int blackPlayer;
	int whitePlayer;
	BOOL showPossibleMoves;
}
@property (nonatomic,assign) id <MyFlipControllerDelegate> flipDelegate;
@property int skillLevel;
@property int blackPlayer;
@property int whitePlayer;
@property BOOL showPossibleMoves;

- (IBAction)toggleView:(id)sender;
- (IBAction)infoButtonClicked:(id)sender;
- (IBAction)newButtonClicked:(id)sender;
- (IBAction)undoButtonClicked:(id)sender;
@end
