//
//  SettingViewController.m
//  SmartOthello
//
//  Created by Jucao Liang on 09-3-17.
//  Copyright 2009 Mobile Fun Studio. All rights reserved.
//

#import "SettingViewController.h"


@implementation SettingViewController

@synthesize flipDelegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillDisappear:(BOOL)animated
{
	// Here you can save the settings parameter to NSDefaults, see "AppSettings" project in "Begin iPhone Development"
}


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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    UINavigationBar *navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    navigationBar.barStyle = UIBarStyleBlackOpaque;
    UINavigationItem *doneItem = [[UINavigationItem alloc] init];   
    doneItem.title = @"Setting";
    UIBarButtonItem *doneItemButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(toggleView:)];
    
    [doneItem setRightBarButtonItem:doneItemButton animated:NO];
    [navigationBar pushNavigationItem:doneItem animated:NO];
    [self.view addSubview:navigationBar];
    
    [navigationBar release];
    [doneItem release];
    [doneItemButton release];
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
    [super dealloc];
}

#pragma mark ---- Other control callbacks ----

// Causes the new settings to take effect
// Tells the root view via a delegate to flip back over to the main view
- (IBAction)toggleView:(id)sender {
	// Tell the root view to flip back over to the main view
	[self.flipDelegate toggleView:self];
}


@end
