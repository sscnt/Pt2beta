//
//  LmViewCameraPreview.m
//  Lumina
//
//  Created by SSC on 2014/05/22.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "LmCmViewPreviewOverlay.h"

@implementation LmCmViewPreviewOverlay

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
        _flashView = [[UIView alloc] initWithFrame:self.bounds];
        _flashView.userInteractionEnabled = YES;
        _flashView.layer.backgroundColor = [UIColor whiteColor].CGColor;
        _flashView.layer.opacity = 0.0f;
        _flashView.backgroundColor = [UIColor blackColor];
        [self addSubview:_flashView];
    }
    return self;
}


- (void)flash
{
    [_flashView.layer removeAnimationForKey:@"flashAnimation"];
    CABasicAnimation *flash = [CABasicAnimation animationWithKeyPath:@"opacity"];
    flash.fromValue = [NSNumber numberWithFloat:1.0];
    flash.toValue = [NSNumber numberWithFloat:0.0];
    flash.duration = 0.20f;        // 1 second
    flash.autoreverses = NO;    // Back
    flash.repeatCount = 1;       // Or whatever
    flash.removedOnCompletion = NO;
    flash.fillMode = kCAFillModeForwards;
    
    [_flashView.layer addAnimation:flash forKey:@"flashAnimation"];
}

