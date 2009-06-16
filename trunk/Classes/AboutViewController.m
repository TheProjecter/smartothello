//
//  AboutViewController.m
//  SmartOthello
//
//  Created by Jucao Liang on 09-3-17.
//  Copyright 2009 Mobile Fun Studio. All rights reserved.
//

#import "AboutViewController.h"


@implementation AboutViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		self.title = @"About";
		UIBarButtonItem *doneButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" 
																		   style:UIBarButtonItemStyleDone 
																		  target:self 
																		  action:@selector(aboutDone)];
        self.navigationItem.rightBarButtonItem = doneButtonItem;
        [doneButtonItem release];
	}
	return self;
}

- (void)aboutDone {
	[self dismissModalViewControllerAnimated:YES];
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
    [self loadWebView];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
	if (navigationType == UIWebViewNavigationTypeLinkClicked) {
		[[UIApplication sharedApplication] openURL:[request URL]];
		return NO;
	}
	return YES;
}

-(void) loadWebView {
	NSString *version  = @"1.0";
	[webView loadHTMLString:[NSString stringWithFormat:@"<font face=\"Helvetica\"> <p style=\"color:rgb(51,51,51);padding-top:8px;\"><br><br><br><br><br><br><br><br><br><br><b style=\"font-size:18px;\">Smart Reversi</b><br>Version %@<br><br>"
							 "A classic Reversi game for iPhone/iPod Touch.<br><br>"
							 "Smart Reversi was created by Jucao Liang and developed by Zyan Wu and Jucao Liang.<br><br>"
							 "For more information, please<br />visit our web site at <a style=\"color:rgb(37,131,173);text-decoration:none\" href=\"http://smartreversi.blogspot.com/\">smartreversi.blogspot.com</a>.</p></font>",version] baseURL:nil];
	[webView setBackgroundColor:[UIColor whiteColor]];
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
	[webView release];
    [super dealloc];
}


@end
