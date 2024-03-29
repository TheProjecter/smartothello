//
//  SmartOthelloView.h
//  SmartOthello
//
//  Created by Jucao Liang on 09-3-17.
//  Copyright 2009 Mobile Fun Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "SmartOthelloController.h"
#define kMinimumGestureLength       25
#define kMaximumVariance            5

@interface SmartOthelloView : UIView {
	CGImageRef backImage;
    CGImageRef whiteImage;
    CGImageRef blackImage;
	CGImageRef whiteLastImage;
	CGImageRef blackLastImage;
	CGImageRef hintImage;
	CGImageRef hintWhiteImage;
	SmartOthelloController *othello;
	BOOL showPossibleMoves;
	BOOL playSound;
	BOOL multitouchGestures;
	SystemSoundID soundID;
	UILabel *labelBlackCount;
	UILabel *labelWhiteCount;
	UILabel *labelGameStatus;
	UIButton *newButton;
	UIButton *undoButton;
	UIButton *settingButton;
	UIButton *infoButton;
	UIImageView *blackDisc;
	UIImageView *whiteDisc;
	UIActivityIndicatorView *calculatingIndicatorView;
	CGPoint gestureStartPoint;
}
@property CGPoint gestureStartPoint;

- (void)renderCellAtRow:(int)row Column:(int)col;
- (void)initImages;
- (void)restartGame;
- (void)setSkillLevel:(int)level;
- (void)setBlackPlayer:(int)player;
- (void)setWhitePlayer:(int)player;
- (void)setShowPossibleMoves:(BOOL)show;
- (void)setPlaySound:(BOOL)sound;
- (void)setMultitouchGestures:(BOOL)gestures;
- (void)undoMove;
- (void)redoMove;
- (void)setLabelBlackCount:(UILabel *)label;
- (void)setLabelWhiteCount:(UILabel *)label;
- (void)setLabelGameStatus:(UILabel *)label;
- (void)setNewButton:(UIButton *)button;
- (void)setUndoButton:(UIButton *)button;
- (void)setSettingButton:(UIButton *)button;
- (void)setInfoButton:(UIButton *)button;
- (void)setBlackDisc:(UIImageView *)view;
- (void)setWhiteDisc:(UIImageView *)view;
- (void)setCalculatingIndicatorView:(UIActivityIndicatorView *)indicatorView;
@end
