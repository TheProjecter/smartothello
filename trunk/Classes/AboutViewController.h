//
//  AboutViewController.h
//  SmartOthello
//
//  Created by Jucao Liang on 09-3-17.
//  Copyright 2009 Mobile Fun Studio. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AboutViewController : UIViewController {
	IBOutlet UIWebView *webView;
}

- (void)aboutDone;
- (void)loadWebView;
@end
