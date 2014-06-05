//
//  LmCmViewBarButton.m
//  Lumina
//
//  Created by SSC on 2014/05/24.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "LmCmViewBarButton.h"

@implementation LmCmViewBarButton

- (id)initWithType:(LmCmViewBarButtonType)type
{
    CGRect frame;
    switch (type) {
        case LmCmViewBarButtonTypeFlash:
            frame = CGRectMake(0.0f, 0.0f, 88.0f, [LmCmSharedCamera topBarHeight]);
            break;
        case LmCmViewBarButtonTypeSwitchCamera:
        case LmCmViewBarButtonTypeCrop:
            frame = CGRectMake(0.0f, 0.0f, [LmCmSharedCamera topBarHeight], [LmCmSharedCamera topBarHeight]);
            break;
        default:
            frame = CGRectMake(0.0f, 0.0f, [LmCmSharedCamera topBarHeight], [LmCmSharedCamera bottomBarHeight]);
            break;
    }
    self = [super initWithFrame:frame];
    if (self) {
        _type = type;
        if (type == LmCmViewBarButtonTypeFlash) {
            _textLabel = [[VnViewLabel alloc] initWithFrame:CGRectMake(40.0f, 0.0f, frame.size.width - frame.size.height, frame.size.height)];
            _textLabel.fontSize = 15.0f;
            _textLabel.textAlignment = NSTextAlignmentLeft;
            [self addSubview:_textLabel];
            self.flashMode = LmCmViewBarButtonFlashModeOff;
        }
    }
    return self;
}

- (void)addImage:(UIImage *)image
{
    if (_imgView == nil) {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 30.0f, 30.0f)];
        _imgView.center = CGPointMake(self.width / 2.0f, self.height / 2.0f);
        [self addSubview:_imgView];
    }
    _imgView.image = image;
}

- (void)setFlashMode:(LmCmViewBarButtonFlashMode)flashMode
{
    _flashMode = flashMode;
    [self applyFlashModeText];
}

- (void)applyFlashModeText
{
    switch (_flashMode) {
        case LmCmViewBarButtonFlashModeOff:
            _textLabel.text = NSLocalizedString(@"Off", nil);
            break;
        case LmCmViewBarButtonFlashModeOn:
            _textLabel.text = NSLocalizedString(@"On", nil);
            break;
        case LmCmViewBarButtonFlashModeAuto:
            _textLabel.text = NSLocalizedString(@"Auto", nil);
            break;
            
        default:
            break;
    }
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (selected) {
        self.alpha = 0.50f;
    }else{
        self.alpha = 1.0f;
    }
}

