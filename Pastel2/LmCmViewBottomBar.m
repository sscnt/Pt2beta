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
    _settingsButton = button;
    [self addSubview:button];
}

- (void)addGeneralSettingsButton:(LmCmViewBarButton *)button
{
    _generalButton = button;
    [self addSubview:button];
}

- (void)addCamerarollButton:(LmCmViewBarButton *)button
{
    _camerarollButton = button;
    [self addSubview:button];
}

- (void)addLastPhotoButton:(LmCmViewBarButton *)button
{
    _lastPhotoButton = button;
    [self addSubview:button];
}

- (void)layoutViews
{
    if ([PtSharedApp instance].leftHandedUI) {
        _settingsButton.center = CGPointMake([self width] - [_settingsButton width] * 3.0f / 2.0f - 10.0f, [self height] / 2.0f);
        _generalButton.center = CGPointMake([self width] - [_generalButton width] / 2.0f - 10.0f, [self height] / 2.0f);
        _camerarollButton.center = CGPointMake([_camerarollButton width] / 2.0f + 10.0f, [self height] / 2.0f);
        _lastPhotoButton.center = CGPointMake([_lastPhotoButton width] * 3.0f / 2.0f + 10.0f, [self height] / 2.0f);
    }else{
        _lastPhotoButton.center = CGPointMake([self width] - [_lastPhotoButton width] * 3.0f / 2.0f - 10.0f, [self height] / 2.0f);
        _camerarollButton.center = CGPointMake([self width] - [_camerarollButton width] / 2.0f - 10.0f, [self height] / 2.0f);
        _generalButton.center = CGPointMake([_generalButton width] / 2.0f + 10.0f, [self height] / 2.0f);
        _settingsButton.center = CGPointMake([_settingsButton width] * 3.0f / 2.0f + 10.0f, [self height] / 2.0f);
    }
}

@end
