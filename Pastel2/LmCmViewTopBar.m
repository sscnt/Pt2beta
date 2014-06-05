//
//  LmViewCameraTopBar.m
//  Lumina
//
//  Created by SSC on 2014/05/22.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "LmCmViewTopBar.h"

@implementation LmCmViewTopBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.transparent = NO;
    }
    return self;
}

- (void)setTransparent:(BOOL)transparent
{
    if (transparent) {
        self.backgroundColor = [LmCmSharedCamera topBarTransparentColor];
    }else{
        self.backgroundColor = [LmCmSharedCamera topBarColor];
    }
}

- (void)addFlashButton:(LmCmViewBarButton *)button
{
    button.center = CGPointMake([button width] / 2.0f, [self height] / 2.0f);
    [self addSubview:button];
}

- (void)addCameraSwitchButton:(LmCmViewBarButton *)button
{
    button.center = CGPointMake([self width] - [button width] / 2.0f, [self height] / 2.0f);
    [self addSubview:button];
}

- (void)addCropButton:(LmCmViewBarButton *)button
{
    button.center = CGPointMake([self width] - [button width] * 3.0f / 2.0f, [self height] / 2.0f);
    [self addSubview:button];
}

@end
