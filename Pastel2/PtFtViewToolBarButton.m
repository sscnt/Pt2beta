//
//  PtFtViewToolBarButton.m
//  Pastel2
//
//  Created by SSC on 2014/06/25.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "PtFtViewToolBarButton.h"

@implementation PtFtViewToolBarButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self addTarget:self action:@selector(didTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)setType:(PtFtViewToolBarButtonType)type
{
    _type = type;
    [self setNeedsDisplay];
}

- (void)didTouchUpInside:(PtFtViewToolBarButton *)sender
{
    [self.delegate didToolBarButtonTouchUpInside:self];
}

- (void)drawRect:(CGRect)rect
{
    
    CGAffineTransform move = CGAffineTransformMakeTranslation(rect.size.width / 2.0f, rect.size.height / 2.0f);
    //// Color Declarations
    UIColor* color = [UIColor colorWithWhite:1.0f alpha:0.80f];
    switch (_type) {
        case PtFtViewToolBarButtonTypeSlider:
        {
            
            //// Bezier Drawing
            UIBezierPath* SliderPath = [UIBezierPath bezierPath];
            [SliderPath moveToPoint: CGPointMake(-2.09, -5.41)];
            [SliderPath addLineToPoint: CGPointMake(-2.06, -5.34)];
            [SliderPath addCurveToPoint: CGPointMake(-2, -5) controlPoint1: CGPointMake(-2.02, -5.21) controlPoint2: CGPointMake(-2, -5.11)];
            [SliderPath addLineToPoint: CGPointMake(-2, -3.5)];
            [SliderPath addLineToPoint: CGPointMake(-1, -3.5)];
            [SliderPath addCurveToPoint: CGPointMake(-0.25, -3.16) controlPoint1: CGPointMake(-0.7, -3.5) controlPoint2: CGPointMake(-0.44, -3.37)];
            [SliderPath addCurveToPoint: CGPointMake(0, -2.5) controlPoint1: CGPointMake(-0.1, -2.99) controlPoint2: CGPointMake(0, -2.76)];
            [SliderPath addLineToPoint: CGPointMake(0, -2)];
            [SliderPath addCurveToPoint: CGPointMake(-1, -1) controlPoint1: CGPointMake(0, -1.45) controlPoint2: CGPointMake(-0.45, -1)];
            [SliderPath addLineToPoint: CGPointMake(-2, -1)];
            [SliderPath addLineToPoint: CGPointMake(-2, 5)];
            [SliderPath addCurveToPoint: CGPointMake(-2.14, 5.51) controlPoint1: CGPointMake(-2, 5.19) controlPoint2: CGPointMake(-2.05, 5.36)];
            [SliderPath addCurveToPoint: CGPointMake(-3, 6) controlPoint1: CGPointMake(-2.32, 5.8) controlPoint2: CGPointMake(-2.63, 6)];
            [SliderPath addLineToPoint: CGPointMake(-3.5, 6)];
            [SliderPath addCurveToPoint: CGPointMake(-4.5, 5) controlPoint1: CGPointMake(-4.05, 6) controlPoint2: CGPointMake(-4.5, 5.55)];
            [SliderPath addLineToPoint: CGPointMake(-4.5, -1)];
            [SliderPath addLineToPoint: CGPointMake(-5.5, -1)];
            [SliderPath addCurveToPoint: CGPointMake(-6.5, -2) controlPoint1: CGPointMake(-6.05, -1) controlPoint2: CGPointMake(-6.5, -1.45)];
            [SliderPath addLineToPoint: CGPointMake(-6.5, -2.5)];
            [SliderPath addCurveToPoint: CGPointMake(-5.5, -3.5) controlPoint1: CGPointMake(-6.5, -3.05) controlPoint2: CGPointMake(-6.05, -3.5)];
            [SliderPath addLineToPoint: CGPointMake(-4.5, -3.5)];
            [SliderPath addLineToPoint: CGPointMake(-4.5, -5)];
            [SliderPath addCurveToPoint: CGPointMake(-3.5, -6) controlPoint1: CGPointMake(-4.5, -5.55) controlPoint2: CGPointMake(-4.05, -6)];
            [SliderPath addLineToPoint: CGPointMake(-3, -6)];
            [SliderPath addCurveToPoint: CGPointMake(-2.09, -5.41) controlPoint1: CGPointMake(-2.59, -6) controlPoint2: CGPointMake(-2.25, -5.76)];
            [SliderPath addLineToPoint: CGPointMake(-2.08, -5.39)];
            [SliderPath addLineToPoint: CGPointMake(-2.09, -5.41)];
            [SliderPath closePath];
            [SliderPath moveToPoint: CGPointMake(4.5, -5)];
            [SliderPath addLineToPoint: CGPointMake(4.5, 1)];
            [SliderPath addLineToPoint: CGPointMake(5.5, 1)];
            [SliderPath addCurveToPoint: CGPointMake(6.45, 1.69) controlPoint1: CGPointMake(5.95, 1) controlPoint2: CGPointMake(6.32, 1.29)];
            [SliderPath addCurveToPoint: CGPointMake(6.5, 2) controlPoint1: CGPointMake(6.48, 1.79) controlPoint2: CGPointMake(6.5, 1.89)];
            [SliderPath addLineToPoint: CGPointMake(6.5, 2.5)];
            [SliderPath addCurveToPoint: CGPointMake(5.5, 3.5) controlPoint1: CGPointMake(6.5, 3.05) controlPoint2: CGPointMake(6.05, 3.5)];
            [SliderPath addLineToPoint: CGPointMake(4.5, 3.5)];
            [SliderPath addLineToPoint: CGPointMake(4.5, 5)];
            [SliderPath addCurveToPoint: CGPointMake(3.5, 6) controlPoint1: CGPointMake(4.5, 5.55) controlPoint2: CGPointMake(4.05, 6)];
            [SliderPath addLineToPoint: CGPointMake(3, 6)];
            [SliderPath addCurveToPoint: CGPointMake(2, 5) controlPoint1: CGPointMake(2.45, 6) controlPoint2: CGPointMake(2, 5.55)];
            [SliderPath addLineToPoint: CGPointMake(2, 3.5)];
            [SliderPath addLineToPoint: CGPointMake(1, 3.5)];
            [SliderPath addCurveToPoint: CGPointMake(0, 2.5) controlPoint1: CGPointMake(0.45, 3.5) controlPoint2: CGPointMake(0, 3.05)];
            [SliderPath addLineToPoint: CGPointMake(0, 2)];
            [SliderPath addCurveToPoint: CGPointMake(1, 1) controlPoint1: CGPointMake(0, 1.45) controlPoint2: CGPointMake(0.45, 1)];
            [SliderPath addLineToPoint: CGPointMake(2, 1)];
            [SliderPath addLineToPoint: CGPointMake(2, -5)];
            [SliderPath addCurveToPoint: CGPointMake(3, -6) controlPoint1: CGPointMake(2, -5.55) controlPoint2: CGPointMake(2.45, -6)];
            [SliderPath addLineToPoint: CGPointMake(3.5, -6)];
            [SliderPath addCurveToPoint: CGPointMake(4.5, -5) controlPoint1: CGPointMake(4.05, -6) controlPoint2: CGPointMake(4.5, -5.55)];
            [SliderPath closePath];
            [SliderPath moveToPoint: CGPointMake(7.5, -8.5)];
            [SliderPath addLineToPoint: CGPointMake(-7.5, -8.5)];
            [SliderPath addCurveToPoint: CGPointMake(-8.5, -7.5) controlPoint1: CGPointMake(-8.05, -8.5) controlPoint2: CGPointMake(-8.5, -8.05)];
            [SliderPath addLineToPoint: CGPointMake(-8.5, 7.5)];
            [SliderPath addCurveToPoint: CGPointMake(-7.5, 8.5) controlPoint1: CGPointMake(-8.5, 8.05) controlPoint2: CGPointMake(-8.05, 8.5)];
            [SliderPath addLineToPoint: CGPointMake(7.5, 8.5)];
            [SliderPath addCurveToPoint: CGPointMake(8.5, 7.5) controlPoint1: CGPointMake(8.05, 8.5) controlPoint2: CGPointMake(8.5, 8.05)];
            [SliderPath addLineToPoint: CGPointMake(8.5, -7.5)];
            [SliderPath addCurveToPoint: CGPointMake(7.5, -8.5) controlPoint1: CGPointMake(8.5, -8.05) controlPoint2: CGPointMake(8.05, -8.5)];
            [SliderPath closePath];
            [SliderPath moveToPoint: CGPointMake(11, -9)];
            [SliderPath addLineToPoint: CGPointMake(11, 9)];
            [SliderPath addCurveToPoint: CGPointMake(9, 11) controlPoint1: CGPointMake(11, 10.1) controlPoint2: CGPointMake(10.1, 11)];
            [SliderPath addLineToPoint: CGPointMake(-9, 11)];
            [SliderPath addCurveToPoint: CGPointMake(-11, 9) controlPoint1: CGPointMake(-10.1, 11) controlPoint2: CGPointMake(-11, 10.1)];
            [SliderPath addLineToPoint: CGPointMake(-11, -9)];
            [SliderPath addCurveToPoint: CGPointMake(-9, -11) controlPoint1: CGPointMake(-11, -10.1) controlPoint2: CGPointMake(-10.1, -11)];
            [SliderPath addLineToPoint: CGPointMake(9, -11)];
            [SliderPath addCurveToPoint: CGPointMake(11, -9) controlPoint1: CGPointMake(10.1, -11) controlPoint2: CGPointMake(11, -10.1)];
            [SliderPath closePath];
            [SliderPath applyTransform:move];
            [color setFill];
            [SliderPath fill];
        }
            break;
        case PtFtViewToolBarButtonTypeShuffle:
        {
            
            //// Bezier 4 Drawing
            UIBezierPath* ShufflePath = [UIBezierPath bezierPath];
            [ShufflePath moveToPoint: CGPointMake(5.6, -0.76)];
            [ShufflePath addCurveToPoint: CGPointMake(5.1, -0.76) controlPoint1: CGPointMake(5, -0.23) controlPoint2: CGPointMake(5.1, -0.76)];
            [ShufflePath addLineToPoint: CGPointMake(5.1, -3.26)];
            [ShufflePath addLineToPoint: CGPointMake(3.82, -3.11)];
            [ShufflePath addCurveToPoint: CGPointMake(2.83, -2.24) controlPoint1: CGPointMake(3.15, -3.11) controlPoint2: CGPointMake(2.83, -2.24)];
            [ShufflePath addCurveToPoint: CGPointMake(2.48, -1.64) controlPoint1: CGPointMake(2.83, -2.24) controlPoint2: CGPointMake(2.7, -2.01)];
            [ShufflePath addLineToPoint: CGPointMake(0.25, -4.68)];
            [ShufflePath addLineToPoint: CGPointMake(0.9, -5.77)];
            [ShufflePath addCurveToPoint: CGPointMake(3.1, -7.26) controlPoint1: CGPointMake(1.37, -6.71) controlPoint2: CGPointMake(3.1, -7.26)];
            [ShufflePath addLineToPoint: CGPointMake(5.1, -7.26)];
            [ShufflePath addLineToPoint: CGPointMake(5.1, -9.76)];
            [ShufflePath addCurveToPoint: CGPointMake(5.6, -9.76) controlPoint1: CGPointMake(5.1, -10.3) controlPoint2: CGPointMake(5.6, -9.76)];
            [ShufflePath addLineToPoint: CGPointMake(10.6, -5.26)];
            [ShufflePath addLineToPoint: CGPointMake(5.6, -0.76)];
            [ShufflePath closePath];
            [ShufflePath moveToPoint: CGPointMake(3.82, 3.58)];
            [ShufflePath addLineToPoint: CGPointMake(5.1, 3.74)];
            [ShufflePath addLineToPoint: CGPointMake(5.1, 1.24)];
            [ShufflePath addCurveToPoint: CGPointMake(5.77, 1.05) controlPoint1: CGPointMake(5.1, 1.24) controlPoint2: CGPointMake(5.17, 0.52)];
            [ShufflePath addLineToPoint: CGPointMake(10.6, 5.74)];
            [ShufflePath addLineToPoint: CGPointMake(5.6, 10.24)];
            [ShufflePath addCurveToPoint: CGPointMake(5.1, 10.24) controlPoint1: CGPointMake(5.6, 10.24) controlPoint2: CGPointMake(5.1, 10.77)];
            [ShufflePath addLineToPoint: CGPointMake(5.1, 7.74)];
            [ShufflePath addLineToPoint: CGPointMake(3.6, 7.74)];
            [ShufflePath addCurveToPoint: CGPointMake(0.9, 6.25) controlPoint1: CGPointMake(3.6, 7.74) controlPoint2: CGPointMake(1.37, 7.18)];
            [ShufflePath addLineToPoint: CGPointMake(-4.25, -2.44)];
            [ShufflePath addCurveToPoint: CGPointMake(-5.46, -3.26) controlPoint1: CGPointMake(-4.25, -2.44) controlPoint2: CGPointMake(-5.06, -3.26)];
            [ShufflePath addLineToPoint: CGPointMake(-10.4, -3.26)];
            [ShufflePath addLineToPoint: CGPointMake(-10.4, -7.26)];
            [ShufflePath addLineToPoint: CGPointMake(-4.4, -7.26)];
            [ShufflePath addCurveToPoint: CGPointMake(-2.62, -6.19) controlPoint1: CGPointMake(-4.4, -7.26) controlPoint2: CGPointMake(-3.22, -6.77)];
            [ShufflePath addCurveToPoint: CGPointMake(-2.59, -6.16) controlPoint1: CGPointMake(-2.61, -6.18) controlPoint2: CGPointMake(-2.6, -6.17)];
            [ShufflePath addCurveToPoint: CGPointMake(2.83, 2.72) controlPoint1: CGPointMake(-1.98, -5.55) controlPoint2: CGPointMake(2.83, 2.72)];
            [ShufflePath addCurveToPoint: CGPointMake(3.82, 3.58) controlPoint1: CGPointMake(2.83, 2.72) controlPoint2: CGPointMake(3.15, 3.58)];
            [ShufflePath addLineToPoint: CGPointMake(3.82, 3.58)];
            [ShufflePath closePath];
            [ShufflePath moveToPoint: CGPointMake(-10.5, 3.74)];
            [ShufflePath addLineToPoint: CGPointMake(-5.46, 3.74)];
            [ShufflePath addCurveToPoint: CGPointMake(-4.25, 2.92) controlPoint1: CGPointMake(-5.06, 3.74) controlPoint2: CGPointMake(-4.25, 2.92)];
            [ShufflePath addLineToPoint: CGPointMake(-3.64, 1.89)];
            [ShufflePath addLineToPoint: CGPointMake(-1.39, 4.84)];
            [ShufflePath addCurveToPoint: CGPointMake(-2.59, 6.63) controlPoint1: CGPointMake(-1.97, 5.77) controlPoint2: CGPointMake(-2.43, 6.47)];
            [ShufflePath addCurveToPoint: CGPointMake(-2.62, 6.66) controlPoint1: CGPointMake(-2.6, 6.64) controlPoint2: CGPointMake(-2.61, 6.66)];
            [ShufflePath addCurveToPoint: CGPointMake(-4.4, 7.74) controlPoint1: CGPointMake(-3.22, 7.25) controlPoint2: CGPointMake(-4.4, 7.74)];
            [ShufflePath addLineToPoint: CGPointMake(-10.4, 7.74)];
            [ShufflePath addLineToPoint: CGPointMake(-10.4, 3.74)];
            [ShufflePath addLineToPoint: CGPointMake(-10.5, 3.74)];
            [ShufflePath closePath];
            [ShufflePath applyTransform:move];
            ShufflePath.miterLimit = 4;
            
            ShufflePath.usesEvenOddFillRule = YES;
            
            [color setFill];
            [ShufflePath fill];
            
            

        }
            break;
            
        default:
            break;
    }
}


@end
