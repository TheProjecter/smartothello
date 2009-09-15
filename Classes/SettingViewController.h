//
//  SettingViewController.h
//  SmartOthello
//
//  Created by Jucao Liang on 09-3-17.
//  Copyright 2009 Mobile Fun Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"

@interface SettingViewController : UIViewController {
	id flipDelegate;
	IBOutlet UISegmentedControl *skllLevelSegmentControl;
	IBOutlet UISegmentedControl *blackPlayerSegmentControl;
	IBOutlet UISegmentedControl *whitePlayerSegmentControl;
	IBOutlet UISwitch *showPossibleMovesSwitch;
	IBOutlet UISwitch *playSoundSwitch;
	IBOutlet UISwitch *shakeToRestartSwitch;
	IBOutlet UISwitch *multitouchGesturesSwitch;
}
@property (nonatomic,assign) id <MyFlipControllerDelegate> flipDelegate;
@property (nonatomic, retain) UISegmentedControl *skllLevelSegmentControl;
@property (nonatomic, retain) UISegmentedControl *blackPlayerSegmentControl;
@property (nonatomic, retain) UISegmentedControl *whitePlayerSegmentControl;
@property (nonatomic, retain) UISwitch *showPossibleMovesSwitch;
@property (nonatomic, retain) UISwitch *playSoundSwitch;
@property (nonatomic, retain) UISwitch *shakeToRestartSwitch;
@property (nonatomic, retain) UISwitch *multitouchGesturesSwitch;

- (IBAction)toggleView:(id)sender;
@end
