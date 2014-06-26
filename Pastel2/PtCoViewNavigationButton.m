//
//  PtFtButtonNavigation.m
//  Pastel2
//
//  Created by SSC on 2014/06/01.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "PtCoViewNavigationButton.h"

@implementation PtCoViewNavigationButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setType:(PtCoViewNavigationButtonType)type
{
    _type = type;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    
    UIColor* color = [UIColor colorWithWhite:1.0f alpha:0.80f];
    switch (_type) {
        case PtCoViewNavigationButtonTypeDone:
        {
            
            //// Bezier Drawing
            UIBezierPath* bezierPath = [UIBezierPath bezierPath];
            [bezierPath moveToPoint: CGPointMake(31.01, 18.61)];
            [bezierPath addLineToPoint: CGPointMake(21.11, 28.51)];
            [bezierPath addLineToPoint: CGPointMake(20.88, 28.28)];
            [bezierPath addLineToPoint: CGPointMake(20.77, 28.39)];
            [bezierPath addLineToPoint: CGPointMake(15.11, 22.73)];
            [bezierPath addLineToPoint: CGPointMake(17.23, 20.61)];
            [bezierPath addLineToPoint: CGPointMake(21, 24.38)];
            [bezierPath addLineToPoint: CGPointMake(28.89, 16.49)];
            [bezierPath addLineToPoint: CGPointMake(31.01, 18.61)];
            [bezierPath closePath];
            [color setFill];
            [bezierPath fill];
            

        }
            break;
        case PtCoViewNavigationButtonTypeCancel:
        {
            
            //// Bezier Drawing
            UIBezierPath* bezierPath = [UIBezierPath bezierPath];
            [bezierPath moveToPoint: CGPointMake(22.5, 20.38)];
            [bezierPath addLineToPoint: CGPointMake(27.1, 15.78)];
            [bezierPath addLineToPoint: CGPointMake(29.22, 17.9)];
            [bezierPath addLineToPoint: CGPointMake(24.62, 22.5)];
            [bezierPath addLineToPoint: CGPointMake(29.22, 27.1)];
            [bezierPath addLineToPoint: CGPointMake(27.1, 29.22)];
            [bezierPath addLineToPoint: CGPointMake(22.5, 24.62)];
            [bezierPath addLineToPoint: CGPointMake(17.9, 29.22)];
            [bezierPath addLineToPoint: CGPointMake(15.78, 27.1)];
            [bezierPath addLineToPoint: CGPointMake(20.38, 22.5)];
            [bezierPath addLineToPoint: CGPointMake(15.78, 17.9)];
            [bezierPath addLineToPoint: CGPointMake(17.9, 15.78)];
            [bezierPath addLineToPoint: CGPointMake(22.5, 20.38)];
            [bezierPath closePath];
            [color setFill];
            [bezierPath fill];
            


        }
            break;
        default:
            break;
    }
}

 
@end
