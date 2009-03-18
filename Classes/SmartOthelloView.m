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
		[self initImages];
	}
	return self;
}


- (void)drawRect:(CGRect)rect {
    // Drawing code
	int i;
	float black[4] = {0, 0, 0, 1};
    CGRect r = CGRectMake(0.0, 0.0, 320.0, 320.0);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
	
    CGContextDrawImage(ctx, r, backImage);
    	
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
	
	//Draw the initial discs
	CGRect r1 = CGRectMake(120.0, 120.0, 40.0, 40.0);
	CGContextDrawImage(ctx, r1, whiteImage);
	CGRect r2 = CGRectMake(160.0, 160.0, 40.0, 40.0);
	CGContextDrawImage(ctx, r2, whiteImage);
	CGRect r3 = CGRectMake(120.0, 160.0, 40.0, 40.0);
	CGContextDrawImage(ctx, r3, blackImage);
	CGRect r4 = CGRectMake(160.0, 120.0, 40.0, 40.0);
	CGContextDrawImage(ctx, r4, blackImage);
	
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
}


- (void)dealloc {
	// ??? release the 3 images here or not?
    [super dealloc];
}


@end
