//
//  LmButtonShutter.m
//  Lumina
//
//  Created by SSC on 2014/05/22.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "LmCmButtonShutter.h"

@implementation LmCmButtonShutter

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addTarget:self action:@selector(didTouchDown:) forControlEvents:UIControlEventTouchDown];
        _holding = NO;
        _orientation = [MotionOrientation sharedInstance].deviceOrientation;
    }
    return self;
}

- (void)didTouchDown:(id)sender
{
    self.holding = YES;
}

- (void)setHolding:(BOOL)holding
{
    _holding = holding;
    [self setNeedsDisplay];
}

- (void)setSoundEnabled:(BOOL)soundEnabled
{
    _soundEnabled = soundEnabled;
    [self setNeedsDisplay];
}

- (void)setOrientation:(UIDeviceOrientation)orientation
{
    _orientation = orientation;
    [self setNeedsDisplay];
}

- (void)setShooting:(BOOL)shooting
{
    _shooting = shooting;
    if (shooting) {
        self.alpha = 0.50f;
    }else{
        self.alpha = 1.0f;
    }
}

- (void)drawRect:(CGRect)rect
{
    float lineWidth = 3.0f;
    float radius = rect.size.width / 2.0f - 6.0f;
    UIColor* color = [UIColor whiteColor];
    UIColor* ovalColor = color;
    if (_holding) {
        ovalColor = [UIColor colorWithWhite:1.0f alpha:0.10f];
    }
    UIColor* pictColor = [LmCmSharedCamera bottomBarColor];
    
    //// Stroke Drawing
    UIBezierPath* strokePath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(lineWidth / 2.0f, lineWidth / 2.0f, rect.size.width - lineWidth, rect.size.height - lineWidth)];
    [color setStroke];
    strokePath.lineWidth = lineWidth;
    [strokePath stroke];
    
    //// Oval Drawing
    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(rect.size.width / 2.0f - radius, rect.size.height / 2.0f - radius, radius * 2.0f, radius * 2.0f)];
    [ovalColor setFill];
    [ovalPath fill];
    
    if (!_soundEnabled && !_holding) {
        
        CGAffineTransform rot = CGAffineTransformMakeRotation([UIView angleByDeviceOrientation:_orientation]);
        CGAffineTransform move = CGAffineTransformMakeTranslation(rect.size.width / 2.0f, rect.size.height / 2.0f);
        CGAffineTransform complex = CGAffineTransformConcat(rot, move);
        
        //// Bezier 2 Drawing
        UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
        [bezier2Path moveToPoint: CGPointMake(1.59, -1.62)];
        [bezier2Path addLineToPoint: CGPointMake(-4.37, -6.11)];
        [bezier2Path addLineToPoint: CGPointMake(1.59, -12.5)];
        [bezier2Path addLineToPoint: CGPointMake(1.59, -1.62)];
        [bezier2Path closePath];
        [bezier2Path moveToPoint: CGPointMake(6.53, 2.09)];
        [bezier2Path addLineToPoint: CGPointMake(4.59, 0.63)];
        [bezier2Path addCurveToPoint: CGPointMake(2.84, -7.47) controlPoint1: CGPointMake(4.61, -2.14) controlPoint2: CGPointMake(4.03, -4.91)];
        [bezier2Path addLineToPoint: CGPointMake(4.49, -8.67)];
        [bezier2Path addCurveToPoint: CGPointMake(6.53, 2.09) controlPoint1: CGPointMake(6.13, -5.3) controlPoint2: CGPointMake(6.81, -1.58)];
        [bezier2Path closePath];
        [bezier2Path moveToPoint: CGPointMake(10.22, 4.81)];
        [bezier2Path addLineToPoint: CGPointMake(8.4, 3.49)];
        [bezier2Path addCurveToPoint: CGPointMake(6.13, -9.87) controlPoint1: CGPointMake(8.99, -1.04) controlPoint2: CGPointMake(8.23, -5.71)];
        [bezier2Path addLineToPoint: CGPointMake(7.76, -11.06)];
        [bezier2Path addCurveToPoint: CGPointMake(10.22, 4.81) controlPoint1: CGPointMake(10.33, -6.14) controlPoint2: CGPointMake(11.15, -0.55)];
        [bezier2Path closePath];
        [bezier2Path moveToPoint: CGPointMake(5.6, 6.89)];
        [bezier2Path addCurveToPoint: CGPointMake(4.83, 8.93) controlPoint1: CGPointMake(5.38, 7.58) controlPoint2: CGPointMake(5.13, 8.26)];
        [bezier2Path addLineToPoint: CGPointMake(3.17, 7.72)];
        [bezier2Path addCurveToPoint: CGPointMake(3.9, 5.61) controlPoint1: CGPointMake(3.46, 7.03) controlPoint2: CGPointMake(3.7, 6.32)];
        [bezier2Path addLineToPoint: CGPointMake(5.6, 6.89)];
        [bezier2Path closePath];
        [bezier2Path moveToPoint: CGPointMake(12.68, 8.21)];
        [bezier2Path addLineToPoint: CGPointMake(11.48, 9.81)];
        [bezier2Path addLineToPoint: CGPointMake(-12.5, -8.21)];
        [bezier2Path addLineToPoint: CGPointMake(-11.3, -9.81)];
        [bezier2Path addLineToPoint: CGPointMake(12.68, 8.21)];
        [bezier2Path closePath];
        [bezier2Path moveToPoint: CGPointMake(8.96, 9.41)];
        [bezier2Path addCurveToPoint: CGPointMake(8.15, 11.3) controlPoint1: CGPointMake(8.71, 10.05) controlPoint2: CGPointMake(8.44, 10.68)];
        [bezier2Path addLineToPoint: CGPointMake(6.49, 10.13)];
        [bezier2Path addCurveToPoint: CGPointMake(7.29, 8.16) controlPoint1: CGPointMake(6.78, 9.48) controlPoint2: CGPointMake(7.05, 8.82)];
        [bezier2Path addLineToPoint: CGPointMake(8.96, 9.41)];
        [bezier2Path closePath];
        [bezier2Path moveToPoint: CGPointMake(1.59, 3.88)];
        [bezier2Path addLineToPoint: CGPointMake(1.59, 12.5)];
        [bezier2Path addLineToPoint: CGPointMake(-5.41, 5)];
        [bezier2Path addLineToPoint: CGPointMake(-11.41, 5)];
        [bezier2Path addLineToPoint: CGPointMake(-11.41, -5)];
        [bezier2Path addLineToPoint: CGPointMake(-10.22, -5)];
        [bezier2Path addLineToPoint: CGPointMake(1.59, 3.88)];
        [bezier2Path closePath];
        [bezier2Path applyTransform:complex];
        [pictColor setFill];
        [bezier2Path fill];
    }
}


@end
