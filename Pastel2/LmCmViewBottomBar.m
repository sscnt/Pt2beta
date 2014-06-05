//
//  LmViewCameraBottomBar.m
//  Lumina
//
//  Created by SSC on 2014/05/22.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "LmCmViewBottomBar.h"

@implementation LmCmViewBottomBar

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
        self.backgroundColor = [LmCmSharedCamera bottomBarTransparentColor];
    }else{
        self.backgroundColor = [LmCmSharedCamera bottomBarColor];
    }
}

- (void)addShutterButton:(LmCmButtonShutter *)button
{
    button.center = CGPointMake([self width] / 2.0f, [self height] / 2.0f);
    [self addSubview:button];
}

- (void)addSettingsButton:(LmCmViewBarButton *)button
{
    button.center = CGPointMake([self width] - [button width] * 3.0f / 2.0f - 10.0f, [self height] / 2.0f);
    [self addSubview:button];
}

- (void)addGeneralSettingsButton:(LmCmViewBarButton *)button
{
    button.center = CGPointMake([self width] - [button width] / 2.0f - 10.0f, [self height] / 2.0f);
    [self addSubview:button];
}

- (void)addCamerarollButton:(LmCmViewBarButton *)button
{
    button.center = CGPointMake([button width] / 2.0f + 10.0f, [self height] / 2.0f);
    [self addSubview:button];
}

- (void)addLastPhotoButton:(LmCmViewBarButton *)button
{
    button.center = CGPointMake([button width] * 3.0f / 2.0f + 10.0f, [self height] / 2.0f);
    [self addSubview:button];
}

@end
