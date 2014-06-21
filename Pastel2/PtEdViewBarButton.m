//
//  PtViewBarButton.m
//  Pastel2
//
//  Created by SSC on 2014/05/30.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "PtEdViewBarButton.h"

@implementation PtEdViewBarButton

- (id)initWithType:(PtEdViewBarButtonType)type
{
    float length = [PtEdConfig topBarHeight];
    CGRect frame = CGRectMake(0.0f, 0.0f, length, length);
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _type = type;
    }
    return self;
}

- (void)setActive:(BOOL)active
{
    _active = active;
    if (active) {
        self.backgroundColor = [PtEdConfig toolBarColor];
    }else{
        self.backgroundColor = [UIColor clearColor];
    }
}

- (void)drawRect:(CGRect)rect
{
    
    CGAffineTransform move = CGAffineTransformMakeTranslation(rect.size.width / 2.0f, rect.size.height / 2.0f);
    
    UIColor* color = [UIColor colorWithWhite:0.95f alpha:1.0f];
    switch (_type) {
        case PtEdViewBarButtonTypeOther:
        {
            
            //// Other Drawing
            UIBezierPath* otherPath = [UIBezierPath bezierPath];
            [otherPath moveToPoint: CGPointMake(10, 0)];
            [otherPath addLineToPoint: CGPointMake(7.12, -2.88)];
            [otherPath addLineToPoint: CGPointMake(0.73, 3.51)];
            [otherPath addLineToPoint: CGPointMake(-3.51, -0.73)];
            [otherPath addLineToPoint: CGPointMake(2.88, -7.12)];
            [otherPath addLineToPoint: CGPointMake(0, -10)];
            [otherPath addLineToPoint: CGPointMake(10, -10)];
            [otherPath addLineToPoint: CGPointMake(10, 0)];
            [otherPath closePath];
            [otherPath moveToPoint: CGPointMake(-1, -7)];
            [otherPath addLineToPoint: CGPointMake(-7, -7)];
            [otherPath addLineToPoint: CGPointMake(-7, 7)];
            [otherPath addLineToPoint: CGPointMake(7, 7)];
            [otherPath addLineToPoint: CGPointMake(7, 1)];
            [otherPath addLineToPoint: CGPointMake(10, 4)];
            [otherPath addLineToPoint: CGPointMake(10, 10)];
            [otherPath addLineToPoint: CGPointMake(-10, 10)];
            [otherPath addLineToPoint: CGPointMake(-10, -7)];
            [otherPath addLineToPoint: CGPointMake(-10, -10)];
            [otherPath addLineToPoint: CGPointMake(-4, -10)];
            [otherPath addLineToPoint: CGPointMake(-1, -7)];
            [otherPath closePath];
            [otherPath applyTransform:move];
            [color setFill];
            [otherPath fill];
            

        }
            break;
        case PtEdViewBarButtonTypeFilters:
        {
            
            //// Filters Drawing
            UIBezierPath* filtersPath = [UIBezierPath bezierPath];
            [filtersPath moveToPoint: CGPointMake(-5.66, -5.66)];
            [filtersPath addCurveToPoint: CGPointMake(-5.66, 5.66) controlPoint1: CGPointMake(-8.78, -2.53) controlPoint2: CGPointMake(-8.78, 2.53)];
            [filtersPath addCurveToPoint: CGPointMake(5.66, 5.66) controlPoint1: CGPointMake(-2.53, 8.78) controlPoint2: CGPointMake(2.53, 8.78)];
            [filtersPath addCurveToPoint: CGPointMake(5.66, -5.66) controlPoint1: CGPointMake(8.78, 2.53) controlPoint2: CGPointMake(8.78, -2.53)];
            [filtersPath addCurveToPoint: CGPointMake(-5.66, -5.66) controlPoint1: CGPointMake(2.53, -8.78) controlPoint2: CGPointMake(-2.53, -8.78)];
            [filtersPath closePath];
            [filtersPath moveToPoint: CGPointMake(7.78, -7.78)];
            [filtersPath addCurveToPoint: CGPointMake(7.78, 7.78) controlPoint1: CGPointMake(12.07, -3.48) controlPoint2: CGPointMake(12.07, 3.48)];
            [filtersPath addCurveToPoint: CGPointMake(-7.78, 7.78) controlPoint1: CGPointMake(3.48, 12.07) controlPoint2: CGPointMake(-3.48, 12.07)];
            [filtersPath addCurveToPoint: CGPointMake(-7.78, -7.78) controlPoint1: CGPointMake(-12.07, 3.48) controlPoint2: CGPointMake(-12.07, -3.48)];
            [filtersPath addCurveToPoint: CGPointMake(7.78, -7.78) controlPoint1: CGPointMake(-3.48, -12.07) controlPoint2: CGPointMake(3.48, -12.07)];
            [filtersPath closePath];
            [filtersPath moveToPoint: CGPointMake(4.24, 4.24)];
            [filtersPath addCurveToPoint: CGPointMake(4.24, -4.24) controlPoint1: CGPointMake(6.59, 1.9) controlPoint2: CGPointMake(6.59, -1.9)];
            [filtersPath addCurveToPoint: CGPointMake(-4.24, -4.24) controlPoint1: CGPointMake(1.9, -6.59) controlPoint2: CGPointMake(-1.9, -6.59)];
            [filtersPath addCurveToPoint: CGPointMake(-4.24, 4.24) controlPoint1: CGPointMake(-6.59, -1.9) controlPoint2: CGPointMake(-6.59, 1.9)];
            [filtersPath addCurveToPoint: CGPointMake(4.24, 4.24) controlPoint1: CGPointMake(-1.9, 6.59) controlPoint2: CGPointMake(1.9, 6.59)];
            [filtersPath closePath];
            [filtersPath applyTransform:move];
            [color setFill];
            [filtersPath fill];
        }
            break;
        case PtEdViewBarButtonTypeSliders:
        {
            
            //// Bezier Drawing
            UIBezierPath* bezierPath = [UIBezierPath bezierPath];
            [bezierPath moveToPoint: CGPointMake(-2.09, -5.41)];
            [bezierPath addLineToPoint: CGPointMake(-2.06, -5.34)];
            [bezierPath addCurveToPoint: CGPointMake(-2, -5) controlPoint1: CGPointMake(-2.02, -5.21) controlPoint2: CGPointMake(-2, -5.11)];
            [bezierPath addLineToPoint: CGPointMake(-2, -3.5)];
            [bezierPath addLineToPoint: CGPointMake(-1, -3.5)];
            [bezierPath addCurveToPoint: CGPointMake(-0.25, -3.16) controlPoint1: CGPointMake(-0.7, -3.5) controlPoint2: CGPointMake(-0.44, -3.37)];
            [bezierPath addCurveToPoint: CGPointMake(0, -2.5) controlPoint1: CGPointMake(-0.1, -2.99) controlPoint2: CGPointMake(0, -2.76)];
            [bezierPath addLineToPoint: CGPointMake(0, -2)];
            [bezierPath addCurveToPoint: CGPointMake(-1, -1) controlPoint1: CGPointMake(0, -1.45) controlPoint2: CGPointMake(-0.45, -1)];
            [bezierPath addLineToPoint: CGPointMake(-2, -1)];
            [bezierPath addLineToPoint: CGPointMake(-2, 5)];
            [bezierPath addCurveToPoint: CGPointMake(-2.14, 5.51) controlPoint1: CGPointMake(-2, 5.19) controlPoint2: CGPointMake(-2.05, 5.36)];
            [bezierPath addCurveToPoint: CGPointMake(-3, 6) controlPoint1: CGPointMake(-2.32, 5.8) controlPoint2: CGPointMake(-2.63, 6)];
            [bezierPath addLineToPoint: CGPointMake(-3.5, 6)];
            [bezierPath addCurveToPoint: CGPointMake(-4.5, 5) controlPoint1: CGPointMake(-4.05, 6) controlPoint2: CGPointMake(-4.5, 5.55)];
            [bezierPath addLineToPoint: CGPointMake(-4.5, -1)];
            [bezierPath addLineToPoint: CGPointMake(-5.5, -1)];
            [bezierPath addCurveToPoint: CGPointMake(-6.5, -2) controlPoint1: CGPointMake(-6.05, -1) controlPoint2: CGPointMake(-6.5, -1.45)];
            [bezierPath addLineToPoint: CGPointMake(-6.5, -2.5)];
            [bezierPath addCurveToPoint: CGPointMake(-5.5, -3.5) controlPoint1: CGPointMake(-6.5, -3.05) controlPoint2: CGPointMake(-6.05, -3.5)];
            [bezierPath addLineToPoint: CGPointMake(-4.5, -3.5)];
            [bezierPath addLineToPoint: CGPointMake(-4.5, -5)];
            [bezierPath addCurveToPoint: CGPointMake(-3.5, -6) controlPoint1: CGPointMake(-4.5, -5.55) controlPoint2: CGPointMake(-4.05, -6)];
            [bezierPath addLineToPoint: CGPointMake(-3, -6)];
            [bezierPath addCurveToPoint: CGPointMake(-2.09, -5.41) controlPoint1: CGPointMake(-2.59, -6) controlPoint2: CGPointMake(-2.25, -5.76)];
            [bezierPath addLineToPoint: CGPointMake(-2.08, -5.39)];
            [bezierPath addLineToPoint: CGPointMake(-2.09, -5.41)];
            [bezierPath closePath];
            [bezierPath moveToPoint: CGPointMake(4.5, -5)];
            [bezierPath addLineToPoint: CGPointMake(4.5, 1)];
            [bezierPath addLineToPoint: CGPointMake(5.5, 1)];
            [bezierPath addCurveToPoint: CGPointMake(6.45, 1.69) controlPoint1: CGPointMake(5.95, 1) controlPoint2: CGPointMake(6.32, 1.29)];
            [bezierPath addCurveToPoint: CGPointMake(6.5, 2) controlPoint1: CGPointMake(6.48, 1.79) controlPoint2: CGPointMake(6.5, 1.89)];
            [bezierPath addLineToPoint: CGPointMake(6.5, 2.5)];
            [bezierPath addCurveToPoint: CGPointMake(5.5, 3.5) controlPoint1: CGPointMake(6.5, 3.05) controlPoint2: CGPointMake(6.05, 3.5)];
            [bezierPath addLineToPoint: CGPointMake(4.5, 3.5)];
            [bezierPath addLineToPoint: CGPointMake(4.5, 5)];
            [bezierPath addCurveToPoint: CGPointMake(3.5, 6) controlPoint1: CGPointMake(4.5, 5.55) controlPoint2: CGPointMake(4.05, 6)];
            [bezierPath addLineToPoint: CGPointMake(3, 6)];
            [bezierPath addCurveToPoint: CGPointMake(2, 5) controlPoint1: CGPointMake(2.45, 6) controlPoint2: CGPointMake(2, 5.55)];
            [bezierPath addLineToPoint: CGPointMake(2, 3.5)];
            [bezierPath addLineToPoint: CGPointMake(1, 3.5)];
            [bezierPath addCurveToPoint: CGPointMake(0, 2.5) controlPoint1: CGPointMake(0.45, 3.5) controlPoint2: CGPointMake(0, 3.05)];
            [bezierPath addLineToPoint: CGPointMake(0, 2)];
            [bezierPath addCurveToPoint: CGPointMake(1, 1) controlPoint1: CGPointMake(0, 1.45) controlPoint2: CGPointMake(0.45, 1)];
            [bezierPath addLineToPoint: CGPointMake(2, 1)];
            [bezierPath addLineToPoint: CGPointMake(2, -5)];
            [bezierPath addCurveToPoint: CGPointMake(3, -6) controlPoint1: CGPointMake(2, -5.55) controlPoint2: CGPointMake(2.45, -6)];
            [bezierPath addLineToPoint: CGPointMake(3.5, -6)];
            [bezierPath addCurveToPoint: CGPointMake(4.5, -5) controlPoint1: CGPointMake(4.05, -6) controlPoint2: CGPointMake(4.5, -5.55)];
            [bezierPath closePath];
            [bezierPath moveToPoint: CGPointMake(7.5, -8.5)];
            [bezierPath addLineToPoint: CGPointMake(-7.5, -8.5)];
            [bezierPath addCurveToPoint: CGPointMake(-8.5, -7.5) controlPoint1: CGPointMake(-8.05, -8.5) controlPoint2: CGPointMake(-8.5, -8.05)];
            [bezierPath addLineToPoint: CGPointMake(-8.5, 7.5)];
            [bezierPath addCurveToPoint: CGPointMake(-7.5, 8.5) controlPoint1: CGPointMake(-8.5, 8.05) controlPoint2: CGPointMake(-8.05, 8.5)];
            [bezierPath addLineToPoint: CGPointMake(7.5, 8.5)];
            [bezierPath addCurveToPoint: CGPointMake(8.5, 7.5) controlPoint1: CGPointMake(8.05, 8.5) controlPoint2: CGPointMake(8.5, 8.05)];
            [bezierPath addLineToPoint: CGPointMake(8.5, -7.5)];
            [bezierPath addCurveToPoint: CGPointMake(7.5, -8.5) controlPoint1: CGPointMake(8.5, -8.05) controlPoint2: CGPointMake(8.05, -8.5)];
            [bezierPath closePath];
            [bezierPath moveToPoint: CGPointMake(11, -9)];
            [bezierPath addLineToPoint: CGPointMake(11, 9)];
            [bezierPath addCurveToPoint: CGPointMake(9, 11) controlPoint1: CGPointMake(11, 10.1) controlPoint2: CGPointMake(10.1, 11)];
            [bezierPath addLineToPoint: CGPointMake(-9, 11)];
            [bezierPath addCurveToPoint: CGPointMake(-11, 9) controlPoint1: CGPointMake(-10.1, 11) controlPoint2: CGPointMake(-11, 10.1)];
            [bezierPath addLineToPoint: CGPointMake(-11, -9)];
            [bezierPath addCurveToPoint: CGPointMake(-9, -11) controlPoint1: CGPointMake(-11, -10.1) controlPoint2: CGPointMake(-10.1, -11)];
            [bezierPath addLineToPoint: CGPointMake(9, -11)];
            [bezierPath addCurveToPoint: CGPointMake(11, -9) controlPoint1: CGPointMake(10.1, -11) controlPoint2: CGPointMake(11, -10.1)];
            [bezierPath closePath];
            [bezierPath applyTransform:move];
            [color setFill];
            [bezierPath fill];

        }
            break;
        case PtEdViewBarButtonTypeTwitter:
        {
            //// Twitter Drawing
            UIBezierPath* twitterPath = [UIBezierPath bezierPath];
            [twitterPath moveToPoint: CGPointMake(9.14, -5.08)];
            [twitterPath addCurveToPoint: CGPointMake(9.16, -4.44) controlPoint1: CGPointMake(9.15, -4.87) controlPoint2: CGPointMake(9.16, -4.65)];
            [twitterPath addCurveToPoint: CGPointMake(-4.27, 9.75) controlPoint1: CGPointMake(9.16, 2.16) controlPoint2: CGPointMake(4.41, 9.75)];
            [twitterPath addCurveToPoint: CGPointMake(-11.5, 7.51) controlPoint1: CGPointMake(-6.93, 9.75) controlPoint2: CGPointMake(-9.41, 8.93)];
            [twitterPath addCurveToPoint: CGPointMake(-10.37, 7.58) controlPoint1: CGPointMake(-11.13, 7.56) controlPoint2: CGPointMake(-10.76, 7.58)];
            [twitterPath addCurveToPoint: CGPointMake(-4.51, 5.45) controlPoint1: CGPointMake(-8.16, 7.58) controlPoint2: CGPointMake(-6.13, 6.79)];
            [twitterPath addCurveToPoint: CGPointMake(-8.92, 1.98) controlPoint1: CGPointMake(-6.58, 5.41) controlPoint2: CGPointMake(-8.32, 3.97)];
            [twitterPath addCurveToPoint: CGPointMake(-8.03, 2.07) controlPoint1: CGPointMake(-8.63, 2.04) controlPoint2: CGPointMake(-8.34, 2.07)];
            [twitterPath addCurveToPoint: CGPointMake(-6.79, 1.9) controlPoint1: CGPointMake(-7.6, 2.07) controlPoint2: CGPointMake(-7.19, 2.01)];
            [twitterPath addCurveToPoint: CGPointMake(-10.58, -2.99) controlPoint1: CGPointMake(-8.95, 1.44) controlPoint2: CGPointMake(-10.58, -0.57)];
            [twitterPath addCurveToPoint: CGPointMake(-10.58, -3.05) controlPoint1: CGPointMake(-10.58, -3.01) controlPoint2: CGPointMake(-10.58, -3.03)];
            [twitterPath addCurveToPoint: CGPointMake(-8.44, -2.43) controlPoint1: CGPointMake(-9.94, -2.68) controlPoint2: CGPointMake(-9.21, -2.45)];
            [twitterPath addCurveToPoint: CGPointMake(-10.54, -6.58) controlPoint1: CGPointMake(-9.7, -3.32) controlPoint2: CGPointMake(-10.54, -4.85)];
            [twitterPath addCurveToPoint: CGPointMake(-9.9, -9.09) controlPoint1: CGPointMake(-10.54, -7.49) controlPoint2: CGPointMake(-10.3, -8.35)];
            [twitterPath addCurveToPoint: CGPointMake(-0.17, -3.88) controlPoint1: CGPointMake(-7.57, -6.07) controlPoint2: CGPointMake(-4.09, -4.09)];
            [twitterPath addCurveToPoint: CGPointMake(-0.29, -5.01) controlPoint1: CGPointMake(-0.25, -4.24) controlPoint2: CGPointMake(-0.29, -4.62)];
            [twitterPath addCurveToPoint: CGPointMake(4.43, -10) controlPoint1: CGPointMake(-0.29, -7.77) controlPoint2: CGPointMake(1.82, -10)];
            [twitterPath addCurveToPoint: CGPointMake(7.87, -8.43) controlPoint1: CGPointMake(5.78, -10) controlPoint2: CGPointMake(7.01, -9.39)];
            [twitterPath addCurveToPoint: CGPointMake(10.87, -9.64) controlPoint1: CGPointMake(8.94, -8.65) controlPoint2: CGPointMake(9.95, -9.07)];
            [twitterPath addCurveToPoint: CGPointMake(8.79, -6.88) controlPoint1: CGPointMake(10.51, -8.47) controlPoint2: CGPointMake(9.76, -7.49)];
            [twitterPath addCurveToPoint: CGPointMake(11.5, -7.66) controlPoint1: CGPointMake(9.75, -7) controlPoint2: CGPointMake(10.66, -7.27)];
            [twitterPath addCurveToPoint: CGPointMake(9.14, -5.08) controlPoint1: CGPointMake(10.87, -6.66) controlPoint2: CGPointMake(10.07, -5.78)];
            [twitterPath closePath];
            [twitterPath applyTransform:move];
            twitterPath.miterLimit = 4;
            
            [color setFill];
            [twitterPath fill];
        }
            break;
        case PtEdViewBarButtonTypeFacebook:
        {
            
            //// Facebook Drawing
            UIBezierPath* facebookPath = [UIBezierPath bezierPath];
            [facebookPath moveToPoint: CGPointMake(7.5, -7)];
            [facebookPath addLineToPoint: CGPointMake(4.5, -7)];
            [facebookPath addCurveToPoint: CGPointMake(1.5, -4) controlPoint1: CGPointMake(2.84, -7) controlPoint2: CGPointMake(1.5, -5.66)];
            [facebookPath addLineToPoint: CGPointMake(1.5, -1.5)];
            [facebookPath addLineToPoint: CGPointMake(-1, -1.5)];
            [facebookPath addLineToPoint: CGPointMake(-1, 1.5)];
            [facebookPath addLineToPoint: CGPointMake(1.5, 1.5)];
            [facebookPath addLineToPoint: CGPointMake(1.5, 8.5)];
            [facebookPath addLineToPoint: CGPointMake(4.5, 8.5)];
            [facebookPath addLineToPoint: CGPointMake(4.5, 1.5)];
            [facebookPath addLineToPoint: CGPointMake(7.5, 1.5)];
            [facebookPath addLineToPoint: CGPointMake(7.5, -1.5)];
            [facebookPath addLineToPoint: CGPointMake(4.5, -1.5)];
            [facebookPath addLineToPoint: CGPointMake(4.5, -3)];
            [facebookPath addCurveToPoint: CGPointMake(5.5, -4) controlPoint1: CGPointMake(4.5, -3.55) controlPoint2: CGPointMake(4.95, -4)];
            [facebookPath addLineToPoint: CGPointMake(7.5, -4)];
            [facebookPath addLineToPoint: CGPointMake(7.5, -7)];
            [facebookPath closePath];
            [facebookPath moveToPoint: CGPointMake(10, -8)];
            [facebookPath addLineToPoint: CGPointMake(10, 8)];
            [facebookPath addCurveToPoint: CGPointMake(8, 10) controlPoint1: CGPointMake(10, 9.1) controlPoint2: CGPointMake(9.1, 10)];
            [facebookPath addLineToPoint: CGPointMake(-8, 10)];
            [facebookPath addCurveToPoint: CGPointMake(-10, 8) controlPoint1: CGPointMake(-9.1, 10) controlPoint2: CGPointMake(-10, 9.1)];
            [facebookPath addLineToPoint: CGPointMake(-10, -8)];
            [facebookPath addCurveToPoint: CGPointMake(-8, -10) controlPoint1: CGPointMake(-10, -9.1) controlPoint2: CGPointMake(-9.1, -10)];
            [facebookPath addLineToPoint: CGPointMake(8, -10)];
            [facebookPath addCurveToPoint: CGPointMake(10, -8) controlPoint1: CGPointMake(9.1, -10) controlPoint2: CGPointMake(10, -9.1)];
            [facebookPath closePath];
            [facebookPath applyTransform:move];
            [color setFill];
            [facebookPath fill];


        }
            break;
        case PtEdViewBarButtonTypeInstagram:
        {
            
            //// Instagram Drawing
            UIBezierPath* instagramPath = [UIBezierPath bezierPath];
            [instagramPath moveToPoint: CGPointMake(7, -8.5)];
            [instagramPath addLineToPoint: CGPointMake(6, -8.5)];
            [instagramPath addCurveToPoint: CGPointMake(5, -7.5) controlPoint1: CGPointMake(5.45, -8.5) controlPoint2: CGPointMake(5, -8.05)];
            [instagramPath addLineToPoint: CGPointMake(5, -6.5)];
            [instagramPath addCurveToPoint: CGPointMake(6, -5.5) controlPoint1: CGPointMake(5, -5.95) controlPoint2: CGPointMake(5.45, -5.5)];
            [instagramPath addLineToPoint: CGPointMake(7, -5.5)];
            [instagramPath addCurveToPoint: CGPointMake(8, -6.5) controlPoint1: CGPointMake(7.55, -5.5) controlPoint2: CGPointMake(8, -5.95)];
            [instagramPath addLineToPoint: CGPointMake(8, -7.5)];
            [instagramPath addCurveToPoint: CGPointMake(7, -8.5) controlPoint1: CGPointMake(8, -8.05) controlPoint2: CGPointMake(7.55, -8.5)];
            [instagramPath closePath];
            [instagramPath moveToPoint: CGPointMake(-0.19, -4)];
            [instagramPath addCurveToPoint: CGPointMake(-2.83, -2.83) controlPoint1: CGPointMake(-1.14, -3.95) controlPoint2: CGPointMake(-2.09, -3.57)];
            [instagramPath addCurveToPoint: CGPointMake(-2.83, 2.83) controlPoint1: CGPointMake(-4.39, -1.27) controlPoint2: CGPointMake(-4.39, 1.27)];
            [instagramPath addCurveToPoint: CGPointMake(2.83, 2.83) controlPoint1: CGPointMake(-1.27, 4.39) controlPoint2: CGPointMake(1.27, 4.39)];
            [instagramPath addCurveToPoint: CGPointMake(2.83, -2.83) controlPoint1: CGPointMake(4.39, 1.27) controlPoint2: CGPointMake(4.39, -1.27)];
            [instagramPath addCurveToPoint: CGPointMake(-0.17, -4) controlPoint1: CGPointMake(2, -3.65) controlPoint2: CGPointMake(0.91, -4.04)];
            [instagramPath addLineToPoint: CGPointMake(-0.19, -4)];
            [instagramPath closePath];
            [instagramPath moveToPoint: CGPointMake(8, -4)];
            [instagramPath addLineToPoint: CGPointMake(4.47, -4)];
            [instagramPath addCurveToPoint: CGPointMake(4.24, 4.24) controlPoint1: CGPointMake(6.58, -1.64) controlPoint2: CGPointMake(6.51, 1.98)];
            [instagramPath addCurveToPoint: CGPointMake(-4.24, 4.24) controlPoint1: CGPointMake(1.9, 6.59) controlPoint2: CGPointMake(-1.9, 6.59)];
            [instagramPath addCurveToPoint: CGPointMake(-4.47, -4) controlPoint1: CGPointMake(-6.51, 1.98) controlPoint2: CGPointMake(-6.58, -1.64)];
            [instagramPath addLineToPoint: CGPointMake(-8, -4)];
            [instagramPath addLineToPoint: CGPointMake(-8, 7)];
            [instagramPath addCurveToPoint: CGPointMake(-7, 8) controlPoint1: CGPointMake(-8, 7.55) controlPoint2: CGPointMake(-7.55, 8)];
            [instagramPath addLineToPoint: CGPointMake(7, 8)];
            [instagramPath addCurveToPoint: CGPointMake(8, 7) controlPoint1: CGPointMake(7.55, 8) controlPoint2: CGPointMake(8, 7.55)];
            [instagramPath addLineToPoint: CGPointMake(8, -4)];
            [instagramPath closePath];
            [instagramPath moveToPoint: CGPointMake(10, -8)];
            [instagramPath addLineToPoint: CGPointMake(10, 8)];
            [instagramPath addCurveToPoint: CGPointMake(8, 10) controlPoint1: CGPointMake(10, 9.1) controlPoint2: CGPointMake(9.1, 10)];
            [instagramPath addLineToPoint: CGPointMake(-8, 10)];
            [instagramPath addCurveToPoint: CGPointMake(-10, 8) controlPoint1: CGPointMake(-9.1, 10) controlPoint2: CGPointMake(-10, 9.1)];
            [instagramPath addLineToPoint: CGPointMake(-10, -8)];
            [instagramPath addCurveToPoint: CGPointMake(-8, -10) controlPoint1: CGPointMake(-10, -9.1) controlPoint2: CGPointMake(-9.1, -10)];
            [instagramPath addLineToPoint: CGPointMake(8, -10)];
            [instagramPath addCurveToPoint: CGPointMake(10, -8) controlPoint1: CGPointMake(9.1, -10) controlPoint2: CGPointMake(10, -9.1)];
            [instagramPath closePath];
            [instagramPath applyTransform:move];
            [color setFill];
            [instagramPath fill];
        }
            break;
        case PtEdViewBarButtonTypeBackToCamera:
        {
            
            //// BackToCamera Drawing
            UIBezierPath* backToCameraPath = [UIBezierPath bezierPath];
            [backToCameraPath moveToPoint: CGPointMake(-3.89, -2.89)];
            [backToCameraPath addCurveToPoint: CGPointMake(-3.89, 4.89) controlPoint1: CGPointMake(-6.04, -0.74) controlPoint2: CGPointMake(-6.04, 2.74)];
            [backToCameraPath addCurveToPoint: CGPointMake(3.89, 4.89) controlPoint1: CGPointMake(-1.74, 7.04) controlPoint2: CGPointMake(1.74, 7.04)];
            [backToCameraPath addCurveToPoint: CGPointMake(3.89, -2.89) controlPoint1: CGPointMake(6.04, 2.74) controlPoint2: CGPointMake(6.04, -0.74)];
            [backToCameraPath addCurveToPoint: CGPointMake(-1.15, -4.38) controlPoint1: CGPointMake(2.52, -4.26) controlPoint2: CGPointMake(0.61, -4.75)];
            [backToCameraPath addCurveToPoint: CGPointMake(-3.89, -2.89) controlPoint1: CGPointMake(-2.15, -4.17) controlPoint2: CGPointMake(-3.11, -3.67)];
            [backToCameraPath closePath];
            [backToCameraPath moveToPoint: CGPointMake(6, -6)];
            [backToCameraPath addLineToPoint: CGPointMake(9, -6)];
            [backToCameraPath addCurveToPoint: CGPointMake(11, -4) controlPoint1: CGPointMake(10.1, -6) controlPoint2: CGPointMake(11, -5.1)];
            [backToCameraPath addLineToPoint: CGPointMake(11, 7)];
            [backToCameraPath addCurveToPoint: CGPointMake(9, 9) controlPoint1: CGPointMake(11, 8.1) controlPoint2: CGPointMake(10.1, 9)];
            [backToCameraPath addLineToPoint: CGPointMake(-9, 9)];
            [backToCameraPath addCurveToPoint: CGPointMake(-11, 7) controlPoint1: CGPointMake(-10.1, 9) controlPoint2: CGPointMake(-11, 8.1)];
            [backToCameraPath addLineToPoint: CGPointMake(-11, -4)];
            [backToCameraPath addCurveToPoint: CGPointMake(-9, -6) controlPoint1: CGPointMake(-11, -5.1) controlPoint2: CGPointMake(-10.1, -6)];
            [backToCameraPath addLineToPoint: CGPointMake(-6, -6)];
            [backToCameraPath addLineToPoint: CGPointMake(-4, -9)];
            [backToCameraPath addLineToPoint: CGPointMake(4, -9)];
            [backToCameraPath addLineToPoint: CGPointMake(6, -6)];
            [backToCameraPath closePath];
            [backToCameraPath moveToPoint: CGPointMake(2.47, 3.47)];
            [backToCameraPath addCurveToPoint: CGPointMake(2.47, -1.47) controlPoint1: CGPointMake(3.84, 2.11) controlPoint2: CGPointMake(3.84, -0.11)];
            [backToCameraPath addCurveToPoint: CGPointMake(-2.47, -1.47) controlPoint1: CGPointMake(1.11, -2.84) controlPoint2: CGPointMake(-1.11, -2.84)];
            [backToCameraPath addCurveToPoint: CGPointMake(-2.47, 3.47) controlPoint1: CGPointMake(-3.84, -0.11) controlPoint2: CGPointMake(-3.84, 2.11)];
            [backToCameraPath addCurveToPoint: CGPointMake(2.47, 3.47) controlPoint1: CGPointMake(-1.11, 4.84) controlPoint2: CGPointMake(1.11, 4.84)];
            [backToCameraPath closePath];
            [backToCameraPath applyTransform:move];
            [color setFill];
            [backToCameraPath fill];
            
            

        }
            break;
        case PtEdViewBarButtonTypeSaveToCameraRoll:
        {
            
            //// Cameraroll Drawing
            UIBezierPath* camerarollPath = [UIBezierPath bezierPath];
            [camerarollPath moveToPoint: CGPointMake(3, -3)];
            [camerarollPath addLineToPoint: CGPointMake(8, -3)];
            [camerarollPath addLineToPoint: CGPointMake(0, 5)];
            [camerarollPath addLineToPoint: CGPointMake(-8, -3)];
            [camerarollPath addLineToPoint: CGPointMake(-3, -3)];
            [camerarollPath addLineToPoint: CGPointMake(-3, -10)];
            [camerarollPath addLineToPoint: CGPointMake(3, -10)];
            [camerarollPath addLineToPoint: CGPointMake(3, -3)];
            [camerarollPath closePath];
            [camerarollPath moveToPoint: CGPointMake(10, 10)];
            [camerarollPath addLineToPoint: CGPointMake(-10, 10)];
            [camerarollPath addLineToPoint: CGPointMake(-10, 0)];
            [camerarollPath addLineToPoint: CGPointMake(-7, 3)];
            [camerarollPath addLineToPoint: CGPointMake(-7, 7)];
            [camerarollPath addLineToPoint: CGPointMake(7, 7)];
            [camerarollPath addLineToPoint: CGPointMake(7, 3)];
            [camerarollPath addLineToPoint: CGPointMake(10, 0)];
            [camerarollPath addLineToPoint: CGPointMake(10, 10)];
            [camerarollPath closePath];
            [camerarollPath applyTransform:move];
            [color setFill];
            [camerarollPath fill];

        }
            break;
        case PtEdViewBarButtonTypeFilm:
        {
            
            //// Film Drawing
            UIBezierPath* filmPath = [UIBezierPath bezierPath];
            [filmPath moveToPoint: CGPointMake(10, 10)];
            [filmPath addLineToPoint: CGPointMake(8.5, 10)];
            [filmPath addLineToPoint: CGPointMake(8.5, 9)];
            [filmPath addLineToPoint: CGPointMake(6.5, 9)];
            [filmPath addLineToPoint: CGPointMake(6.5, 10)];
            [filmPath addLineToPoint: CGPointMake(5, 10)];
            [filmPath addLineToPoint: CGPointMake(5, 6.5)];
            [filmPath addLineToPoint: CGPointMake(-5, 6.5)];
            [filmPath addLineToPoint: CGPointMake(-5, 10)];
            [filmPath addLineToPoint: CGPointMake(-6.5, 10)];
            [filmPath addLineToPoint: CGPointMake(-6.5, 9)];
            [filmPath addLineToPoint: CGPointMake(-8.5, 9)];
            [filmPath addLineToPoint: CGPointMake(-8.5, 10)];
            [filmPath addLineToPoint: CGPointMake(-10, 10)];
            [filmPath addLineToPoint: CGPointMake(-10, -10)];
            [filmPath addLineToPoint: CGPointMake(-8.5, -10)];
            [filmPath addLineToPoint: CGPointMake(-8.5, -9)];
            [filmPath addLineToPoint: CGPointMake(-6.5, -9)];
            [filmPath addLineToPoint: CGPointMake(-6.5, -10)];
            [filmPath addLineToPoint: CGPointMake(-5, -10)];
            [filmPath addLineToPoint: CGPointMake(-5, -6.5)];
            [filmPath addLineToPoint: CGPointMake(5, -6.5)];
            [filmPath addLineToPoint: CGPointMake(5, -10)];
            [filmPath addLineToPoint: CGPointMake(6.5, -10)];
            [filmPath addLineToPoint: CGPointMake(6.5, -9)];
            [filmPath addLineToPoint: CGPointMake(8.5, -9)];
            [filmPath addLineToPoint: CGPointMake(8.5, -10)];
            [filmPath addLineToPoint: CGPointMake(10, -10)];
            [filmPath addLineToPoint: CGPointMake(10, 10)];
            [filmPath closePath];
            [filmPath moveToPoint: CGPointMake(8.5, -7)];
            [filmPath addLineToPoint: CGPointMake(6.5, -7)];
            [filmPath addLineToPoint: CGPointMake(6.5, -5)];
            [filmPath addLineToPoint: CGPointMake(8.5, -5)];
            [filmPath addLineToPoint: CGPointMake(8.5, -7)];
            [filmPath closePath];
            [filmPath moveToPoint: CGPointMake(-6.5, -7)];
            [filmPath addLineToPoint: CGPointMake(-8.5, -7)];
            [filmPath addLineToPoint: CGPointMake(-8.5, -5)];
            [filmPath addLineToPoint: CGPointMake(-6.5, -5)];
            [filmPath addLineToPoint: CGPointMake(-6.5, -7)];
            [filmPath closePath];
            [filmPath moveToPoint: CGPointMake(8.5, -3)];
            [filmPath addLineToPoint: CGPointMake(6.5, -3)];
            [filmPath addLineToPoint: CGPointMake(6.5, -1)];
            [filmPath addLineToPoint: CGPointMake(8.5, -1)];
            [filmPath addLineToPoint: CGPointMake(8.5, -3)];
            [filmPath closePath];
            [filmPath moveToPoint: CGPointMake(-6.5, -3)];
            [filmPath addLineToPoint: CGPointMake(-8.5, -3)];
            [filmPath addLineToPoint: CGPointMake(-8.5, -1)];
            [filmPath addLineToPoint: CGPointMake(-6.5, -1)];
            [filmPath addLineToPoint: CGPointMake(-6.5, -3)];
            [filmPath closePath];
            [filmPath moveToPoint: CGPointMake(8.5, 1)];
            [filmPath addLineToPoint: CGPointMake(6.5, 1)];
            [filmPath addLineToPoint: CGPointMake(6.5, 3)];
            [filmPath addLineToPoint: CGPointMake(8.5, 3)];
            [filmPath addLineToPoint: CGPointMake(8.5, 1)];
            [filmPath closePath];
            [filmPath moveToPoint: CGPointMake(-6.5, 1)];
            [filmPath addLineToPoint: CGPointMake(-8.5, 1)];
            [filmPath addLineToPoint: CGPointMake(-8.5, 3)];
            [filmPath addLineToPoint: CGPointMake(-6.5, 3)];
            [filmPath addLineToPoint: CGPointMake(-6.5, 1)];
            [filmPath closePath];
            [filmPath moveToPoint: CGPointMake(5, -4.5)];
            [filmPath addLineToPoint: CGPointMake(-5, -4.5)];
            [filmPath addLineToPoint: CGPointMake(-5, 4.5)];
            [filmPath addLineToPoint: CGPointMake(5, 4.5)];
            [filmPath addLineToPoint: CGPointMake(5, -4.5)];
            [filmPath closePath];
            [filmPath moveToPoint: CGPointMake(8.5, 5)];
            [filmPath addLineToPoint: CGPointMake(6.5, 5)];
            [filmPath addLineToPoint: CGPointMake(6.5, 7)];
            [filmPath addLineToPoint: CGPointMake(8.5, 7)];
            [filmPath addLineToPoint: CGPointMake(8.5, 5)];
            [filmPath closePath];
            [filmPath moveToPoint: CGPointMake(-6.5, 5)];
            [filmPath addLineToPoint: CGPointMake(-8.5, 5)];
            [filmPath addLineToPoint: CGPointMake(-8.5, 7)];
            [filmPath addLineToPoint: CGPointMake(-6.5, 7)];
            [filmPath addLineToPoint: CGPointMake(-6.5, 5)];
            [filmPath closePath];
            [filmPath applyTransform:move];
            [color setFill];
            [filmPath fill];


        }
            break;
        case PtEdViewBarButtonTypeBrightness:
        {
            
            //// Brightness Drawing
            UIBezierPath* brightnessPath = [UIBezierPath bezierPath];
            [brightnessPath moveToPoint: CGPointMake(3.89, 3.89)];
            [brightnessPath addCurveToPoint: CGPointMake(3.89, -3.89) controlPoint1: CGPointMake(6.04, 1.74) controlPoint2: CGPointMake(6.04, -1.74)];
            [brightnessPath addCurveToPoint: CGPointMake(-3.89, -3.89) controlPoint1: CGPointMake(1.74, -6.04) controlPoint2: CGPointMake(-1.74, -6.04)];
            [brightnessPath addCurveToPoint: CGPointMake(-3.89, 3.89) controlPoint1: CGPointMake(-6.04, -1.74) controlPoint2: CGPointMake(-6.04, 1.74)];
            [brightnessPath addCurveToPoint: CGPointMake(3.89, 3.89) controlPoint1: CGPointMake(-1.74, 6.04) controlPoint2: CGPointMake(1.74, 6.04)];
            [brightnessPath closePath];
            [brightnessPath moveToPoint: CGPointMake(-1.5, -9.5)];
            [brightnessPath addCurveToPoint: CGPointMake(-0, -8) controlPoint1: CGPointMake(-1.5, -8.67) controlPoint2: CGPointMake(-0.83, -8)];
            [brightnessPath addCurveToPoint: CGPointMake(0.73, -8.19) controlPoint1: CGPointMake(0.27, -8) controlPoint2: CGPointMake(0.52, -8.07)];
            [brightnessPath addCurveToPoint: CGPointMake(1.47, -9.21) controlPoint1: CGPointMake(1.11, -8.4) controlPoint2: CGPointMake(1.39, -8.77)];
            [brightnessPath addCurveToPoint: CGPointMake(1.5, -9.5) controlPoint1: CGPointMake(1.49, -9.3) controlPoint2: CGPointMake(1.5, -9.4)];
            [brightnessPath addLineToPoint: CGPointMake(1.5, -10.5)];
            [brightnessPath addCurveToPoint: CGPointMake(-0, -12) controlPoint1: CGPointMake(1.5, -11.33) controlPoint2: CGPointMake(0.83, -12)];
            [brightnessPath addCurveToPoint: CGPointMake(-1.5, -10.5) controlPoint1: CGPointMake(-0.83, -12) controlPoint2: CGPointMake(-1.5, -11.33)];
            [brightnessPath addLineToPoint: CGPointMake(-1.5, -9.5)];
            [brightnessPath closePath];
            [brightnessPath moveToPoint: CGPointMake(-1.5, 10.5)];
            [brightnessPath addCurveToPoint: CGPointMake(-0, 12) controlPoint1: CGPointMake(-1.5, 11.33) controlPoint2: CGPointMake(-0.83, 12)];
            [brightnessPath addCurveToPoint: CGPointMake(1.5, 10.5) controlPoint1: CGPointMake(0.83, 12) controlPoint2: CGPointMake(1.5, 11.33)];
            [brightnessPath addLineToPoint: CGPointMake(1.5, 9.5)];
            [brightnessPath addCurveToPoint: CGPointMake(-0, 8) controlPoint1: CGPointMake(1.5, 8.67) controlPoint2: CGPointMake(0.83, 8)];
            [brightnessPath addCurveToPoint: CGPointMake(-1.5, 9.5) controlPoint1: CGPointMake(-0.83, 8) controlPoint2: CGPointMake(-1.5, 8.67)];
            [brightnessPath addLineToPoint: CGPointMake(-1.5, 10.5)];
            [brightnessPath closePath];
            [brightnessPath moveToPoint: CGPointMake(9.5, -1.5)];
            [brightnessPath addCurveToPoint: CGPointMake(8, 0) controlPoint1: CGPointMake(8.67, -1.5) controlPoint2: CGPointMake(8, -0.83)];
            [brightnessPath addCurveToPoint: CGPointMake(9.21, 1.47) controlPoint1: CGPointMake(8, 0.73) controlPoint2: CGPointMake(8.52, 1.34)];
            [brightnessPath addCurveToPoint: CGPointMake(9.5, 1.5) controlPoint1: CGPointMake(9.3, 1.49) controlPoint2: CGPointMake(9.4, 1.5)];
            [brightnessPath addLineToPoint: CGPointMake(10.5, 1.5)];
            [brightnessPath addCurveToPoint: CGPointMake(12, 0) controlPoint1: CGPointMake(11.33, 1.5) controlPoint2: CGPointMake(12, 0.83)];
            [brightnessPath addCurveToPoint: CGPointMake(10.5, -1.5) controlPoint1: CGPointMake(12, -0.83) controlPoint2: CGPointMake(11.33, -1.5)];
            [brightnessPath addLineToPoint: CGPointMake(9.5, -1.5)];
            [brightnessPath closePath];
            [brightnessPath moveToPoint: CGPointMake(-10.5, -1.5)];
            [brightnessPath addCurveToPoint: CGPointMake(-12, 0) controlPoint1: CGPointMake(-11.33, -1.5) controlPoint2: CGPointMake(-12, -0.83)];
            [brightnessPath addCurveToPoint: CGPointMake(-10.5, 1.5) controlPoint1: CGPointMake(-12, 0.83) controlPoint2: CGPointMake(-11.33, 1.5)];
            [brightnessPath addLineToPoint: CGPointMake(-9.5, 1.5)];
            [brightnessPath addCurveToPoint: CGPointMake(-8, 0) controlPoint1: CGPointMake(-8.67, 1.5) controlPoint2: CGPointMake(-8, 0.83)];
            [brightnessPath addCurveToPoint: CGPointMake(-9.5, -1.5) controlPoint1: CGPointMake(-8, -0.83) controlPoint2: CGPointMake(-8.67, -1.5)];
            [brightnessPath addLineToPoint: CGPointMake(-10.5, -1.5)];
            [brightnessPath closePath];
            [brightnessPath moveToPoint: CGPointMake(5.66, -7.78)];
            [brightnessPath addCurveToPoint: CGPointMake(5.66, -5.66) controlPoint1: CGPointMake(5.07, -7.19) controlPoint2: CGPointMake(5.07, -6.24)];
            [brightnessPath addCurveToPoint: CGPointMake(6.31, -5.27) controlPoint1: CGPointMake(5.85, -5.47) controlPoint2: CGPointMake(6.07, -5.34)];
            [brightnessPath addCurveToPoint: CGPointMake(7.55, -5.47) controlPoint1: CGPointMake(6.73, -5.16) controlPoint2: CGPointMake(7.18, -5.22)];
            [brightnessPath addCurveToPoint: CGPointMake(7.78, -5.66) controlPoint1: CGPointMake(7.63, -5.52) controlPoint2: CGPointMake(7.71, -5.59)];
            [brightnessPath addLineToPoint: CGPointMake(8.49, -6.36)];
            [brightnessPath addCurveToPoint: CGPointMake(8.49, -8.49) controlPoint1: CGPointMake(9.07, -6.95) controlPoint2: CGPointMake(9.07, -7.9)];
            [brightnessPath addCurveToPoint: CGPointMake(6.36, -8.49) controlPoint1: CGPointMake(7.9, -9.07) controlPoint2: CGPointMake(6.95, -9.07)];
            [brightnessPath addLineToPoint: CGPointMake(5.66, -7.78)];
            [brightnessPath closePath];
            [brightnessPath moveToPoint: CGPointMake(-8.49, 6.36)];
            [brightnessPath addCurveToPoint: CGPointMake(-8.49, 8.49) controlPoint1: CGPointMake(-9.07, 6.95) controlPoint2: CGPointMake(-9.07, 7.9)];
            [brightnessPath addCurveToPoint: CGPointMake(-6.36, 8.49) controlPoint1: CGPointMake(-7.9, 9.07) controlPoint2: CGPointMake(-6.95, 9.07)];
            [brightnessPath addLineToPoint: CGPointMake(-5.66, 7.78)];
            [brightnessPath addCurveToPoint: CGPointMake(-5.66, 5.66) controlPoint1: CGPointMake(-5.07, 7.19) controlPoint2: CGPointMake(-5.07, 6.24)];
            [brightnessPath addCurveToPoint: CGPointMake(-7.78, 5.66) controlPoint1: CGPointMake(-6.24, 5.07) controlPoint2: CGPointMake(-7.19, 5.07)];
            [brightnessPath addLineToPoint: CGPointMake(-8.49, 6.36)];
            [brightnessPath closePath];
            [brightnessPath moveToPoint: CGPointMake(7.78, 5.66)];
            [brightnessPath addCurveToPoint: CGPointMake(5.66, 5.66) controlPoint1: CGPointMake(7.19, 5.07) controlPoint2: CGPointMake(6.24, 5.07)];
            [brightnessPath addCurveToPoint: CGPointMake(5.47, 7.55) controlPoint1: CGPointMake(5.14, 6.17) controlPoint2: CGPointMake(5.08, 6.97)];
            [brightnessPath addCurveToPoint: CGPointMake(5.66, 7.78) controlPoint1: CGPointMake(5.52, 7.63) controlPoint2: CGPointMake(5.59, 7.71)];
            [brightnessPath addLineToPoint: CGPointMake(6.36, 8.49)];
            [brightnessPath addCurveToPoint: CGPointMake(8.49, 8.49) controlPoint1: CGPointMake(6.95, 9.07) controlPoint2: CGPointMake(7.9, 9.07)];
            [brightnessPath addCurveToPoint: CGPointMake(8.49, 6.36) controlPoint1: CGPointMake(9.07, 7.9) controlPoint2: CGPointMake(9.07, 6.95)];
            [brightnessPath addLineToPoint: CGPointMake(7.78, 5.66)];
            [brightnessPath closePath];
            [brightnessPath moveToPoint: CGPointMake(-6.36, -8.49)];
            [brightnessPath addCurveToPoint: CGPointMake(-8.49, -8.49) controlPoint1: CGPointMake(-6.95, -9.07) controlPoint2: CGPointMake(-7.9, -9.07)];
            [brightnessPath addCurveToPoint: CGPointMake(-8.49, -6.36) controlPoint1: CGPointMake(-9.07, -7.9) controlPoint2: CGPointMake(-9.07, -6.95)];
            [brightnessPath addLineToPoint: CGPointMake(-7.78, -5.66)];
            [brightnessPath addCurveToPoint: CGPointMake(-5.66, -5.66) controlPoint1: CGPointMake(-7.19, -5.07) controlPoint2: CGPointMake(-6.24, -5.07)];
            [brightnessPath addCurveToPoint: CGPointMake(-5.66, -7.78) controlPoint1: CGPointMake(-5.07, -6.24) controlPoint2: CGPointMake(-5.07, -7.19)];
            [brightnessPath addLineToPoint: CGPointMake(-6.36, -8.49)];
            [brightnessPath closePath];
            [brightnessPath applyTransform:move];
            [color setFill];
            [brightnessPath fill];
        }
            break;
        case PtEdViewBarButtonTypeSaturation:
        {
            
            UIColor* color2 = [UIColor colorWithRed: 0.6 green: 0.6 blue: 0.6 alpha: 0.8];
            UIColor* color3 = [UIColor colorWithRed: 0.9 green: 0.9 blue: 0.9 alpha: 0.8];
            
            //// Oval Drawing
            UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(-7, -12, 14, 14)];
            [ovalPath applyTransform:move];
            [color setFill];
            [ovalPath fill];
            
            
            //// Oval 2 Drawing
            UIBezierPath* oval2Path = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(-12, -3, 14, 14)];
            [oval2Path applyTransform:move];
            [color3 setFill];
            [oval2Path fill];
            
            
            //// Oval 3 Drawing
            UIBezierPath* oval3Path = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(-2, -3, 14, 14)];
            [oval3Path applyTransform:move];
            [color2 setFill];
            [oval3Path fill];
            
            
            //// Bezier Drawing
            UIBezierPath* bezierPath = [UIBezierPath bezierPath];
            [bezierPath moveToPoint: CGPointMake(1.65, 1.8)];
            [bezierPath addCurveToPoint: CGPointMake(-1.65, 1.8) controlPoint1: CGPointMake(0.57, 2.07) controlPoint2: CGPointMake(-0.57, 2.07)];
            [bezierPath addCurveToPoint: CGPointMake(-0, -0.9) controlPoint1: CGPointMake(-1.32, 0.82) controlPoint2: CGPointMake(-0.77, -0.11)];
            [bezierPath addCurveToPoint: CGPointMake(1.65, 1.8) controlPoint1: CGPointMake(0.77, -0.11) controlPoint2: CGPointMake(1.32, 0.82)];
            [bezierPath closePath];
            [bezierPath applyTransform:move];
            [color setFill];
            [bezierPath fill];
            
            
        }
            break;
        case PtEdViewBarButtonTypeShadow:
        {
            
            //// Shadow Drawing
            UIBezierPath* shadowPath = [UIBezierPath bezierPath];
            [shadowPath moveToPoint: CGPointMake(8.5, -8)];
            [shadowPath addLineToPoint: CGPointMake(7, -8)];
            [shadowPath addLineToPoint: CGPointMake(7, 0.5)];
            [shadowPath addLineToPoint: CGPointMake(6, 0.5)];
            [shadowPath addLineToPoint: CGPointMake(6, -8)];
            [shadowPath addLineToPoint: CGPointMake(4.5, -8)];
            [shadowPath addLineToPoint: CGPointMake(4.5, 0.5)];
            [shadowPath addLineToPoint: CGPointMake(3.5, 0.5)];
            [shadowPath addLineToPoint: CGPointMake(3.5, -8)];
            [shadowPath addLineToPoint: CGPointMake(2, -8)];
            [shadowPath addLineToPoint: CGPointMake(2, 0.5)];
            [shadowPath addLineToPoint: CGPointMake(1, 0.5)];
            [shadowPath addLineToPoint: CGPointMake(1, -8)];
            [shadowPath addLineToPoint: CGPointMake(-0.5, -8)];
            [shadowPath addLineToPoint: CGPointMake(-0.5, 0.5)];
            [shadowPath addLineToPoint: CGPointMake(-1.5, 0.5)];
            [shadowPath addLineToPoint: CGPointMake(-1.5, -8)];
            [shadowPath addLineToPoint: CGPointMake(-3, -8)];
            [shadowPath addLineToPoint: CGPointMake(-3, 0.5)];
            [shadowPath addLineToPoint: CGPointMake(-4, 0.5)];
            [shadowPath addLineToPoint: CGPointMake(-4, -8)];
            [shadowPath addLineToPoint: CGPointMake(-5.5, -8)];
            [shadowPath addLineToPoint: CGPointMake(-5.5, 0.5)];
            [shadowPath addLineToPoint: CGPointMake(-6.5, 0.5)];
            [shadowPath addLineToPoint: CGPointMake(-6.5, -8)];
            [shadowPath addLineToPoint: CGPointMake(-8, -8)];
            [shadowPath addLineToPoint: CGPointMake(-8, 8.5)];
            [shadowPath addLineToPoint: CGPointMake(8.5, 8.5)];
            [shadowPath addLineToPoint: CGPointMake(8.5, -8)];
            [shadowPath closePath];
            [shadowPath moveToPoint: CGPointMake(10.5, 10.5)];
            [shadowPath addLineToPoint: CGPointMake(-10, 10.5)];
            [shadowPath addLineToPoint: CGPointMake(-10, -10)];
            [shadowPath addLineToPoint: CGPointMake(10.5, -10)];
            [shadowPath addLineToPoint: CGPointMake(10.5, 10.5)];
            [shadowPath closePath];
            [shadowPath applyTransform:move];
            [color setFill];
            [shadowPath fill];
            
            
        }
            break;
        case PtEdViewBarButtonTypeHighlight:
        {
            //// Highlight Drawing
            UIBezierPath* highlightPath = [UIBezierPath bezierPath];
            [highlightPath moveToPoint: CGPointMake(8.5, 0)];
            [highlightPath addLineToPoint: CGPointMake(7, 0)];
            [highlightPath addLineToPoint: CGPointMake(7, 8.5)];
            [highlightPath addLineToPoint: CGPointMake(8.5, 8.5)];
            [highlightPath addLineToPoint: CGPointMake(8.5, 0)];
            [highlightPath closePath];
            [highlightPath moveToPoint: CGPointMake(6, 0)];
            [highlightPath addLineToPoint: CGPointMake(4.5, 0)];
            [highlightPath addLineToPoint: CGPointMake(4.5, 8.5)];
            [highlightPath addLineToPoint: CGPointMake(6, 8.5)];
            [highlightPath addLineToPoint: CGPointMake(6, 0)];
            [highlightPath closePath];
            [highlightPath moveToPoint: CGPointMake(3.5, 0)];
            [highlightPath addLineToPoint: CGPointMake(2, 0)];
            [highlightPath addLineToPoint: CGPointMake(2, 8.5)];
            [highlightPath addLineToPoint: CGPointMake(3.5, 8.5)];
            [highlightPath addLineToPoint: CGPointMake(3.5, 0)];
            [highlightPath closePath];
            [highlightPath moveToPoint: CGPointMake(1, 0)];
            [highlightPath addLineToPoint: CGPointMake(-0.5, 0)];
            [highlightPath addLineToPoint: CGPointMake(-0.5, 8.5)];
            [highlightPath addLineToPoint: CGPointMake(1, 8.5)];
            [highlightPath addLineToPoint: CGPointMake(1, 0)];
            [highlightPath closePath];
            [highlightPath moveToPoint: CGPointMake(-1.5, 0)];
            [highlightPath addLineToPoint: CGPointMake(-3, 0)];
            [highlightPath addLineToPoint: CGPointMake(-3, 8.5)];
            [highlightPath addLineToPoint: CGPointMake(-1.5, 8.5)];
            [highlightPath addLineToPoint: CGPointMake(-1.5, 0)];
            [highlightPath closePath];
            [highlightPath moveToPoint: CGPointMake(-4, 0)];
            [highlightPath addLineToPoint: CGPointMake(-5.5, 0)];
            [highlightPath addLineToPoint: CGPointMake(-5.5, 8.5)];
            [highlightPath addLineToPoint: CGPointMake(-4, 8.5)];
            [highlightPath addLineToPoint: CGPointMake(-4, 0)];
            [highlightPath closePath];
            [highlightPath moveToPoint: CGPointMake(-6.5, 0)];
            [highlightPath addLineToPoint: CGPointMake(-8, 0)];
            [highlightPath addLineToPoint: CGPointMake(-8, 8.5)];
            [highlightPath addLineToPoint: CGPointMake(-6.5, 8.5)];
            [highlightPath addLineToPoint: CGPointMake(-6.5, 0)];
            [highlightPath closePath];
            [highlightPath moveToPoint: CGPointMake(10.5, 10.5)];
            [highlightPath addLineToPoint: CGPointMake(-10, 10.5)];
            [highlightPath addLineToPoint: CGPointMake(-10, -10)];
            [highlightPath addLineToPoint: CGPointMake(10.5, -10)];
            [highlightPath addLineToPoint: CGPointMake(10.5, 10.5)];
            [highlightPath closePath];
            [highlightPath applyTransform:move];
            [color setFill];
            [highlightPath fill];
        }
            break;
        case PtEdViewBarButtonTypeExposure:
        {
            
            //// Exposure Drawing
            UIBezierPath* exposurePath = [UIBezierPath bezierPath];
            [exposurePath moveToPoint: CGPointMake(2.5, -11)];
            [exposurePath addLineToPoint: CGPointMake(-4.5, -9.5)];
            [exposurePath addLineToPoint: CGPointMake(-7, 2.5)];
            [exposurePath addLineToPoint: CGPointMake(0, 1.5)];
            [exposurePath addLineToPoint: CGPointMake(-1.5, 11.5)];
            [exposurePath addLineToPoint: CGPointMake(7, -4)];
            [exposurePath addLineToPoint: CGPointMake(-1, -2.5)];
            [exposurePath addLineToPoint: CGPointMake(2.5, -11)];
            [exposurePath closePath];
            [exposurePath applyTransform:move];
            exposurePath.miterLimit = 4;
            
            exposurePath.usesEvenOddFillRule = YES;
            
            [color setFill];
            [exposurePath fill];
            

        }
            break;
        case PtEdViewBarButtonTypeClarify:
        {
            
            //// Clarify Drawing
            UIBezierPath* clarifyPath = [UIBezierPath bezierPath];
            [clarifyPath moveToPoint: CGPointMake(0, -8.5)];
            [clarifyPath addLineToPoint: CGPointMake(0, -8)];
            [clarifyPath addLineToPoint: CGPointMake(0, 8)];
            [clarifyPath addLineToPoint: CGPointMake(0, 8.5)];
            [clarifyPath addCurveToPoint: CGPointMake(6.01, 6.01) controlPoint1: CGPointMake(2.18, 8.5) controlPoint2: CGPointMake(4.35, 7.67)];
            [clarifyPath addCurveToPoint: CGPointMake(6.01, -6.01) controlPoint1: CGPointMake(9.33, 2.69) controlPoint2: CGPointMake(9.33, -2.69)];
            [clarifyPath addCurveToPoint: CGPointMake(0, -8.5) controlPoint1: CGPointMake(4.35, -7.67) controlPoint2: CGPointMake(2.18, -8.5)];
            [clarifyPath closePath];
            [clarifyPath moveToPoint: CGPointMake(7.78, -7.78)];
            [clarifyPath addCurveToPoint: CGPointMake(7.78, 7.78) controlPoint1: CGPointMake(12.07, -3.48) controlPoint2: CGPointMake(12.07, 3.48)];
            [clarifyPath addCurveToPoint: CGPointMake(-7.78, 7.78) controlPoint1: CGPointMake(3.48, 12.07) controlPoint2: CGPointMake(-3.48, 12.07)];
            [clarifyPath addCurveToPoint: CGPointMake(-7.78, -7.78) controlPoint1: CGPointMake(-12.07, 3.48) controlPoint2: CGPointMake(-12.07, -3.48)];
            [clarifyPath addCurveToPoint: CGPointMake(7.78, -7.78) controlPoint1: CGPointMake(-3.48, -12.07) controlPoint2: CGPointMake(3.48, -12.07)];
            [clarifyPath closePath];
            [clarifyPath applyTransform:move];
            [color setFill];
            [clarifyPath fill];
            
            
        }
            break;
        case PtEdViewBarButtonTypeTemp:
        {
            
            //// Bezier 3 Drawing
            UIBezierPath* tempPath = [UIBezierPath bezierPath];
            [tempPath moveToPoint: CGPointMake(0, -10)];
            [tempPath addCurveToPoint: CGPointMake(-3, -7) controlPoint1: CGPointMake(-1.66, -10) controlPoint2: CGPointMake(-3, -8.66)];
            [tempPath addLineToPoint: CGPointMake(-3, -1.2)];
            [tempPath addCurveToPoint: CGPointMake(-4.24, -0.24) controlPoint1: CGPointMake(-3.44, -0.94) controlPoint2: CGPointMake(-3.86, -0.62)];
            [tempPath addCurveToPoint: CGPointMake(-4.24, 8.24) controlPoint1: CGPointMake(-6.59, 2.1) controlPoint2: CGPointMake(-6.59, 5.9)];
            [tempPath addCurveToPoint: CGPointMake(4.24, 8.24) controlPoint1: CGPointMake(-1.9, 10.59) controlPoint2: CGPointMake(1.9, 10.59)];
            [tempPath addCurveToPoint: CGPointMake(6, 4.13) controlPoint1: CGPointMake(5.38, 7.1) controlPoint2: CGPointMake(5.97, 5.62)];
            [tempPath addCurveToPoint: CGPointMake(4.24, -0.24) controlPoint1: CGPointMake(6.03, 2.55) controlPoint2: CGPointMake(5.45, 0.96)];
            [tempPath addCurveToPoint: CGPointMake(3, -1.2) controlPoint1: CGPointMake(3.86, -0.62) controlPoint2: CGPointMake(3.44, -0.94)];
            [tempPath addLineToPoint: CGPointMake(3, -7)];
            [tempPath addCurveToPoint: CGPointMake(0, -10) controlPoint1: CGPointMake(3, -8.66) controlPoint2: CGPointMake(1.66, -10)];
            [tempPath closePath];
            [tempPath moveToPoint: CGPointMake(5, -7)];
            [tempPath addLineToPoint: CGPointMake(5, -2.25)];
            [tempPath addCurveToPoint: CGPointMake(5.66, -1.66) controlPoint1: CGPointMake(5.23, -2.06) controlPoint2: CGPointMake(5.45, -1.87)];
            [tempPath addCurveToPoint: CGPointMake(8, 4.13) controlPoint1: CGPointMake(7.25, -0.06) controlPoint2: CGPointMake(8.03, 2.04)];
            [tempPath addCurveToPoint: CGPointMake(5.66, 9.66) controlPoint1: CGPointMake(7.97, 6.13) controlPoint2: CGPointMake(7.19, 8.13)];
            [tempPath addCurveToPoint: CGPointMake(-5.66, 9.66) controlPoint1: CGPointMake(2.53, 12.78) controlPoint2: CGPointMake(-2.53, 12.78)];
            [tempPath addCurveToPoint: CGPointMake(-5.66, -1.66) controlPoint1: CGPointMake(-8.78, 6.53) controlPoint2: CGPointMake(-8.78, 1.47)];
            [tempPath addCurveToPoint: CGPointMake(-5, -2.25) controlPoint1: CGPointMake(-5.45, -1.87) controlPoint2: CGPointMake(-5.23, -2.06)];
            [tempPath addLineToPoint: CGPointMake(-5, -7)];
            [tempPath addCurveToPoint: CGPointMake(0, -12) controlPoint1: CGPointMake(-5, -9.76) controlPoint2: CGPointMake(-2.76, -12)];
            [tempPath addCurveToPoint: CGPointMake(5, -7) controlPoint1: CGPointMake(2.76, -12) controlPoint2: CGPointMake(5, -9.76)];
            [tempPath closePath];
            [tempPath moveToPoint: CGPointMake(0.44, 2.44)];
            [tempPath addCurveToPoint: CGPointMake(0.02, 3.28) controlPoint1: CGPointMake(0.2, 2.68) controlPoint2: CGPointMake(0.06, 2.98)];
            [tempPath addCurveToPoint: CGPointMake(0.44, 4.56) controlPoint1: CGPointMake(-0.05, 3.74) controlPoint2: CGPointMake(0.09, 4.21)];
            [tempPath addCurveToPoint: CGPointMake(2.56, 4.56) controlPoint1: CGPointMake(1.03, 5.15) controlPoint2: CGPointMake(1.97, 5.15)];
            [tempPath addCurveToPoint: CGPointMake(2.56, 2.44) controlPoint1: CGPointMake(3.15, 3.97) controlPoint2: CGPointMake(3.15, 3.03)];
            [tempPath addCurveToPoint: CGPointMake(0.44, 2.44) controlPoint1: CGPointMake(1.97, 1.85) controlPoint2: CGPointMake(1.03, 1.85)];
            [tempPath closePath];
            [tempPath moveToPoint: CGPointMake(1, -6)];
            [tempPath addLineToPoint: CGPointMake(1, 0.13)];
            [tempPath addCurveToPoint: CGPointMake(2.83, 1.17) controlPoint1: CGPointMake(1.67, 0.3) controlPoint2: CGPointMake(2.3, 0.65)];
            [tempPath addCurveToPoint: CGPointMake(3.82, 2.82) controlPoint1: CGPointMake(3.31, 1.65) controlPoint2: CGPointMake(3.64, 2.22)];
            [tempPath addCurveToPoint: CGPointMake(2.83, 6.83) controlPoint1: CGPointMake(4.24, 4.21) controlPoint2: CGPointMake(3.91, 5.75)];
            [tempPath addCurveToPoint: CGPointMake(-2.83, 6.83) controlPoint1: CGPointMake(1.27, 8.39) controlPoint2: CGPointMake(-1.27, 8.39)];
            [tempPath addCurveToPoint: CGPointMake(-2.83, 1.17) controlPoint1: CGPointMake(-4.39, 5.27) controlPoint2: CGPointMake(-4.39, 2.73)];
            [tempPath addCurveToPoint: CGPointMake(-1, 0.13) controlPoint1: CGPointMake(-2.3, 0.65) controlPoint2: CGPointMake(-1.67, 0.3)];
            [tempPath addLineToPoint: CGPointMake(-1, -6)];
            [tempPath addCurveToPoint: CGPointMake(0, -7) controlPoint1: CGPointMake(-1, -6.55) controlPoint2: CGPointMake(-0.55, -7)];
            [tempPath addCurveToPoint: CGPointMake(1, -6) controlPoint1: CGPointMake(0.55, -7) controlPoint2: CGPointMake(1, -6.55)];
            [tempPath closePath];
            [tempPath applyTransform:move];
            [color setFill];
            [tempPath fill];
        }
            break;
        case PtEdViewBarButtonTypeVignette:
        {
            //// Bezier 2 Drawing
            UIBezierPath* vignettePath = [UIBezierPath bezierPath];
            [vignettePath moveToPoint: CGPointMake(-5.66, -5.66)];
            [vignettePath addCurveToPoint: CGPointMake(-5.66, 5.66) controlPoint1: CGPointMake(-8.78, -2.53) controlPoint2: CGPointMake(-8.78, 2.53)];
            [vignettePath addCurveToPoint: CGPointMake(5.66, 5.66) controlPoint1: CGPointMake(-2.53, 8.78) controlPoint2: CGPointMake(2.53, 8.78)];
            [vignettePath addCurveToPoint: CGPointMake(5.66, -5.66) controlPoint1: CGPointMake(8.78, 2.53) controlPoint2: CGPointMake(8.78, -2.53)];
            [vignettePath addCurveToPoint: CGPointMake(-5.66, -5.66) controlPoint1: CGPointMake(2.53, -8.78) controlPoint2: CGPointMake(-2.53, -8.78)];
            [vignettePath closePath];
            [vignettePath moveToPoint: CGPointMake(10, 10)];
            [vignettePath addLineToPoint: CGPointMake(-10, 10)];
            [vignettePath addLineToPoint: CGPointMake(-10, -10)];
            [vignettePath addLineToPoint: CGPointMake(10, -10)];
            [vignettePath addLineToPoint: CGPointMake(10, 10)];
            [vignettePath closePath];
            [vignettePath applyTransform:move];
            [color setFill];
            [vignettePath fill];
            
            
        }
            break;
        case PtEdViewBarButtonTypeSkyEnhancement:
        {
            
            //// Sky Drawing
            UIBezierPath* skyPath = [UIBezierPath bezierPath];
            [skyPath moveToPoint: CGPointMake(2.6, -1.6)];
            [skyPath addCurveToPoint: CGPointMake(3.86, 0.18) controlPoint1: CGPointMake(3.13, -1.06) controlPoint2: CGPointMake(3.55, -0.46)];
            [skyPath addCurveToPoint: CGPointMake(7.72, -0.36) controlPoint1: CGPointMake(5.04, -0.48) controlPoint2: CGPointMake(6.42, -0.66)];
            [skyPath addCurveToPoint: CGPointMake(10.39, 1.11) controlPoint1: CGPointMake(8.7, -0.14) controlPoint2: CGPointMake(9.63, 0.35)];
            [skyPath addCurveToPoint: CGPointMake(10.39, 8.89) controlPoint1: CGPointMake(12.54, 3.26) controlPoint2: CGPointMake(12.54, 6.74)];
            [skyPath addCurveToPoint: CGPointMake(5.69, 10.44) controlPoint1: CGPointMake(9.11, 10.17) controlPoint2: CGPointMake(7.35, 10.69)];
            [skyPath addCurveToPoint: CGPointMake(5, 10.5) controlPoint1: CGPointMake(5.47, 10.48) controlPoint2: CGPointMake(5.24, 10.5)];
            [skyPath addLineToPoint: CGPointMake(-8, 10.5)];
            [skyPath addCurveToPoint: CGPointMake(-12, 6.5) controlPoint1: CGPointMake(-10.21, 10.5) controlPoint2: CGPointMake(-12, 8.71)];
            [skyPath addCurveToPoint: CGPointMake(-8.48, 2.53) controlPoint1: CGPointMake(-12, 4.45) controlPoint2: CGPointMake(-10.46, 2.77)];
            [skyPath addCurveToPoint: CGPointMake(-6.6, -1.6) controlPoint1: CGPointMake(-8.37, 1.03) controlPoint2: CGPointMake(-7.75, -0.45)];
            [skyPath addCurveToPoint: CGPointMake(2.6, -1.6) controlPoint1: CGPointMake(-4.06, -4.13) controlPoint2: CGPointMake(0.06, -4.13)];
            [skyPath closePath];
            [skyPath moveToPoint: CGPointMake(5.5, -9)];
            [skyPath addLineToPoint: CGPointMake(5.5, -8)];
            [skyPath addCurveToPoint: CGPointMake(5.49, -7.84) controlPoint1: CGPointMake(5.5, -7.95) controlPoint2: CGPointMake(5.5, -7.89)];
            [skyPath addCurveToPoint: CGPointMake(4.99, -7.13) controlPoint1: CGPointMake(5.44, -7.53) controlPoint2: CGPointMake(5.25, -7.27)];
            [skyPath addCurveToPoint: CGPointMake(4.5, -7) controlPoint1: CGPointMake(4.85, -7.05) controlPoint2: CGPointMake(4.68, -7)];
            [skyPath addCurveToPoint: CGPointMake(3.5, -8) controlPoint1: CGPointMake(3.95, -7) controlPoint2: CGPointMake(3.5, -7.45)];
            [skyPath addLineToPoint: CGPointMake(3.5, -9)];
            [skyPath addCurveToPoint: CGPointMake(4.5, -10) controlPoint1: CGPointMake(3.5, -9.55) controlPoint2: CGPointMake(3.95, -10)];
            [skyPath addCurveToPoint: CGPointMake(5.5, -9) controlPoint1: CGPointMake(5.05, -10) controlPoint2: CGPointMake(5.5, -9.55)];
            [skyPath closePath];
            [skyPath moveToPoint: CGPointMake(10.86, -7.36)];
            [skyPath addCurveToPoint: CGPointMake(10.86, -5.95) controlPoint1: CGPointMake(11.25, -6.97) controlPoint2: CGPointMake(11.25, -6.34)];
            [skyPath addLineToPoint: CGPointMake(10.16, -5.24)];
            [skyPath addCurveToPoint: CGPointMake(10.03, -5.14) controlPoint1: CGPointMake(10.12, -5.2) controlPoint2: CGPointMake(10.08, -5.17)];
            [skyPath addCurveToPoint: CGPointMake(9.18, -4.99) controlPoint1: CGPointMake(9.78, -4.96) controlPoint2: CGPointMake(9.47, -4.91)];
            [skyPath addCurveToPoint: CGPointMake(8.82, -5.17) controlPoint1: CGPointMake(9.05, -5.02) controlPoint2: CGPointMake(8.93, -5.08)];
            [skyPath addCurveToPoint: CGPointMake(8.74, -5.24) controlPoint1: CGPointMake(8.79, -5.19) controlPoint2: CGPointMake(8.77, -5.22)];
            [skyPath addCurveToPoint: CGPointMake(8.74, -6.66) controlPoint1: CGPointMake(8.35, -5.63) controlPoint2: CGPointMake(8.35, -6.27)];
            [skyPath addLineToPoint: CGPointMake(9.45, -7.36)];
            [skyPath addCurveToPoint: CGPointMake(10.86, -7.36) controlPoint1: CGPointMake(9.84, -7.75) controlPoint2: CGPointMake(10.47, -7.75)];
            [skyPath closePath];
            [skyPath moveToPoint: CGPointMake(-0.45, -7.36)];
            [skyPath addLineToPoint: CGPointMake(0.26, -6.66)];
            [skyPath addCurveToPoint: CGPointMake(0.26, -5.24) controlPoint1: CGPointMake(0.65, -6.27) controlPoint2: CGPointMake(0.65, -5.63)];
            [skyPath addCurveToPoint: CGPointMake(-1.16, -5.24) controlPoint1: CGPointMake(-0.13, -4.85) controlPoint2: CGPointMake(-0.77, -4.85)];
            [skyPath addLineToPoint: CGPointMake(-1.86, -5.95)];
            [skyPath addCurveToPoint: CGPointMake(-1.86, -7.36) controlPoint1: CGPointMake(-2.25, -6.34) controlPoint2: CGPointMake(-2.25, -6.97)];
            [skyPath addCurveToPoint: CGPointMake(-0.45, -7.36) controlPoint1: CGPointMake(-1.47, -7.75) controlPoint2: CGPointMake(-0.84, -7.75)];
            [skyPath closePath];
            [skyPath moveToPoint: CGPointMake(7.68, -4.18)];
            [skyPath addCurveToPoint: CGPointMake(9, -1.06) controlPoint1: CGPointMake(8.55, -3.32) controlPoint2: CGPointMake(8.99, -2.19)];
            [skyPath addCurveToPoint: CGPointMake(4.28, -1.11) controlPoint1: CGPointMake(7.5, -1.63) controlPoint2: CGPointMake(5.8, -1.66)];
            [skyPath addCurveToPoint: CGPointMake(3.3, -2.3) controlPoint1: CGPointMake(4, -1.53) controlPoint2: CGPointMake(3.67, -1.93)];
            [skyPath addCurveToPoint: CGPointMake(1.03, -3.86) controlPoint1: CGPointMake(2.63, -2.98) controlPoint2: CGPointMake(1.85, -3.5)];
            [skyPath addCurveToPoint: CGPointMake(1.32, -4.18) controlPoint1: CGPointMake(1.12, -3.97) controlPoint2: CGPointMake(1.22, -4.08)];
            [skyPath addCurveToPoint: CGPointMake(7.68, -4.18) controlPoint1: CGPointMake(3.08, -5.94) controlPoint2: CGPointMake(5.92, -5.94)];
            [skyPath closePath];
            [skyPath moveToPoint: CGPointMake(13.5, -1)];
            [skyPath addCurveToPoint: CGPointMake(12.5, 0) controlPoint1: CGPointMake(13.5, -0.45) controlPoint2: CGPointMake(13.05, 0)];
            [skyPath addLineToPoint: CGPointMake(11.5, 0)];
            [skyPath addCurveToPoint: CGPointMake(11.32, -0.02) controlPoint1: CGPointMake(11.45, 0) controlPoint2: CGPointMake(11.39, -0)];
            [skyPath addCurveToPoint: CGPointMake(10.95, -0.17) controlPoint1: CGPointMake(11.18, -0.04) controlPoint2: CGPointMake(11.06, -0.09)];
            [skyPath addCurveToPoint: CGPointMake(10.5, -1) controlPoint1: CGPointMake(10.68, -0.35) controlPoint2: CGPointMake(10.5, -0.65)];
            [skyPath addCurveToPoint: CGPointMake(11.5, -2) controlPoint1: CGPointMake(10.5, -1.55) controlPoint2: CGPointMake(10.95, -2)];
            [skyPath addLineToPoint: CGPointMake(12.5, -2)];
            [skyPath addCurveToPoint: CGPointMake(13.5, -1) controlPoint1: CGPointMake(13.05, -2) controlPoint2: CGPointMake(13.5, -1.55)];
            [skyPath closePath];
            [skyPath applyTransform:move];
            [color setFill];
            [skyPath fill];
            
            

        }
            break;
        default:
            break;
    }
    
    
}


@end
