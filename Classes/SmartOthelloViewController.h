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
	BOOL multitouchGestures;
	IBOutlet UILabel *labelBlackCount;
	IBOutlet UILabel *labelWhiteCount;
	IBOutlet UILabel *labelGameStatus;
	IBOutlet UIButton *newButton;
	IBOutlet UIButton *undoButton;
	IBOutlet UIButton *settingButton;
	IBOutlet UIButton *infoButton;
	IBOutlet UIImageView *blackDisc;
	IBOutlet UIImageView *whiteDisc;
	IBOutlet UIActivityIndicatorView *calculatingIndicatorView;
}
@property (nonatomic,assign) id <MyFlipControllerDelegate> flipDelegate;
@property int skillLevel;
@property int blackPlayer;
@property int whitePlayer;
@property BOOL showPossibleMoves;
@property BOOL playSound;
@property BOOL shakeToRestart;
@property BOOL multitouchGestures;
@property (nonatomic, retain) UILabel *labelBlackCount;
@property (nonatomic, retain) UILabel *labelWhiteCount;
@property (nonatomic, retain) UILabel *labelGameStatus;
@property (nonatomic, retain) UIButton *newButton;
@property (nonatomic, retain) UIButton *undoButton;
@property (nonatomic, retain) UIButton *settingButton;
@property (nonatomic, retain) UIButton *infoButton;
@property (nonatomic, retain) UIImageView *blackDisc;
@property (nonatomic, retain) UIImageView *whiteDisc;
@property (nonatomic, retain) UIActivityIndicatorView *calculatingIndicatorView;

- (void)refreshSettings;
- (void)passControlsToView;
- (IBAction)toggleView:(id)sender;
- (IBAction)infoButtonClicked:(id)sender;
- (IBAction)newButtonClicked:(id)sender;
- (IBAction)undoButtonClicked:(id)sender;
@end
