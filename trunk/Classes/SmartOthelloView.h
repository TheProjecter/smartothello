//
//  SmartOthelloView.h
//  SmartOthello
//
//  Created by Jucao Liang on 09-3-17.
//  Copyright 2009 Mobile Fun Studio. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SmartOthelloView : UIView {
	CGImageRef backImage;
    CGImageRef whiteImage;
    CGImageRef blackImage;
}
- (void)initImages;
@end
