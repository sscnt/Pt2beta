//
//  PtFtViewToolBar.m
//  Pastel2
//
//  Created by SSC on 2014/06/25.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "PtFtViewToolBar.h"

@implementation PtFtViewToolBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [PtFtConfig toolBarBgColor];
        _lx = 0.0f;
        _rx = frame.size.width;
    }
    return self;
}

- (void)appendButtonToLeft:(PtFtViewToolBarButton *)button
{
    button.center = CGPointMake(_lx + button.width / 2.0f, self.height / 2.0f);
    [self addSubview:button];
    _lx += button.width;
}

- (void)appendButtonToRight:(PtFtViewToolBarButton *)button
{
    button.center = CGPointMake(_rx - button.width / 2.0f, self.height / 2.0f);
    [self addSubview:button];
    _rx -= button.width;
}

@end
