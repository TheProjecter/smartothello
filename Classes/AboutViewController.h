//
//  AboutViewController.h
//  SmartOthello
//
//  Created by Jucao Liang on 09-3-17.
//  Copyright 2009 Mobile Fun Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SmartOthelloViewController.h"


@interface AboutViewController : UIViewController {
	SmartOthelloViewController *delegate;
}
@property (nonatomic, retain) SmartOthelloViewController *delegate;
- (void)aboutDone;
@end
