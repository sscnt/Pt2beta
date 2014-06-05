//
//  UISliderThumbVIew.m
//  Vintage
//
//  Created by SSC on 2014/02/16.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "LmCmViewSliderThumb.h"

@implementation LmCmViewSliderThumb

- (id)initWithRadius:(CGFloat)radius
{
    CGRect frame = CGRectMake(0.0f, 0.0f, radius * 2.0f, radius * 2.0f);
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = NO;
        _radius = radius;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setLocked:(BOOL)locked
{
    _locked = locked;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    //// Oval Drawing
    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(0.0f, 0.0f, _radius * 2.0, _radius * 2.0)];
    [_color setFill];
    [ovalPath fill];
}

@end
