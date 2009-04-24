//
//  SmartOthelloViewController.m
//  SmartOthello
//
//  Created by Jucao Liang on 09-3-17.
//  Copyright 2009 Mobile Fun Studio. All rights reserved.
//

#import "SmartOthelloViewController.h"
#import "AboutViewController.h"
#import "SmartOthelloView.h"
#import "Constants.h"

@implementation SmartOthelloViewController

@synthesize flipDelegate;
@synthesize skillLevel;
@synthesize blackPlayer;
@synthesize whitePlayer;
@synthesize showPossibleMoves;
@synthesize playSound;
@synthesize shakeToRestart;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
	// Here you can add something extra. For example, you can refresh the settings here, See AppSettings project in Begin iPhone Development
	skillLevel = [[NSUserDefaults standardUserDefaults] integerForKey:SmartOthelloSkillLevelKey];
	blackPlayer = [[NSUserDefaults standardUserDefaults] integerForKey:SmartOthelloBlackPlayerKey];
	whitePlayer = [[NSUserDefaults standardUserDefaults] integerForKey:SmartOthelloWhitePlayerKey];
	showPossibleMoves = [[NSUserDefaults standardUserDefaults] boolForKey:SmartOthelloShowPossibleMovesKey];
	playSound = [[NSUserDefaults standardUserDefaults] boolForKey:SmartOthelloPlaySoundKey];
	shakeToRestart = [[NSUserDefaults standardUserDefaults] boolForKey:SmartOthelloShakeToRestartKey];
	[(SmartOthelloView *)(self.view) setSkillLevel:skillLevel];
	[(SmartOthelloView *)(self.view) setBlackPlayer:blackPlayer];
	[(SmartOthelloView *)(self.view) setWhitePlayer:whitePlayer];
	[(SmartOthelloView *)(self.view) setShowPossibleMoves:showPossibleMoves];
	[(SmartOthelloView *)(self.view) setPlaySound:playSound];
	// [(SmartOthelloView *)(self.view) restartGame];
	[super viewDidAppear:animated];
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
	skillLevel = [[NSUserDefaults standardUserDefaults] integerForKey:SmartOthelloSkillLevelKey];
	blackPlayer = [[NSUserDefaults standardUserDefaults] integerForKey:SmartOthelloBlackPlayerKey];
	whitePlayer = [[NSUserDefaults standardUserDefaults] integerForKey:SmartOthelloWhitePlayerKey];
	showPossibleMoves = [[NSUserDefaults standardUserDefaults] boolForKey:SmartOthelloShowPossibleMovesKey];
	playSound = [[NSUserDefaults standardUserDefaults] boolForKey:SmartOthelloPlaySoundKey];
	shakeToRestart = [[NSUserDefaults standardUserDefaults] boolForKey:SmartOthelloShakeToRestartKey];
	[(SmartOthelloView *)(self.view) setSkillLevel:skillLevel];
	[(SmartOthelloView *)(self.view) setBlackPlayer:blackPlayer];
	[(SmartOthelloView *)(self.view) setWhitePlayer:whitePlayer];
	[(SmartOthelloView *)(self.view) setShowPossibleMoves:showPossibleMoves];
	[(SmartOthelloView *)(self.view) setPlaySound:playSound];
	[(SmartOthelloView *)(self.view) restartGame];
	UIAccelerometer *accel = [UIAccelerometer sharedAccelerometer];
	accel.delegate = self;
	accel.updateInterval = kUpdateInterval;
    [super viewDidLoad];
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

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
	if (shakeToRestart) {
		if (fabsf(acceleration.x) > kAccelerationThreshold || fabsf(acceleration.y) > kAccelerationThreshold || fabsf(acceleration.z) > kAccelerationThreshold) {
			[(SmartOthelloView *)(self.view) restartGame];
		}
	}
}


#pragma mark ---- control callbacks ----

// Tells the root view, via a delegate, to flip over to the FlipSideView
- (IBAction)toggleView:(id)sender {
	[self.flipDelegate toggleView:self];
}

- (IBAction)infoButtonClicked:(id)sender {
	AboutViewController *aboutViewController = [[AboutViewController alloc] initWithNibName:@"AboutView" bundle:nil];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:aboutViewController];
	aboutViewController.delegate = self;
	[self presentModalViewController:navigationController animated:YES];
    [aboutViewController release];
}

- (IBAction)newButtonClicked:(id)sender {
	[(SmartOthelloView *)(self.view) restartGame];
}

- (IBAction)undoButtonClicked:(id)sender {
	[(SmartOthelloView *)(self.view) undoMove];
}

@end
