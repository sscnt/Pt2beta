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
        _view = [[UIScrollView alloc] initWithFrame:self.bounds];
        _view.showsHorizontalScrollIndicator = NO;
        _view.showsVerticalScrollIndicator = NO;
        [self addSubview:_view];
    }
    return self;
}

- (void)appendButton:(PtEdViewBarButton *)button
{
    float _x = button.width / 2.0f * 0.90f;
    x += _x;
    button.center = CGPointMake(x, self.height / 2.0f);
    x += _x;
    [_view addSubview:button];
    _view.contentSize = CGSizeMake(x, [_view height]);
}

@end
