//
//  SmartOthelloAppDelegate.m
//  SmartOthello
//
//  Created by Jucao Liang on 09-3-17.
//  Copyright 2009 Mobile Fun Studio. All rights reserved.
//

#import "SmartOthelloAppDelegate.h"
#import "RootViewController.h"
#import "Constants.h"
#import "SmartOthelloViewController.h"

@implementation SmartOthelloAppDelegate

@synthesize window;
@synthesize rootViewController;

// +initialize is invoked before the class receives any other messages, so it
// is a good place to set up application defaults
+ (void)initialize {
    if ([self class] == [SmartOthelloAppDelegate class]) {
        // Register a default value for the Skill level. 
        // This will be used if the user hasn't set the Skill level.
        NSNumber *defaultSkillLevel = [NSNumber numberWithInt:Beginner];
        NSDictionary *resourceDict = [NSDictionary dictionaryWithObject:defaultSkillLevel forKey:SmartOthelloSkillLevelKey];
		[[NSUserDefaults standardUserDefaults] registerDefaults:resourceDict];
		
		NSNumber *defaultBlackPlayer = [NSNumber numberWithInt:PlayerHuman];
        NSDictionary *resourceBlackDict = [NSDictionary dictionaryWithObject:defaultBlackPlayer forKey:SmartOthelloBlackPlayerKey];
		[[NSUserDefaults standardUserDefaults] registerDefaults:resourceBlackDict];
		
		NSNumber *defaultWhitePlayer = [NSNumber numberWithInt:PlayerComputer];
        NSDictionary *resourceWhiteDict = [NSDictionary dictionaryWithObject:defaultWhitePlayer forKey:SmartOthelloWhitePlayerKey];
		[[NSUserDefaults standardUserDefaults] registerDefaults:resourceWhiteDict];
		
		NSNumber *defaultShowPossibleMoves = [NSNumber numberWithBool:YES];
        NSDictionary *resourcePossibleMovesDict = [NSDictionary dictionaryWithObject:defaultShowPossibleMoves forKey:SmartOthelloShowPossibleMovesKey];
		[[NSUserDefaults standardUserDefaults] registerDefaults:resourcePossibleMovesDict];
    }
}

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
