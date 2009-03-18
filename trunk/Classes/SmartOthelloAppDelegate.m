//
//  SmartOthelloAppDelegate.m
//  SmartOthello
//
//  Created by Jucao Liang on 09-3-17.
//  Copyright 2009 Mobile Fun Studio. All rights reserved.
//

#import "SmartOthelloAppDelegate.h"
#import "RootViewController.h"

@implementation SmartOthelloAppDelegate

@synthesize window;
@synthesize rootViewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    

    // Override point for customization after application launch
	[window addSubview:[rootViewController view]];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [window release];
	[rootViewController release];
    [super dealloc];
}


@end
