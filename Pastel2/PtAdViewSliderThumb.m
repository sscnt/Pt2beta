//
//  PtAdViewSliderThumb.m
//  Pastel2
//
//  Created by SSC on 2014/06/22.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "PtAdViewSliderThumb.h"

@implementation PtAdViewSliderThumb


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

- (void)setColor:(UIColor *)color
{
    _color = color;
    [self setNeedsDisplay];
}

- (void)setBgColor:(UIColor *)bgColor
{
    _bgColor = bgColor;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    //// Color Declarations
    float radius;
    
    //// Oval Drawing
    radius = _radius;
    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake((rect.size.width - radius * 2.0) / 2.0f, (rect.size.height - radius * 2.0) / 2.0f, radius * 2.0, radius * 2.0)];
    [_color setFill];
    [ovalPath fill];
    
    
    //// Oval 2 Drawing
    radius = _radius - 3.0f;
    UIBezierPath* oval2Path = [UIBezierPath bezierPathWithOvalInRect: CGRectMake((rect.size.width - radius * 2.0) / 2.0f, (rect.size.height - radius * 2.0) / 2.0f, radius * 2.0, radius * 2.0)];
    [_bgColor setFill];
    [oval2Path fill];
    
    
    //// Oval 3 Drawing
    radius = _radius - 5.0f;
    UIBezierPath* oval3Path = [UIBezierPath bezierPathWithOvalInRect: CGRectMake((rect.size.width - radius * 2.0) / 2.0f, (rect.size.height - radius * 2.0) / 2.0f, radius * 2.0, radius * 2.0)];
    [_color setFill];
    [oval3Path fill];
}

@end
