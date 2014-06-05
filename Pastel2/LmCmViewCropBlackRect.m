//
//  LmCmViewCropBlackRect.m
//  Lumina
//
//  Created by SSC on 2014/05/25.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "LmCmViewCropBlackRect.h"

@implementation LmCmViewCropBlackRect

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


- (void)setRectWithCropSize:(LmCmViewCropSize)size
{
    _orientation = [MotionOrientation sharedInstance].deviceOrientation;
    _cropSize = size;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    UIBezierPath* rectanglePath;
    UIColor* color = [LmCmSharedCamera cropMaskColor];
    
    switch (_cropSize) {
        case LmCmViewCropSizeSquare:
        {
            float baseLength = rect.size.width;
            float barHeight = (rect.size.height - baseLength) / 2.0f;
            
            rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(0.0f, 0.0f, rect.size.width, barHeight)];
            [color setFill];
            [rectanglePath fill];
            rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(0.0f, barHeight + baseLength, rect.size.width, barHeight)];
            [color setFill];
            [rectanglePath fill];

        }
            break;
        case LmCmViewCropSize16x9:
        {
            if (_orientation == UIDeviceOrientationPortrait || _orientation == UIDeviceOrientationPortraitUpsideDown) {
                float width = rect.size.width;
                float height = width * 9.0f / 16.0f;
                float barHeight = (rect.size.height - height) / 2.0f;
                
                rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(0.0f, 0.0f, rect.size.width, barHeight)];
                [color setFill];
                [rectanglePath fill];
                rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(0.0f, barHeight + height, rect.size.width, barHeight)];
                [color setFill];
                [rectanglePath fill];
            }else{
                float width = rect.size.height;
                float height = width * 9.0f / 16.0f;
                float barHeight = (rect.size.width - height) / 2.0f;
                
                rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(0.0f, 0.0f, barHeight, width)];
                [color setFill];
                [rectanglePath fill];
                rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(barHeight + height, 0.0f, barHeight, width)];
                [color setFill];
                [rectanglePath fill];
            }
        }
            break;
        case LmCmViewCropSize2x1:
        {
            if (_orientation == UIDeviceOrientationPortrait || _orientation == UIDeviceOrientationPortraitUpsideDown) {
                float width = rect.size.width;
                float height = width / 2.0f;
                float barHeight = (rect.size.height - height) / 2.0f;
                
                rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(0.0f, 0.0f, rect.size.width, barHeight)];
                [color setFill];
                [rectanglePath fill];
                rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(0.0f, barHeight + height, rect.size.width, barHeight)];
                [color setFill];
                [rectanglePath fill];
            }else{
                float width = rect.size.height;
                float height = width / 2.0f;
                float barHeight = (rect.size.width - height) / 2.0f;
                
                rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(0.0f, 0.0f, barHeight, width)];
                [color setFill];
                [rectanglePath fill];
                rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(barHeight + height, 0.0f, barHeight, width)];
                [color setFill];
                [rectanglePath fill];
            }
            
        }
            break;
        default:
            break;
    }
}


@end
