//
//  RootViewController.h
//  SmartOthello
//
//  Created by Jucao Liang on 09-3-17.
//  Copyright 2009 Mobile Fun Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

// This protocol is used to tell the root view to flip between views
@protocol MyFlipControllerDelegate <NSObject>
@required
-(void)toggleView:(id)sender;
@end

@class SmartOthelloViewController;
@class SettingViewController;


@interface RootViewController : UIViewController <MyFlipControllerDelegate> {
	SmartOthelloViewController *smartOthelloViewController;
    SettingViewController *settingViewController;
}
@property (nonatomic, retain) SmartOthelloViewController *smartOthelloViewController;
@property (nonatomic, retain) SettingViewController *settingViewController;

@end
