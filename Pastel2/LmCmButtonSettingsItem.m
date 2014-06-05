//
//  LmCmButtonSettingsItem.m
//  Lumina
//
//  Created by SSC on 2014/05/24.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "LmCmButtonSettingsItem.h"

@implementation LmCmButtonSettingsItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        float padding = 40.0f;
        self.backgroundColor = [UIColor clearColor];
        _label = [[VnViewLabel alloc] initWithFrame:CGRectMake(padding, 0.0f, frame.size.width - padding, frame.size.height)];
        _label.fontSize = 17.0f;
        _label.textAlignment = NSTextAlignmentLeft;
        _label.minimumScaleFactor = 0.10f;
        [self addSubview:_label];
        
        if ([UIDevice isCurrentLanguageJapanese]) {
            if ([UIDevice isIOS6]) {
                [_label setY:2.0f];
            }else{
                [_label setY:1.0f];
            }
        }else{
            if ([UIDevice isIOS6]) {
                
            }else{
                [_label setY:-0.50f];
            }
        }
    }
    return self;
}

- (void)setActive:(BOOL)active
{
    _active = active;
    if (active) {
        self.alpha = 1.0f;
    }else{
        self.alpha = 0.30f;
    }
}

- (void)adjustLabelSize
{
    switch (_item) {
        case LmCmViewSettingsListItemVolumeSnap:
        {
            if ([UIDevice isCurrentLanguageJapanese]) {
                if ([UIDevice isIOS6]) {
                    [_label setY:1.0f];
                    _label.fontSize = 12.0f;
                }else{
                    _label.fontSize = 12.0f;
                }
            }else{
                if ([UIDevice isIOS6]) {
                    [_label setY:0.0f];
                }else{
                    
                }
            }
        }
            break;
            
        case LmCmViewSettingsListItemEnableSound:
        {
            if ([UIDevice isCurrentLanguageJapanese]) {
                if ([UIDevice isIOS6]) {
                    [_label setY:1.50f];
                    _label.fontSize = 13.0f;
                }else{
                    _label.fontSize = 13.0f;
                }
            }
        }
            break;
            
        default:
            break;
    }
}

- (void)setItem:(LmCmViewSettingsListItem)item
{
    _item = item;
    switch (item) {
        case LmCmViewSettingsListItemShowZoom:
            _label.text = NSLocalizedString(@"Zoom", nil);
            break;
        case LmCmViewSettingsListItemVolumeSnap:
            _label.text = NSLocalizedString(@"VolumeSnap", nil);
            if ([UIDevice isCurrentLanguageJapanese]) {
                
            }else{
                _label.fontSize = 13.0f;
                [_label setY:1.50f];
            }
            break;
        case LmCmViewSettingsListItemShowGrid:
            _label.text = NSLocalizedString(@"Grid", nil);
            break;
        case LmCmViewSettingsListItemEnableSound:
            _label.text = NSLocalizedString(@"Sound", nil);
            break;
        default:
            break;
    }
    [self adjustLabelSize];
}