- (void)setShowGrid:(BOOL)showGrid
{
    _showGrid = showGrid;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{

    if (_showGrid) {
        UIDeviceOrientation orientation = [MotionOrientation sharedInstance].deviceOrientation;
                    //// Color Declarations
                    UIColor* color = [UIColor colorWithWhite:1.0f alpha:0.50f];
        switch ([LmCmSharedCamera instance].cropSize) {
            case LmCmViewCropSizeNormal:
            {
                    
                    //// Bezier Drawing
                    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
                    [bezierPath moveToPoint: CGPointMake(roundf(rect.size.width / 3.0f), 0.0f)];
                    [bezierPath addLineToPoint: CGPointMake(roundf(rect.size.width / 3.0f), rect.size.height)];
                    [color setStroke];
                    bezierPath.lineWidth = 1;
                    [bezierPath stroke];
                    
                    //// Bezier Drawing
                    bezierPath = [UIBezierPath bezierPath];
                    [bezierPath moveToPoint: CGPointMake(roundf(rect.size.width / 3.0f * 2.0f), 0.0f)];
                    [bezierPath addLineToPoint: CGPointMake(roundf(rect.size.width / 3.0f * 2.0f), rect.size.height)];
                    [color setStroke];
                    bezierPath.lineWidth = 1;
                    [bezierPath stroke];
                    
                    //// Bezier Drawing
                    bezierPath = [UIBezierPath bezierPath];
                    [bezierPath moveToPoint: CGPointMake(0.0f, roundf(rect.size.height / 3.0f))];
                    [bezierPath addLineToPoint: CGPointMake(rect.size.width, roundf(rect.size.height / 3.0f))];
                    [color setStroke];
                    bezierPath.lineWidth = 1;
                    [bezierPath stroke];
                    
                    //// Bezier Drawing
                    bezierPath = [UIBezierPath bezierPath];
                    [bezierPath moveToPoint: CGPointMake(0.0f, roundf(rect.size.height / 3.0f * 2.0f))];
                    [bezierPath addLineToPoint: CGPointMake(rect.size.width, roundf(rect.size.height / 3.0f * 2.0f))];
                    [color setStroke];
                    bezierPath.lineWidth = 1;
                    [bezierPath stroke];

            }
                break;
                
            case LmCmViewCropSizeSquare:
            {
                
                
                float baseLength = rect.size.width;
                float barHeight = (rect.size.height - baseLength) / 2.0f;
                
                //// Bezier Drawing
                UIBezierPath* bezierPath = [UIBezierPath bezierPath];
                [bezierPath moveToPoint: CGPointMake(roundf(baseLength / 3.0f), barHeight)];
                [bezierPath addLineToPoint: CGPointMake(roundf(baseLength / 3.0f), rect.size.height - barHeight)];
                [color setStroke];
                bezierPath.lineWidth = 1;
                [bezierPath stroke];
                
                //// Bezier Drawing
                bezierPath = [UIBezierPath bezierPath];
                [bezierPath moveToPoint: CGPointMake(roundf(baseLength / 3.0f * 2.0f), barHeight)];
                [bezierPath addLineToPoint: CGPointMake(roundf(baseLength / 3.0f * 2.0f), rect.size.height - barHeight)];
                [color setStroke];
                bezierPath.lineWidth = 1;
                [bezierPath stroke];
                
                //// Bezier Drawing
                bezierPath = [UIBezierPath bezierPath];
                [bezierPath moveToPoint: CGPointMake(0.0f, roundf(baseLength / 3.0f + barHeight))];
                [bezierPath addLineToPoint: CGPointMake(rect.size.width, roundf(baseLength / 3.0f + barHeight))];
                [color setStroke];
                bezierPath.lineWidth = 1;
                [bezierPath stroke];
                
                //// Bezier Drawing
                bezierPath = [UIBezierPath bezierPath];
                [bezierPath moveToPoint: CGPointMake(0.0f, roundf(baseLength / 3.0f * 2.0f + barHeight))];
                [bezierPath addLineToPoint: CGPointMake(rect.size.width, roundf(baseLength / 3.0f * 2.0f + barHeight))];
                [color setStroke];
                bezierPath.lineWidth = 1;
                [bezierPath stroke];
                
            }
                break;
            case LmCmViewCropSize16x9:
            {
                if (orientation == UIDeviceOrientationPortrait || orientation == UIDeviceOrientationPortraitUpsideDown) {
                    float width = rect.size.width;
                    float height = width * 9.0f / 16.0f;
                    float barHeight = (rect.size.height - height) / 2.0f;
                    
                    //// Bezier Drawing
                    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
                    [bezierPath moveToPoint: CGPointMake(roundf(width / 3.0f), barHeight)];
                    [bezierPath addLineToPoint: CGPointMake(roundf(width / 3.0f), rect.size.height - barHeight)];
                    [color setStroke];
                    bezierPath.lineWidth = 1;
                    [bezierPath stroke];
                    
                    //// Bezier Drawing
                    bezierPath = [UIBezierPath bezierPath];
                    [bezierPath moveToPoint: CGPointMake(roundf(width / 3.0f * 2.0f), barHeight)];
                    [bezierPath addLineToPoint: CGPointMake(roundf(width / 3.0f * 2.0f), rect.size.height - barHeight)];
                    [color setStroke];
                    bezierPath.lineWidth = 1;
                    [bezierPath stroke];
                    
                    //// Bezier Drawing
                    bezierPath = [UIBezierPath bezierPath];
                    [bezierPath moveToPoint: CGPointMake(0.0f, roundf(height / 3.0f + barHeight))];
                    [bezierPath addLineToPoint: CGPointMake(width, roundf(height / 3.0f + barHeight))];
                    [color setStroke];
                    bezierPath.lineWidth = 1;
                    [bezierPath stroke];
                    
                    //// Bezier Drawing
                    bezierPath = [UIBezierPath bezierPath];
                    [bezierPath moveToPoint: CGPointMake(0.0f, roundf(height / 3.0f * 2.0f + barHeight))];
                    [bezierPath addLineToPoint: CGPointMake(width, roundf(height / 3.0f * 2.0f + barHeight))];
                    [color setStroke];
                    bezierPath.lineWidth = 1;
                    [bezierPath stroke];
                }else{
                    float width = rect.size.height;
                    float height = width * 9.0f / 16.0f;
                    float barHeight = (rect.size.width - height) / 2.0f;
                    
                    //// Bezier Drawing
                    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
                    [bezierPath moveToPoint: CGPointMake(roundf(height / 3.0f + barHeight), 0.0f)];
                    [bezierPath addLineToPoint: CGPointMake(roundf(height / 3.0f + barHeight), width)];
                    [color setStroke];
                    bezierPath.lineWidth = 1;
                    [bezierPath stroke];
                    
                    //// Bezier Drawing
                    bezierPath = [UIBezierPath bezierPath];
                    [bezierPath moveToPoint: CGPointMake(roundf(height / 3.0f * 2.0f + barHeight), 0.0f)];
                    [bezierPath addLineToPoint: CGPointMake(roundf(height / 3.0f * 2.0f + barHeight), width)];
                    [color setStroke];
                    bezierPath.lineWidth = 1;
                    [bezierPath stroke];
                    
                    //// Bezier Drawing
                    bezierPath = [UIBezierPath bezierPath];
                    [bezierPath moveToPoint: CGPointMake(barHeight, roundf(width / 3.0f))];
                    [bezierPath addLineToPoint: CGPointMake(height + barHeight, roundf(width / 3.0f))];
                    [color setStroke];
                    bezierPath.lineWidth = 1;
                    [bezierPath stroke];
                    
                    //// Bezier Drawing
                    bezierPath = [UIBezierPath bezierPath];
                    [bezierPath moveToPoint: CGPointMake(barHeight, roundf(width / 3.0f * 2.0f))];
                    [bezierPath addLineToPoint: CGPointMake(height + barHeight, roundf(width / 3.0f * 2.0f))];
                    [color setStroke];
                    bezierPath.lineWidth = 1;
                    [bezierPath stroke];
                }
            }
                break;
            case LmCmViewCropSize2x1:
            {
                if (orientation == UIDeviceOrientationPortrait || orientation == UIDeviceOrientationPortraitUpsideDown) {
                    float width = rect.size.width;
                    float height = width / 2.0f;
                    float barHeight = (rect.size.height - height) / 2.0f;
                    
                    //// Bezier Drawing
                    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
                    [bezierPath moveToPoint: CGPointMake(roundf(width / 3.0f), barHeight)];
                    [bezierPath addLineToPoint: CGPointMake(roundf(width / 3.0f), rect.size.height - barHeight)];
                    [color setStroke];
                    bezierPath.lineWidth = 1;
                    [bezierPath stroke];
                    
                    //// Bezier Drawing
                    bezierPath = [UIBezierPath bezierPath];
                    [bezierPath moveToPoint: CGPointMake(roundf(width / 3.0f * 2.0f), barHeight)];
                    [bezierPath addLineToPoint: CGPointMake(roundf(width / 3.0f * 2.0f), rect.size.height - barHeight)];
                    [color setStroke];
                    bezierPath.lineWidth = 1;
                    [bezierPath stroke];
                    
                    //// Bezier Drawing
                    bezierPath = [UIBezierPath bezierPath];
                    [bezierPath moveToPoint: CGPointMake(0.0f, roundf(height / 3.0f + barHeight))];
                    [bezierPath addLineToPoint: CGPointMake(width, roundf(height / 3.0f + barHeight))];
                    [color setStroke];
                    bezierPath.lineWidth = 1;
                    [bezierPath stroke];
                    
                    //// Bezier Drawing
                    bezierPath = [UIBezierPath bezierPath];
                    [bezierPath moveToPoint: CGPointMake(0.0f, roundf(height / 3.0f * 2.0f + barHeight))];
                    [bezierPath addLineToPoint: CGPointMake(width, roundf(height / 3.0f * 2.0f + barHeight))];
                    [color setStroke];
                    bezierPath.lineWidth = 1;
                    [bezierPath stroke];
                }else{
                    float width = rect.size.height;
                    float height = width / 2.0f;
                    float barHeight = (rect.size.width - height) / 2.0f;
                    
                    //// Bezier Drawing
                    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
                    [bezierPath moveToPoint: CGPointMake(roundf(height / 3.0f + barHeight), 0.0f)];
                    [bezierPath addLineToPoint: CGPointMake(roundf(height / 3.0f + barHeight), width)];
                    [color setStroke];
                    bezierPath.lineWidth = 1;
                    [bezierPath stroke];
                    
                    //// Bezier Drawing
                    bezierPath = [UIBezierPath bezierPath];
                    [bezierPath moveToPoint: CGPointMake(roundf(height / 3.0f * 2.0f + barHeight), 0.0f)];
                    [bezierPath addLineToPoint: CGPointMake(roundf(height / 3.0f * 2.0f + barHeight), width)];
                    [color setStroke];
                    bezierPath.lineWidth = 1;
                    [bezierPath stroke];
                    
                    //// Bezier Drawing
                    bezierPath = [UIBezierPath bezierPath];
                    [bezierPath moveToPoint: CGPointMake(barHeight, roundf(width / 3.0f))];
                    [bezierPath addLineToPoint: CGPointMake(height + barHeight, roundf(width / 3.0f))];
                    [color setStroke];
                    bezierPath.lineWidth = 1;
                    [bezierPath stroke];
                    
                    //// Bezier Drawing
                    bezierPath = [UIBezierPath bezierPath];
                    [bezierPath moveToPoint: CGPointMake(barHeight, roundf(width / 3.0f * 2.0f))];
                    [bezierPath addLineToPoint: CGPointMake(height + barHeight, roundf(width / 3.0f * 2.0f))];
                    [color setStroke];
                    bezierPath.lineWidth = 1;
                    [bezierPath stroke];
                }
            }
                break;
                
            default:
                break;
        }
    }
}


@end
