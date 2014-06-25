//
//  VnViewEditorLayerBarButtonMaskView.m
//  Pastel
//
//  Created by SSC on 2014/05/01.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "PtFtViewLayerBarButtonMask.h"

@implementation PtFtViewLayerBarButtonMask

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setMaskColor:(UIColor *)maskColor
{
    _maskColor = maskColor;
    [self setNeedsDisplay];
}

- (void)setRadius:(float)radius
{
    _radius = radius;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, rect);
    
    
    
    float p = rect.size.width / 2.0f;
    float t = rect.size.height / 2.0f + 1.0f;
    CGContextAddArc(context, p, t, _radius, 0.0f, M_PI * 2.0f, 1);
    
    CGContextAddRect (context, self.bounds);
    CGContextEOClip(context);
    
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: rect];
    [_maskColor setFill];
    [rectanglePath fill];
    
    if (_selected) {
        float r = _radius + 3.0f;
        p = (rect.size.width - r * 2.0f) / 2.0f;
        t = (rect.size.height - r * 2.0f) / 2.0f + 1.0f;
        UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(p, t, r * 2.0f, r * 2.0f)];
        [_selectionColor setStroke];
        ovalPath.lineWidth = 2;
        [ovalPath stroke];
    }
}

@end