- (void)drawRect:(CGRect)rect
{
    //// Color Declarations
    UIColor* color = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
    
    switch (_item) {
        case LmCmViewSettingsListItemShowGrid:
        {
            //// Bezier Drawing
            UIBezierPath* bezierPath = [UIBezierPath bezierPath];
            [bezierPath moveToPoint: CGPointMake(19, 15)];
            [bezierPath addLineToPoint: CGPointMake(19, 30)];
            [color setStroke];
            bezierPath.lineWidth = 2;
            [bezierPath stroke];
            
            
            //// Bezier 2 Drawing
            UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
            [bezier2Path moveToPoint: CGPointMake(26, 15)];
            [bezier2Path addLineToPoint: CGPointMake(26, 30)];
            [color setStroke];
            bezier2Path.lineWidth = 2;
            [bezier2Path stroke];
            
            
            //// Bezier 3 Drawing
            UIBezierPath* bezier3Path = [UIBezierPath bezierPath];
            [bezier3Path moveToPoint: CGPointMake(15, 19)];
            [bezier3Path addLineToPoint: CGPointMake(30, 19)];
            [color setStroke];
            bezier3Path.lineWidth = 2;
            [bezier3Path stroke];
            
            
            //// Bezier 4 Drawing
            UIBezierPath* bezier4Path = [UIBezierPath bezierPath];
            [bezier4Path moveToPoint: CGPointMake(15, 26)];
            [bezier4Path addLineToPoint: CGPointMake(30, 26)];
            [color setStroke];
            bezier4Path.lineWidth = 2;
            [bezier4Path stroke];
        }
            break;
        case LmCmViewSettingsListItemShowZoom:
        {
            
            //// Oval Drawing
            UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(16.5, 16.5, 11, 11)];
            [color setStroke];
            ovalPath.lineWidth = 2;
            [ovalPath stroke];
            
            
            //// Rounded Rectangle Drawing
            UIBezierPath* roundedRectanglePath = [UIBezierPath bezierPath];
            [roundedRectanglePath moveToPoint: CGPointMake(24.67, 26.09)];
            [roundedRectanglePath addLineToPoint: CGPointMake(28.21, 29.62)];
            [roundedRectanglePath addCurveToPoint: CGPointMake(29.62, 29.62) controlPoint1: CGPointMake(28.6, 30.01) controlPoint2: CGPointMake(29.23, 30.01)];
            [roundedRectanglePath addLineToPoint: CGPointMake(29.62, 29.62)];
            [roundedRectanglePath addCurveToPoint: CGPointMake(29.62, 28.21) controlPoint1: CGPointMake(30.01, 29.23) controlPoint2: CGPointMake(30.01, 28.6)];
            [roundedRectanglePath addLineToPoint: CGPointMake(26.09, 24.67)];
            [roundedRectanglePath addLineToPoint: CGPointMake(24.67, 26.09)];
            [roundedRectanglePath closePath];
            [color setFill];
            [roundedRectanglePath fill];
            
            
            //// Rectangle Drawing
            UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(19, 21, 6, 2)];
            [color setFill];
            [rectanglePath fill];
            
            
            //// Rectangle 2 Drawing
            UIBezierPath* rectangle2Path = [UIBezierPath bezierPathWithRect: CGRectMake(21, 19, 2, 6)];
            [color setFill];
            [rectangle2Path fill];

        }
            break;
        case LmCmViewSettingsListItemVolumeSnap:
        {
            //// Rectangle 3 Drawing
            UIBezierPath* rectangle3Path = [UIBezierPath bezierPathWithRect: CGRectMake(17, 18, 1.5, 12)];
            [color setFill];
            [rectangle3Path fill];
            
            
            //// Rectangle 4 Drawing
            UIBezierPath* rectangle4Path = [UIBezierPath bezierPathWithRect: CGRectMake(28.5, 18, 1.5, 12)];
            [color setFill];
            [rectangle4Path fill];
            
            
            //// Bezier 5 Drawing
            UIBezierPath* bezier5Path = [UIBezierPath bezierPath];
            [bezier5Path moveToPoint: CGPointMake(25.12, 17)];
            [bezier5Path addLineToPoint: CGPointMake(21.88, 17)];
            [bezier5Path addLineToPoint: CGPointMake(21.88, 18)];
            [bezier5Path addLineToPoint: CGPointMake(25.12, 18)];
            [bezier5Path addLineToPoint: CGPointMake(25.12, 17)];
            [bezier5Path closePath];
            [bezier5Path moveToPoint: CGPointMake(30, 17)];
            [bezier5Path addLineToPoint: CGPointMake(30, 19)];
            [bezier5Path addLineToPoint: CGPointMake(17, 19)];
            [bezier5Path addLineToPoint: CGPointMake(17, 17)];
            [bezier5Path addCurveToPoint: CGPointMake(19.17, 15) controlPoint1: CGPointMake(17, 15.9) controlPoint2: CGPointMake(17.97, 15)];
            [bezier5Path addLineToPoint: CGPointMake(27.83, 15)];
            [bezier5Path addCurveToPoint: CGPointMake(30, 17) controlPoint1: CGPointMake(29.03, 15) controlPoint2: CGPointMake(30, 15.9)];
            [bezier5Path closePath];
            [color setFill];
            [bezier5Path fill];
            
            
            //// Rectangle 5 Drawing
            UIBezierPath* rectangle5Path = [UIBezierPath bezierPathWithRect: CGRectMake(15, 24, 1.5, 2.5)];
            [color setFill];
            [rectangle5Path fill];
            
            
            //// Rectangle 6 Drawing
            UIBezierPath* rectangle6Path = [UIBezierPath bezierPathWithRect: CGRectMake(15, 20.5, 1.5, 2.5)];
            [color setFill];
            [rectangle6Path fill];
        }
            break;
        case LmCmViewSettingsListItemEnableSound:
        {
            
            //// Bezier 6 Drawing
            UIBezierPath* bezier6Path = [UIBezierPath bezierPath];
            [bezier6Path moveToPoint: CGPointMake(19.15, 19.53)];
            [bezier6Path addLineToPoint: CGPointMake(15.02, 19.53)];
            [bezier6Path addLineToPoint: CGPointMake(15.02, 25.43)];
            [bezier6Path addLineToPoint: CGPointMake(19.1, 25.43)];
            [bezier6Path addLineToPoint: CGPointMake(23, 29.46)];
            [bezier6Path addLineToPoint: CGPointMake(23, 15.46)];
            [bezier6Path addLineToPoint: CGPointMake(19.15, 19.53)];
            [bezier6Path closePath];
            [bezier6Path moveToPoint: CGPointMake(24.12, 19.18)];
            [bezier6Path addCurveToPoint: CGPointMake(25.02, 22.51) controlPoint1: CGPointMake(24.69, 20.15) controlPoint2: CGPointMake(25.02, 21.29)];
            [bezier6Path addCurveToPoint: CGPointMake(24.01, 26.03) controlPoint1: CGPointMake(25.02, 23.81) controlPoint2: CGPointMake(24.65, 25.02)];
            [bezier6Path addLineToPoint: CGPointMake(25.02, 26.96)];
            [bezier6Path addCurveToPoint: CGPointMake(26.36, 22.51) controlPoint1: CGPointMake(25.87, 25.7) controlPoint2: CGPointMake(26.36, 24.17)];
            [bezier6Path addCurveToPoint: CGPointMake(25.12, 18.21) controlPoint1: CGPointMake(26.36, 20.92) controlPoint2: CGPointMake(25.91, 19.44)];
            [bezier6Path addLineToPoint: CGPointMake(24.12, 19.18)];
            [bezier6Path closePath];
            [bezier6Path moveToPoint: CGPointMake(26.3, 17.08)];
            [bezier6Path addCurveToPoint: CGPointMake(27.93, 22.51) controlPoint1: CGPointMake(27.33, 18.62) controlPoint2: CGPointMake(27.93, 20.49)];
            [bezier6Path addCurveToPoint: CGPointMake(26.22, 28.06) controlPoint1: CGPointMake(27.93, 24.58) controlPoint2: CGPointMake(27.3, 26.5)];
            [bezier6Path addLineToPoint: CGPointMake(27.22, 28.98)];
            [bezier6Path addCurveToPoint: CGPointMake(29.26, 22.51) controlPoint1: CGPointMake(28.5, 27.17) controlPoint2: CGPointMake(29.26, 24.94)];
            [bezier6Path addCurveToPoint: CGPointMake(27.28, 16.14) controlPoint1: CGPointMake(29.26, 20.13) controlPoint2: CGPointMake(28.52, 17.93)];
            [bezier6Path addLineToPoint: CGPointMake(26.3, 17.08)];
            [bezier6Path closePath];
            bezier6Path.miterLimit = 4;
            
            bezier6Path.usesEvenOddFillRule = YES;
            
            [color setFill];
            [bezier6Path fill];

        }
            break;
        default:
            break;
    }
}


@end
