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
}
@property (nonatomic,assign) id <MyFlipControllerDelegate> flipDelegate;

- (IBAction)toggleView:(id)sender;
- (IBAction)infoButtonClicked:(id)sender;
@end
