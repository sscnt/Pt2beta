//
//  VnViewLabel.m
//  Vintage 2.0
//
//  Created by SSC on 2014/04/28.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnViewLabel.h"

@implementation VnViewLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.textAlignment = NSTextAlignmentCenter;
        self.backgroundColor = [UIColor clearColor];
        self.textColor = [UIColor whiteColor];
        self.numberOfLines = 0;
        self.textAlignment = NSTextAlignmentCenter;
        self.fontSize = 15.0f;
        self.minimumScaleFactor = 0.50f;
    }
    return self;
}

- (void)setFontSize:(float)fontSize
{
    if([UIDevice isCurrentLanguageJapanese]) {
        self.font = [UIFont fontWithName:@"mplus-1c-bold" size:fontSize - 1.0f];
    } else {
        self.font = [UIFont fontWithName:@"ClearSans-Bold" size:fontSize];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