- (void)drawRect:(CGRect)rect
{
    //// Color Declarations
    UIColor* color = [UIColor colorWithWhite:0.90f alpha:1.0f];

    switch (_type) {
        case LmCmViewBarButtonTypeSettings:
        {            
            
            //// Settings Drawing
            UIBezierPath* settingsPath = [UIBezierPath bezierPath];
            [settingsPath moveToPoint: CGPointMake(21.05, 32.09)];
            [settingsPath addLineToPoint: CGPointMake(20.25, 34.79)];
            [settingsPath addCurveToPoint: CGPointMake(17.57, 35.9) controlPoint1: CGPointMake(19.27, 35.03) controlPoint2: CGPointMake(18.43, 35.38)];
            [settingsPath addLineToPoint: CGPointMake(15.1, 34.55)];
            [settingsPath addCurveToPoint: CGPointMake(13.05, 36.6) controlPoint1: CGPointMake(14.3, 35.18) controlPoint2: CGPointMake(13.68, 35.8)];
            [settingsPath addLineToPoint: CGPointMake(14.4, 39.07)];
            [settingsPath addCurveToPoint: CGPointMake(13.29, 41.75) controlPoint1: CGPointMake(13.87, 39.93) controlPoint2: CGPointMake(13.53, 40.77)];
            [settingsPath addLineToPoint: CGPointMake(10.59, 42.55)];
            [settingsPath addCurveToPoint: CGPointMake(10.59, 45.44) controlPoint1: CGPointMake(10.47, 43.56) controlPoint2: CGPointMake(10.47, 44.44)];
            [settingsPath addLineToPoint: CGPointMake(13.29, 46.24)];
            [settingsPath addCurveToPoint: CGPointMake(14.4, 48.92) controlPoint1: CGPointMake(13.53, 47.22) controlPoint2: CGPointMake(13.87, 48.06)];
            [settingsPath addLineToPoint: CGPointMake(13.05, 51.4)];
            [settingsPath addCurveToPoint: CGPointMake(15.1, 53.44) controlPoint1: CGPointMake(13.68, 52.19) controlPoint2: CGPointMake(14.3, 52.82)];
            [settingsPath addLineToPoint: CGPointMake(17.57, 52.1)];
            [settingsPath addCurveToPoint: CGPointMake(20.25, 53.21) controlPoint1: CGPointMake(18.43, 52.62) controlPoint2: CGPointMake(19.27, 52.97)];
            [settingsPath addLineToPoint: CGPointMake(21.05, 55.91)];
            [settingsPath addCurveToPoint: CGPointMake(23.94, 55.91) controlPoint1: CGPointMake(22.06, 56.02) controlPoint2: CGPointMake(22.94, 56.02)];
            [settingsPath addLineToPoint: CGPointMake(24.74, 53.21)];
            [settingsPath addCurveToPoint: CGPointMake(27.42, 52.1) controlPoint1: CGPointMake(25.72, 52.97) controlPoint2: CGPointMake(26.56, 52.62)];
            [settingsPath addLineToPoint: CGPointMake(29.9, 53.44)];
            [settingsPath addCurveToPoint: CGPointMake(31.94, 51.4) controlPoint1: CGPointMake(30.69, 52.82) controlPoint2: CGPointMake(31.31, 52.19)];
            [settingsPath addLineToPoint: CGPointMake(30.6, 48.92)];
            [settingsPath addCurveToPoint: CGPointMake(31.71, 46.24) controlPoint1: CGPointMake(31.12, 48.06) controlPoint2: CGPointMake(31.47, 47.22)];
            [settingsPath addLineToPoint: CGPointMake(34.41, 45.44)];
            [settingsPath addCurveToPoint: CGPointMake(34.41, 42.55) controlPoint1: CGPointMake(34.52, 44.44) controlPoint2: CGPointMake(34.52, 43.56)];
            [settingsPath addLineToPoint: CGPointMake(31.71, 41.75)];
            [settingsPath addCurveToPoint: CGPointMake(30.6, 39.07) controlPoint1: CGPointMake(31.47, 40.77) controlPoint2: CGPointMake(31.12, 39.93)];
            [settingsPath addLineToPoint: CGPointMake(31.94, 36.6)];
            [settingsPath addCurveToPoint: CGPointMake(29.9, 34.55) controlPoint1: CGPointMake(31.31, 35.8) controlPoint2: CGPointMake(30.69, 35.18)];
            [settingsPath addLineToPoint: CGPointMake(27.42, 35.9)];
            [settingsPath addCurveToPoint: CGPointMake(24.74, 34.79) controlPoint1: CGPointMake(26.56, 35.38) controlPoint2: CGPointMake(25.72, 35.03)];
            [settingsPath addLineToPoint: CGPointMake(23.94, 32.09)];
            [settingsPath addCurveToPoint: CGPointMake(21.05, 32.09) controlPoint1: CGPointMake(22.94, 31.97) controlPoint2: CGPointMake(22.06, 31.97)];
            [settingsPath closePath];
            [settingsPath moveToPoint: CGPointMake(18.73, 43.93)];
            [settingsPath addCurveToPoint: CGPointMake(22.5, 40.23) controlPoint1: CGPointMake(18.73, 41.93) controlPoint2: CGPointMake(20.49, 40.23)];
            [settingsPath addCurveToPoint: CGPointMake(26.26, 43.93) controlPoint1: CGPointMake(24.5, 40.23) controlPoint2: CGPointMake(26.26, 41.93)];
            [settingsPath addCurveToPoint: CGPointMake(22.5, 47.76) controlPoint1: CGPointMake(26.26, 45.93) controlPoint2: CGPointMake(24.5, 47.76)];
            [settingsPath addCurveToPoint: CGPointMake(18.73, 43.93) controlPoint1: CGPointMake(20.49, 47.76) controlPoint2: CGPointMake(18.73, 45.93)];
            [settingsPath closePath];
            settingsPath.miterLimit = 4;
            
            settingsPath.usesEvenOddFillRule = YES;
            
            [color setFill];
            [settingsPath fill];
            

        }
            break;
        case LmCmViewBarButtonTypeCrop:
        {
            
            //// Bezier 5 Drawing
            UIBezierPath* bezier5Path = [UIBezierPath bezierPath];
            [bezier5Path moveToPoint: CGPointMake(28.29, 19)];
            [bezier5Path addLineToPoint: CGPointMake(19.5, 19)];
            [bezier5Path addLineToPoint: CGPointMake(19.5, 27.79)];
            [bezier5Path addLineToPoint: CGPointMake(28.29, 19)];
            [bezier5Path closePath];
            [bezier5Path moveToPoint: CGPointMake(29, 19.71)];
            [bezier5Path addLineToPoint: CGPointMake(20.21, 28.5)];
            [bezier5Path addLineToPoint: CGPointMake(29, 28.5)];
            [bezier5Path addLineToPoint: CGPointMake(29, 19.71)];
            [bezier5Path closePath];
            [bezier5Path moveToPoint: CGPointMake(19.5, 16.5)];
            [bezier5Path addLineToPoint: CGPointMake(30.79, 16.5)];
            [bezier5Path addLineToPoint: CGPointMake(32.57, 14.72)];
            [bezier5Path addLineToPoint: CGPointMake(33.28, 15.43)];
            [bezier5Path addLineToPoint: CGPointMake(31.5, 17.21)];
            [bezier5Path addLineToPoint: CGPointMake(31.5, 19)];
            [bezier5Path addLineToPoint: CGPointMake(31.5, 28.5)];
            [bezier5Path addLineToPoint: CGPointMake(34.5, 28.5)];
            [bezier5Path addLineToPoint: CGPointMake(34.5, 31)];
            [bezier5Path addLineToPoint: CGPointMake(31.5, 31)];
            [bezier5Path addLineToPoint: CGPointMake(31.5, 34)];
            [bezier5Path addLineToPoint: CGPointMake(29, 34)];
            [bezier5Path addLineToPoint: CGPointMake(29, 31)];
            [bezier5Path addLineToPoint: CGPointMake(17, 31)];
            [bezier5Path addLineToPoint: CGPointMake(17, 19)];
            [bezier5Path addLineToPoint: CGPointMake(14, 19)];
            [bezier5Path addLineToPoint: CGPointMake(14, 16.5)];
            [bezier5Path addLineToPoint: CGPointMake(17, 16.5)];
            [bezier5Path addLineToPoint: CGPointMake(17, 13.5)];
            [bezier5Path addLineToPoint: CGPointMake(19.5, 13.5)];
            [bezier5Path addLineToPoint: CGPointMake(19.5, 16.5)];
            [bezier5Path closePath];
            [color setFill];
            [bezier5Path fill];
        }
            break;
        case LmCmViewBarButtonTypeCameraRoll:
        {
            
            //// Cameraroll Drawing
            UIBezierPath* camerarollPath = [UIBezierPath bezierPath];
            [camerarollPath moveToPoint: CGPointMake(11.5, 50)];
            [camerarollPath addLineToPoint: CGPointMake(14, 50)];
            [camerarollPath addLineToPoint: CGPointMake(14, 35.5)];
            [camerarollPath addLineToPoint: CGPointMake(29, 35.5)];
            [camerarollPath addLineToPoint: CGPointMake(29, 33)];
            [camerarollPath addLineToPoint: CGPointMake(11.5, 33)];
            [camerarollPath addLineToPoint: CGPointMake(11.5, 50)];
            [camerarollPath closePath];
            [camerarollPath moveToPoint: CGPointMake(20.2, 43.23)];
            [camerarollPath addCurveToPoint: CGPointMake(21.73, 44.77) controlPoint1: CGPointMake(20.2, 44.08) controlPoint2: CGPointMake(20.88, 44.77)];
            [camerarollPath addCurveToPoint: CGPointMake(23.27, 43.23) controlPoint1: CGPointMake(22.58, 44.77) controlPoint2: CGPointMake(23.27, 44.08)];
            [camerarollPath addCurveToPoint: CGPointMake(21.73, 41.7) controlPoint1: CGPointMake(23.27, 42.38) controlPoint2: CGPointMake(22.58, 41.7)];
            [camerarollPath addCurveToPoint: CGPointMake(20.2, 43.23) controlPoint1: CGPointMake(20.88, 41.7) controlPoint2: CGPointMake(20.2, 42.38)];
            [camerarollPath closePath];
            [camerarollPath moveToPoint: CGPointMake(15.5, 37)];
            [camerarollPath addLineToPoint: CGPointMake(15.5, 55)];
            [camerarollPath addLineToPoint: CGPointMake(33.5, 55)];
            [camerarollPath addLineToPoint: CGPointMake(33.5, 37)];
            [camerarollPath addLineToPoint: CGPointMake(15.5, 37)];
            [camerarollPath closePath];
            [camerarollPath moveToPoint: CGPointMake(31, 39.5)];
            [camerarollPath addLineToPoint: CGPointMake(31, 48.61)];
            [camerarollPath addCurveToPoint: CGPointMake(28.01, 45.32) controlPoint1: CGPointMake(30.07, 47.54) controlPoint2: CGPointMake(28.45, 45.84)];
            [camerarollPath addCurveToPoint: CGPointMake(26.39, 45.15) controlPoint1: CGPointMake(27.18, 44.31) controlPoint2: CGPointMake(26.39, 45.15)];
            [camerarollPath addLineToPoint: CGPointMake(23.78, 48.41)];
            [camerarollPath addCurveToPoint: CGPointMake(25.37, 50.78) controlPoint1: CGPointMake(23.78, 48.41) controlPoint2: CGPointMake(24.48, 49.57)];
            [camerarollPath addCurveToPoint: CGPointMake(24.15, 51.36) controlPoint1: CGPointMake(25.31, 51.93) controlPoint2: CGPointMake(24.15, 51.36)];
            [camerarollPath addCurveToPoint: CGPointMake(21.63, 48.01) controlPoint1: CGPointMake(24.15, 51.36) controlPoint2: CGPointMake(22.31, 48.79)];
            [camerarollPath addCurveToPoint: CGPointMake(20.29, 48.12) controlPoint1: CGPointMake(20.96, 47.22) controlPoint2: CGPointMake(20.29, 48.12)];
            [camerarollPath addLineToPoint: CGPointMake(18, 50.59)];
            [camerarollPath addLineToPoint: CGPointMake(18, 39.5)];
            [camerarollPath addLineToPoint: CGPointMake(31, 39.5)];
            [camerarollPath closePath];
            camerarollPath.miterLimit = 4;
            
            camerarollPath.usesEvenOddFillRule = YES;
            
            [color setFill];
            [camerarollPath fill];            

        }
            break;
        case LmCmViewBarButtonTypeSwitchCamera:
        {
            
            //// Bezier Drawing
            UIBezierPath* bezierPath = [UIBezierPath bezierPath];
            [bezierPath moveToPoint: CGPointMake(31.57, 17.28)];
            [bezierPath addCurveToPoint: CGPointMake(34.29, 24) controlPoint1: CGPointMake(33.38, 19.14) controlPoint2: CGPointMake(34.29, 21.57)];
            [bezierPath addLineToPoint: CGPointMake(36.5, 24)];
            [bezierPath addLineToPoint: CGPointMake(32.96, 29.43)];
            [bezierPath addLineToPoint: CGPointMake(29.42, 24)];
            [bezierPath addLineToPoint: CGPointMake(31.63, 24)];
            [bezierPath addCurveToPoint: CGPointMake(29.69, 19.2) controlPoint1: CGPointMake(31.63, 22.26) controlPoint2: CGPointMake(30.99, 20.53)];
            [bezierPath addCurveToPoint: CGPointMake(20.73, 18.81) controlPoint1: CGPointMake(27.24, 16.69) controlPoint2: CGPointMake(23.34, 16.56)];
            [bezierPath addLineToPoint: CGPointMake(19.25, 16.54)];
            [bezierPath addCurveToPoint: CGPointMake(31.57, 17.28) controlPoint1: CGPointMake(22.9, 13.59) controlPoint2: CGPointMake(28.2, 13.84)];
            [bezierPath closePath];
            [bezierPath moveToPoint: CGPointMake(20.58, 24)];
            [bezierPath addLineToPoint: CGPointMake(18.37, 24)];
            [bezierPath addCurveToPoint: CGPointMake(20.31, 28.8) controlPoint1: CGPointMake(18.37, 25.74) controlPoint2: CGPointMake(19.01, 27.47)];
            [bezierPath addCurveToPoint: CGPointMake(29.27, 29.19) controlPoint1: CGPointMake(22.76, 31.31) controlPoint2: CGPointMake(26.66, 31.44)];
            [bezierPath addLineToPoint: CGPointMake(30.75, 31.46)];
            [bezierPath addCurveToPoint: CGPointMake(18.43, 30.72) controlPoint1: CGPointMake(27.1, 34.41) controlPoint2: CGPointMake(21.8, 34.16)];
            [bezierPath addCurveToPoint: CGPointMake(15.71, 24) controlPoint1: CGPointMake(16.62, 28.86) controlPoint2: CGPointMake(15.71, 26.43)];
            [bezierPath addLineToPoint: CGPointMake(13.5, 24)];
            [bezierPath addLineToPoint: CGPointMake(17.04, 18.57)];
            [bezierPath addLineToPoint: CGPointMake(20.58, 24)];
            [bezierPath closePath];
            [color setFill];
            [bezierPath fill];
        }
            break;
            
        case LmCmViewBarButtonTypeFlash:
        {
            
            //// Bezier 2 Drawing
            UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
            [bezier2Path moveToPoint: CGPointMake(27.41, 13.92)];
            [bezier2Path addLineToPoint: CGPointMake(20.69, 15.49)];
            [bezier2Path addLineToPoint: CGPointMake(18.13, 27.4)];
            [bezier2Path addLineToPoint: CGPointMake(24.85, 26.46)];
            [bezier2Path addLineToPoint: CGPointMake(23.57, 36.48)];
            [bezier2Path addLineToPoint: CGPointMake(32.22, 21.13)];
            [bezier2Path addLineToPoint: CGPointMake(23.89, 22.38)];
            [bezier2Path addLineToPoint: CGPointMake(27.41, 13.92)];
            [bezier2Path closePath];
            bezier2Path.miterLimit = 4;
            
            bezier2Path.usesEvenOddFillRule = YES;
            
            [color setFill];
            [bezier2Path fill];
            
        }
            break;
        case LmCmViewBarButtonTypeGeneralSettings:
        {
            
            //// General Drawing
            UIBezierPath* generalPath = [UIBezierPath bezierPath];
            [generalPath moveToPoint: CGPointMake(12, 37)];
            [generalPath addLineToPoint: CGPointMake(33, 37)];
            [generalPath addLineToPoint: CGPointMake(33, 33)];
            [generalPath addLineToPoint: CGPointMake(12, 33)];
            [generalPath addLineToPoint: CGPointMake(12, 37)];
            [generalPath closePath];
            [generalPath moveToPoint: CGPointMake(12, 55)];
            [generalPath addLineToPoint: CGPointMake(13, 55)];
            [generalPath addLineToPoint: CGPointMake(13, 37)];
            [generalPath addLineToPoint: CGPointMake(12, 37)];
            [generalPath addLineToPoint: CGPointMake(12, 55)];
            [generalPath closePath];
            [generalPath moveToPoint: CGPointMake(32, 55)];
            [generalPath addLineToPoint: CGPointMake(33, 55)];
            [generalPath addLineToPoint: CGPointMake(33, 37)];
            [generalPath addLineToPoint: CGPointMake(32, 37)];
            [generalPath addLineToPoint: CGPointMake(32, 55)];
            [generalPath closePath];
            [generalPath moveToPoint: CGPointMake(13, 55)];
            [generalPath addLineToPoint: CGPointMake(32, 55)];
            [generalPath addLineToPoint: CGPointMake(32, 54)];
            [generalPath addLineToPoint: CGPointMake(13, 54)];
            [generalPath addLineToPoint: CGPointMake(13, 55)];
            [generalPath closePath];
            [generalPath moveToPoint: CGPointMake(16, 42)];
            [generalPath addLineToPoint: CGPointMake(29, 42)];
            [generalPath addLineToPoint: CGPointMake(29, 40)];
            [generalPath addLineToPoint: CGPointMake(16, 40)];
            [generalPath addLineToPoint: CGPointMake(16, 42)];
            [generalPath closePath];
            [generalPath moveToPoint: CGPointMake(16, 46.5)];
            [generalPath addLineToPoint: CGPointMake(29, 46.5)];
            [generalPath addLineToPoint: CGPointMake(29, 44.5)];
            [generalPath addLineToPoint: CGPointMake(16, 44.5)];
            [generalPath addLineToPoint: CGPointMake(16, 46.5)];
            [generalPath closePath];
            [generalPath moveToPoint: CGPointMake(16, 51)];
            [generalPath addLineToPoint: CGPointMake(29, 51)];
            [generalPath addLineToPoint: CGPointMake(29, 49)];
            [generalPath addLineToPoint: CGPointMake(16, 49)];
            [generalPath addLineToPoint: CGPointMake(16, 51)];
            [generalPath closePath];
            [color setFill];
            [generalPath fill];
            
            
        }
            break;
    }
}


@end
