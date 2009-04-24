//
//  SmartOthelloView.m
//  SmartOthello
//
//  Created by Jucao Liang on 09-3-17.
//  Copyright 2009 Mobile Fun Studio. All rights reserved.
//

#import "SmartOthelloView.h"


@implementation SmartOthelloView


- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
    }
    return self;
}

- (id)initWithCoder:(NSCoder*)coder
{
	if((self = [super initWithCoder:coder])) {
		// Do initialization here
		othello = [[SmartOthelloController alloc] initWithView:self];
		[self initImages];
		NSString *path = [[NSBundle mainBundle] pathForResource:@"tap" ofType:@"aif"];
		AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:path], &soundID);
	}
	return self;
}


- (void)drawRect:(CGRect)rect {
    // Drawing code
	int i;
	int j;
	float black[4] = {0, 0, 0, 1};
    CGRect r = CGRectMake(0.0, 0.0, 320.0, 320.0);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
	
    CGContextDrawImage(ctx, r, backImage);
	
	for (i = 0; i < SO_BOARD_MAX_X; i++) {
        for (j = 0; j < SO_BOARD_MAX_Y; j++) {
            [self renderCellAtRow:i Column:j];
        }
    }
    	
	//Draw Board
    CGContextSetLineWidth(ctx, 1.0);
    CGContextSetFillColor(ctx, black);
	
    for ( i = 0; i < 8; i++ ) {
        //Vertical
        CGContextBeginPath(ctx);      
        CGContextMoveToPoint(ctx, i * 40.0, 0);
        CGContextAddLineToPoint(ctx, i * 40.0, r.size.height);
        CGContextClosePath(ctx);
        CGContextDrawPath(ctx, kCGPathFillStroke);
        //Horizontal
        CGContextBeginPath(ctx);      
        CGContextMoveToPoint(ctx, 0, (i * 40.0));
        CGContextAddLineToPoint(ctx, r.size.width, (i * 40.0) );
        CGContextClosePath(ctx);
        CGContextDrawPath(ctx, kCGPathFillStroke);
    }
	
	// Play the sound
	if (playSound) {
		AudioServicesPlaySystemSound (soundID);	
	}
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
	CGPoint location = [touch locationInView:self];// <label id="code.DrawView.location"/>
	CGRect rect = CGRectMake(0.0, 0.0, 320.0, 320.0);;
	int cellWidth = (int)rect.size.width/SO_BOARD_MAX_X;
    int cellHeight = (int)rect.size.height/SO_BOARD_MAX_Y;
    
    int x = (int)location.x / cellWidth;
    int y = (int)location.y / cellHeight;
	if(location.x < 320.0 && location.y < 320.0) {
		[othello boardClickedAtRow:x Column:y];
		[self setNeedsDisplay];
	}
}

