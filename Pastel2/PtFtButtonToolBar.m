//
//  VnViewEditorToolBarButton.m
//  Pastel
//
//  Created by SSC on 2014/05/10.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "PtFtButtonToolBar.h"

@implementation PtFtButtonToolBar

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

- (void)didTouchUpInside:(PtFtButtonToolBar *)sender
{
    [self.delegate didToolBarButtonTouchUpInside:self];
}


- (void)drawRect:(CGRect)rect
{
    //// Color Declarations
    UIColor* color = [UIColor colorWithWhite:1.0f alpha:0.80f];
    switch (_type) {
        case PtFtViewToolBarButtonTypeSlider:
        {
            
            //// Bezier Drawing
            UIBezierPath* bezierPath = [UIBezierPath bezierPath];
            [bezierPath moveToPoint: CGPointMake(18.5, 13.5)];
            [bezierPath addLineToPoint: CGPointMake(18.5, 17)];
            [bezierPath addLineToPoint: CGPointMake(17, 17)];
            [bezierPath addLineToPoint: CGPointMake(17, 23)];
            [bezierPath addLineToPoint: CGPointMake(18.5, 23)];
            [bezierPath addLineToPoint: CGPointMake(18.5, 31.5)];
            [bezierPath addLineToPoint: CGPointMake(21.5, 31.5)];
            [bezierPath addLineToPoint: CGPointMake(21.5, 23)];
            [bezierPath addLineToPoint: CGPointMake(23, 23)];
            [bezierPath addLineToPoint: CGPointMake(23, 17)];
            [bezierPath addLineToPoint: CGPointMake(21.5, 17)];
            [bezierPath addLineToPoint: CGPointMake(21.5, 13.5)];
            [bezierPath addLineToPoint: CGPointMake(18.5, 13.5)];
            [bezierPath closePath];
            [bezierPath moveToPoint: CGPointMake(18.5, 18.5)];
            [bezierPath addLineToPoint: CGPointMake(21.5, 18.5)];
            [bezierPath addLineToPoint: CGPointMake(21.5, 21.5)];
            [bezierPath addLineToPoint: CGPointMake(18.5, 21.5)];
            [bezierPath addLineToPoint: CGPointMake(18.5, 18.5)];
            [bezierPath closePath];
            bezierPath.miterLimit = 4;
            
            bezierPath.usesEvenOddFillRule = YES;
            
            [color setFill];
            [bezierPath fill];
            
            
            //// Bezier 2 Drawing
            UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
            [bezier2Path moveToPoint: CGPointMake(26, 13.5)];
            [bezier2Path addLineToPoint: CGPointMake(26, 23)];
            [bezier2Path addLineToPoint: CGPointMake(24.5, 23)];
            [bezier2Path addLineToPoint: CGPointMake(24.5, 29)];
            [bezier2Path addLineToPoint: CGPointMake(26, 29)];
            [bezier2Path addLineToPoint: CGPointMake(26, 31.5)];
            [bezier2Path addLineToPoint: CGPointMake(29, 31.5)];
            [bezier2Path addLineToPoint: CGPointMake(29, 29)];
            [bezier2Path addLineToPoint: CGPointMake(30.5, 29)];
            [bezier2Path addLineToPoint: CGPointMake(30.5, 23)];
            [bezier2Path addLineToPoint: CGPointMake(29, 23)];
            [bezier2Path addLineToPoint: CGPointMake(29, 13.5)];
            [bezier2Path addLineToPoint: CGPointMake(26, 13.5)];
            [bezier2Path closePath];
            [bezier2Path moveToPoint: CGPointMake(26, 24.5)];
            [bezier2Path addLineToPoint: CGPointMake(29, 24.5)];
            [bezier2Path addLineToPoint: CGPointMake(29, 27.5)];
            [bezier2Path addLineToPoint: CGPointMake(26, 27.5)];
            [bezier2Path addLineToPoint: CGPointMake(26, 24.5)];
            [bezier2Path closePath];
            bezier2Path.miterLimit = 4;
            
            bezier2Path.usesEvenOddFillRule = YES;
            
            [color setFill];
            [bezier2Path fill];
            
            
            //// Bezier 3 Drawing
            UIBezierPath* bezier3Path = [UIBezierPath bezierPath];
            [bezier3Path moveToPoint: CGPointMake(33.5, 13.5)];
            [bezier3Path addLineToPoint: CGPointMake(33.5, 20)];
            [bezier3Path addLineToPoint: CGPointMake(32, 20)];
            [bezier3Path addLineToPoint: CGPointMake(32, 26)];
            [bezier3Path addLineToPoint: CGPointMake(33.5, 26)];
            [bezier3Path addLineToPoint: CGPointMake(33.5, 31.5)];
            [bezier3Path addLineToPoint: CGPointMake(36.5, 31.5)];
            [bezier3Path addLineToPoint: CGPointMake(36.5, 26)];
            [bezier3Path addLineToPoint: CGPointMake(38, 26)];
            [bezier3Path addLineToPoint: CGPointMake(38, 20)];
            [bezier3Path addLineToPoint: CGPointMake(36.5, 20)];
            [bezier3Path addLineToPoint: CGPointMake(36.5, 13.5)];
            [bezier3Path addLineToPoint: CGPointMake(33.5, 13.5)];
            [bezier3Path closePath];
            [bezier3Path moveToPoint: CGPointMake(33.5, 21.5)];
            [bezier3Path addLineToPoint: CGPointMake(36.5, 21.5)];
            [bezier3Path addLineToPoint: CGPointMake(36.5, 24.5)];
            [bezier3Path addLineToPoint: CGPointMake(33.5, 24.5)];
            [bezier3Path addLineToPoint: CGPointMake(33.5, 21.5)];
            [bezier3Path closePath];
            bezier3Path.miterLimit = 4;
            
            bezier3Path.usesEvenOddFillRule = YES;
            
            [color setFill];
            [bezier3Path fill];
            

        }
            break;
        case PtFtViewToolBarButtonTypeShuffle:
        {            
            //// Bezier 4 Drawing
            UIBezierPath* bezier4Path = [UIBezierPath bezierPath];
            [bezier4Path moveToPoint: CGPointMake(33, 21.5)];
            [bezier4Path addCurveToPoint: CGPointMake(32.5, 21.5) controlPoint1: CGPointMake(32.39, 22.03) controlPoint2: CGPointMake(32.5, 21.5)];
            [bezier4Path addLineToPoint: CGPointMake(32.5, 19)];
            [bezier4Path addLineToPoint: CGPointMake(31.22, 19.16)];
            [bezier4Path addCurveToPoint: CGPointMake(30.23, 20.02) controlPoint1: CGPointMake(30.55, 19.16) controlPoint2: CGPointMake(30.23, 20.02)];
            [bezier4Path addCurveToPoint: CGPointMake(29.88, 20.62) controlPoint1: CGPointMake(30.23, 20.02) controlPoint2: CGPointMake(30.09, 20.25)];
            [bezier4Path addLineToPoint: CGPointMake(27.65, 17.58)];
            [bezier4Path addLineToPoint: CGPointMake(28.29, 16.49)];
            [bezier4Path addCurveToPoint: CGPointMake(30.5, 15) controlPoint1: CGPointMake(28.76, 15.56) controlPoint2: CGPointMake(30.5, 15)];
            [bezier4Path addLineToPoint: CGPointMake(32.5, 15)];
            [bezier4Path addLineToPoint: CGPointMake(32.5, 12.5)];
            [bezier4Path addCurveToPoint: CGPointMake(33, 12.5) controlPoint1: CGPointMake(32.5, 11.97) controlPoint2: CGPointMake(33, 12.5)];
            [bezier4Path addLineToPoint: CGPointMake(38, 17)];
            [bezier4Path addLineToPoint: CGPointMake(33, 21.5)];
            [bezier4Path closePath];
            [bezier4Path moveToPoint: CGPointMake(31.22, 25.84)];
            [bezier4Path addLineToPoint: CGPointMake(32.5, 26)];
            [bezier4Path addLineToPoint: CGPointMake(32.5, 23.5)];
            [bezier4Path addCurveToPoint: CGPointMake(33.17, 23.31) controlPoint1: CGPointMake(32.5, 23.5) controlPoint2: CGPointMake(32.56, 22.78)];
            [bezier4Path addLineToPoint: CGPointMake(38, 28)];
            [bezier4Path addLineToPoint: CGPointMake(33, 32.5)];
            [bezier4Path addCurveToPoint: CGPointMake(32.5, 32.5) controlPoint1: CGPointMake(33, 32.5) controlPoint2: CGPointMake(32.5, 33.03)];
            [bezier4Path addLineToPoint: CGPointMake(32.5, 30)];
            [bezier4Path addLineToPoint: CGPointMake(31, 30)];
            [bezier4Path addCurveToPoint: CGPointMake(28.29, 28.51) controlPoint1: CGPointMake(31, 30) controlPoint2: CGPointMake(28.76, 29.44)];
            [bezier4Path addLineToPoint: CGPointMake(23.15, 19.82)];
            [bezier4Path addCurveToPoint: CGPointMake(21.94, 19) controlPoint1: CGPointMake(23.15, 19.82) controlPoint2: CGPointMake(22.34, 19)];
            [bezier4Path addLineToPoint: CGPointMake(17, 19)];
            [bezier4Path addLineToPoint: CGPointMake(17, 15)];
            [bezier4Path addLineToPoint: CGPointMake(23, 15)];
            [bezier4Path addCurveToPoint: CGPointMake(24.78, 16.07) controlPoint1: CGPointMake(23, 15) controlPoint2: CGPointMake(24.18, 15.49)];
            [bezier4Path addCurveToPoint: CGPointMake(24.81, 16.1) controlPoint1: CGPointMake(24.79, 16.08) controlPoint2: CGPointMake(24.8, 16.09)];
            [bezier4Path addCurveToPoint: CGPointMake(30.23, 24.98) controlPoint1: CGPointMake(25.41, 16.71) controlPoint2: CGPointMake(30.23, 24.98)];
            [bezier4Path addCurveToPoint: CGPointMake(31.22, 25.84) controlPoint1: CGPointMake(30.23, 24.98) controlPoint2: CGPointMake(30.55, 25.84)];
            [bezier4Path addLineToPoint: CGPointMake(31.22, 25.84)];
            [bezier4Path closePath];
            [bezier4Path moveToPoint: CGPointMake(16.9, 26)];
            [bezier4Path addLineToPoint: CGPointMake(21.94, 26)];
            [bezier4Path addCurveToPoint: CGPointMake(23.15, 25.18) controlPoint1: CGPointMake(22.34, 26) controlPoint2: CGPointMake(23.15, 25.18)];
            [bezier4Path addLineToPoint: CGPointMake(23.76, 24.15)];
            [bezier4Path addLineToPoint: CGPointMake(26.01, 27.1)];
            [bezier4Path addCurveToPoint: CGPointMake(24.81, 28.89) controlPoint1: CGPointMake(25.43, 28.04) controlPoint2: CGPointMake(24.97, 28.74)];
            [bezier4Path addCurveToPoint: CGPointMake(24.78, 28.93) controlPoint1: CGPointMake(24.8, 28.91) controlPoint2: CGPointMake(24.79, 28.92)];
            [bezier4Path addCurveToPoint: CGPointMake(23, 30) controlPoint1: CGPointMake(24.18, 29.51) controlPoint2: CGPointMake(23, 30)];
            [bezier4Path addLineToPoint: CGPointMake(17, 30)];
            [bezier4Path addLineToPoint: CGPointMake(17, 26)];
            [bezier4Path addLineToPoint: CGPointMake(16.9, 26)];
            [bezier4Path closePath];
            bezier4Path.miterLimit = 4;
            
            bezier4Path.usesEvenOddFillRule = YES;
            
            [color setFill];
            [bezier4Path fill];
        }
            break;
        
        default:
            break;
    }
}


@end
