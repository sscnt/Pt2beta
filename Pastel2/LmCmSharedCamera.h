//
//  LmCurrentCamera.h
//  Lumina
//
//  Created by SSC on 2014/05/22.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LmCmImageAsset;

@interface LmCmSharedCamera : NSObject

@property (nonatomic, assign) LmCmSharedCameraMode mode;
@property (nonatomic, assign) LmCmSharedCameraFocusMode  focusMode;
@property (nonatomic, assign) LmCmViewBarButtonFlashMode  flashMode;
@property (nonatomic, assign) LmCmViewCropSize cropSize;
@property (nonatomic, assign) int timerSeconds;
@property (nonatomic, assign) float zoom;
@property (nonatomic, assign) BOOL showGrid;
@property (nonatomic, assign) BOOL showZoomSlider;
@property (nonatomic, assign) BOOL volumeSnapEnabled;
@property (nonatomic, assign) BOOL soundEnabled;

+ (LmCmSharedCamera*)instance;

+ (BOOL)isTimerEnabled;
+ (int)timerSeconds;

+ (LmCmSharedCameraMode)currentMode;
+ (void)setMode:(LmCmSharedCameraMode)mode;

+ (void)setZoom:(float)zoom;
+ (float)maxZoomScaleSupported;

+ (UIImage*)cropImage:(UIImage*)image WithCropSize:(LmCmViewCropSize)cropSize;

#pragma mark settings

+ (float)topBarHeight;
+ (float)bottomBarHeight;
+ (CGRect)shutterButtonRect;
+ (UIColor*)topBarColor;
+ (UIColor*)bottomBarColor;
+ (UIColor*)topBarTransparentColor;
+ (UIColor*)bottomBarTransparentColor;
+ (UIColor*)cropMaskColor;

+ (UIColor*)zoomSliderBgColor;
+ (UIColor*)settingsBgColor;

@end
