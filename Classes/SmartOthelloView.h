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


@interface SmartOthelloView : UIView {
	CGImageRef backImage;
    CGImageRef whiteImage;
    CGImageRef blackImage;
	CGImageRef whiteLastImage;
	CGImageRef blackLastImage;
	CGImageRef hintImage;
	SmartOthelloController *othello;
	BOOL showPossibleMoves;
	BOOL playSound;
	SystemSoundID soundID;
}
- (void)renderCellAtRow:(int)row Column:(int)col;
- (void)initImages;
- (void)restartGame;
- (void)setSkillLevel:(int)level;
- (void)setBlackPlayer:(int)player;
- (void)setWhitePlayer:(int)player;
- (void)setShowPossibleMoves:(BOOL)show;
- (void)setPlaySound:(BOOL)sound;
- (void)undoMove;
@end
