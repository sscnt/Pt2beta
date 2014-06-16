//
//  PtEdViewToolBar.m
//  Pastel2
//
//  Created by SSC on 2014/06/16.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "PtEdViewToolBar.h"

@implementation PtEdViewToolBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [PtEdConfig toolBarColor];
        x = 0.0f;
    }
    return self;
}

- (void)appendButton:(PtEdViewBarButton *)button
{
    float _x = button.width / 2.0f * 3.0f;
    x += _x;
    button.center = CGPointMake(x, self.height / 2.0f);
    [self addSubview:button];
}

@end
