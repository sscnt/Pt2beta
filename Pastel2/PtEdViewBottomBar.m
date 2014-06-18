//
//  PtViewBottomBar.m
//  Pastel2
//
//  Created by SSC on 2014/05/30.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "PtEdViewBottomBar.h"

@implementation PtEdViewBottomBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [PtEdConfig bottomBarColor];
    }
    return self;
}

- (void)addBackToCameraButton:(PtEdViewBarButton*)button
{
    float x = button.width / 2.0f * 1.0f;
    button.center = CGPointMake(x, self.height / 2.0f);
    [self addSubview:button];
}

- (void)addFiltersButton:(PtEdViewBarButton*)button
{
    float x = button.width / 2.0f * 5.0f;
    button.center = CGPointMake(x, self.height / 2.0f);
    [self addSubview:button];
}

- (void)addSlidersButton:(PtEdViewBarButton*)button
{
    float x = button.width / 2.0f * 3.0f;
    button.center = CGPointMake(x, self.height / 2.0f);
    [self addSubview:button];
}

- (void)addFilmButton:(PtEdViewBarButton *)button
{
    float x = button.width / 2.0f * 7.0f;
    button.center = CGPointMake(x, self.height / 2.0f);
    [self addSubview:button];
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
