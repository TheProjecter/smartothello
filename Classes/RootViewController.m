//
//  RootViewController.m
//  SmartOthello
//
//  Created by Jucao Liang on 09-3-17.
//  Copyright 2009 Mobile Fun Studio. All rights reserved.
//

#import "RootViewController.h"
#import "SmartOthelloViewController.h"
#import "SettingViewController.h"


@implementation RootViewController

@synthesize smartOthelloViewController;
@synthesize settingViewController;

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


- (void)loadSmartOthelloViewController {
	SmartOthelloViewController *viewController = [[SmartOthelloViewController alloc] initWithNibName:@"SmartOthelloView" bundle:nil];
	self.smartOthelloViewController = viewController;
	self.smartOthelloViewController.flipDelegate = self;
	[viewController release];
}

- (void)loadSettingViewController {
	SettingViewController *viewController = [[SettingViewController alloc] initWithNibName:@"SettingView" bundle:nil];
	self.settingViewController = viewController;
	self.settingViewController.flipDelegate = self;
	[viewController release];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [self loadSmartOthelloViewController]; // Don't load the setting view unless / until necessary
	[self.view addSubview:smartOthelloViewController.view];
}

- (IBAction)toggleView:(id)sender {	
    // This method is called when the info or Done button is pressed.
    // It flips the displayed view from the main view to the flipside view and vice-versa.
	
	if (settingViewController == nil) {
		[self loadSettingViewController];
	}
	
	UIView *smartOthelloView = smartOthelloViewController.view;
	UIView *settingView = settingViewController.view;
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:1];
	[UIView setAnimationTransition:([smartOthelloView superview] ? UIViewAnimationTransitionFlipFromRight : UIViewAnimationTransitionFlipFromLeft) forView:self.view cache:YES];
	
	if ([smartOthelloView superview] != nil) {
		[settingViewController viewWillAppear:YES];
		[smartOthelloViewController viewWillDisappear:YES];
		[smartOthelloView removeFromSuperview];
		[self.view addSubview:settingView];
		[smartOthelloViewController viewDidDisappear:YES];
		[settingViewController viewDidAppear:YES];
		
	} else {
		[smartOthelloViewController viewWillAppear:YES];
		[settingViewController viewWillDisappear:YES];
		[settingView removeFromSuperview];
		[self.view addSubview:smartOthelloView];
		[settingViewController viewDidDisappear:YES];
		[smartOthelloViewController viewDidAppear:YES];
	}
	[UIView commitAnimations];
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
	[smartOthelloViewController release];
	[settingViewController release];
    [super dealloc];
}


@end