- (void) initImages {
    CFStringRef path;
    CFURLRef url;
    CGDataProviderRef provider;
    NSString *p;
	
    //Background
    p = [[NSBundle mainBundle] pathForResource: @"default" ofType: @"png"];
	
    path = CFStringCreateWithCString(NULL, 
									 [p cStringUsingEncoding: NSASCIIStringEncoding], 
									 kCFStringEncodingUTF8);
	
    url = CFURLCreateWithFileSystemPath(NULL, path, kCFURLPOSIXPathStyle, 0);
    provider = CGDataProviderCreateWithURL(url);
	
    CFRelease(path);
    CFRelease(url);
	
    backImage = CGImageCreateWithPNGDataProvider(provider, NULL, true, kCGRenderingIntentDefault);
	
    CGDataProviderRelease(provider);
	
    //White image
    p = [[NSBundle mainBundle] pathForResource: @"white" ofType: @"png"];
    path = CFStringCreateWithCString(NULL, 
									 [p cStringUsingEncoding: NSASCIIStringEncoding], 
									 kCFStringEncodingUTF8);
	
    url = CFURLCreateWithFileSystemPath(NULL, path, kCFURLPOSIXPathStyle, 0);
    provider = CGDataProviderCreateWithURL(url);
	
    CFRelease(path);
    CFRelease(url);
    whiteImage = CGImageCreateWithPNGDataProvider(provider, NULL, true, kCGRenderingIntentDefault);
    
    CGDataProviderRelease(provider);
	
    //Black image
    p = [[NSBundle mainBundle] pathForResource: @"black" ofType: @"png"];
    path = CFStringCreateWithCString(NULL, 
									 [p cStringUsingEncoding: NSASCIIStringEncoding], 
									 kCFStringEncodingUTF8);
	
    url = CFURLCreateWithFileSystemPath(NULL, path, kCFURLPOSIXPathStyle, 0);
    provider = CGDataProviderCreateWithURL(url);
	
    CFRelease(path);
    CFRelease(url);
    blackImage = CGImageCreateWithPNGDataProvider(provider, NULL, true, kCGRenderingIntentDefault);
    
    CGDataProviderRelease(provider);
	
	//White last image
    p = [[NSBundle mainBundle] pathForResource: @"whitelast" ofType: @"png"];
    path = CFStringCreateWithCString(NULL, 
									 [p cStringUsingEncoding: NSASCIIStringEncoding], 
									 kCFStringEncodingUTF8);
	
    url = CFURLCreateWithFileSystemPath(NULL, path, kCFURLPOSIXPathStyle, 0);
    provider = CGDataProviderCreateWithURL(url);
	
    CFRelease(path);
    CFRelease(url);
    whiteLastImage = CGImageCreateWithPNGDataProvider(provider, NULL, true, kCGRenderingIntentDefault);
    
    CGDataProviderRelease(provider);

	//Black last image
    p = [[NSBundle mainBundle] pathForResource: @"blacklast" ofType: @"png"];
    path = CFStringCreateWithCString(NULL, 
									 [p cStringUsingEncoding: NSASCIIStringEncoding], 
									 kCFStringEncodingUTF8);
	
    url = CFURLCreateWithFileSystemPath(NULL, path, kCFURLPOSIXPathStyle, 0);
    provider = CGDataProviderCreateWithURL(url);
	
    CFRelease(path);
    CFRelease(url);
    blackLastImage = CGImageCreateWithPNGDataProvider(provider, NULL, true, kCGRenderingIntentDefault);
    
    CGDataProviderRelease(provider);	
	
	//Hint image
    p = [[NSBundle mainBundle] pathForResource: @"hint" ofType: @"png"];
    path = CFStringCreateWithCString(NULL, 
									 [p cStringUsingEncoding: NSASCIIStringEncoding], 
									 kCFStringEncodingUTF8);
	
    url = CFURLCreateWithFileSystemPath(NULL, path, kCFURLPOSIXPathStyle, 0);
    provider = CGDataProviderCreateWithURL(url);
	
    CFRelease(path);
    CFRelease(url);
    hintImage = CGImageCreateWithPNGDataProvider(provider, NULL, true, kCGRenderingIntentDefault);
    
    CGDataProviderRelease(provider);	
}

- (void)renderCellAtRow:(int)row Column:(int)col {
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	
    CGRect rect = CGRectMake(row*40.0, col*40.0, 40.0, 40.0);
	
    if ([othello getsquareContentsAtRow:row Column:col] == kSOBlack) {
		if([othello lastMoveRow] == row && [othello lastMoveCol] == col) {
			CGContextDrawImage(ctx, rect, blackLastImage);
		}
		else {
			CGContextDrawImage(ctx, rect, blackImage);
		}
    }
    else if ([othello getsquareContentsAtRow:row Column:col] == kSOWhite) {
		if([othello lastMoveRow] == row && [othello lastMoveCol] == col) {
			CGContextDrawImage(ctx, rect, whiteLastImage);
		}
		else {
			CGContextDrawImage(ctx, rect, whiteImage);
		}
    }
	else {
		if([othello isValidMoveForColor:([othello currentColor]) Row:row Column:col] && showPossibleMoves) {
			CGContextDrawImage(ctx, rect, hintImage);
		}
	}
}

- (void)restartGame {
	[othello startGame];
}

- (void)setSkillLevel:(int)level {
	[othello setSkillLevel:level];
}

- (void)setBlackPlayer:(int)player {
	[othello setBlackPlayer:player];
}

- (void)setWhitePlayer:(int)player {
	[othello setWhitePlayer:player];
}

- (void)setShowPossibleMoves:(BOOL)show {
	showPossibleMoves = show;
	[self setNeedsDisplay];
}

- (void)setPlaySound:(BOOL)sound {
	playSound = sound;
}

- (void)undoMove {
	[othello undoMove];
}

- (void)dealloc {
	// ??? release the 3 images here or not?
	[othello release];
    [super dealloc];
}


@end
