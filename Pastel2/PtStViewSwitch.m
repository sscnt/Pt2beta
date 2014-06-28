//
//  PtStViewSwitch.m
//  Pastel2
//
//  Created by SSC on 2014/06/26.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "PtStViewSwitch.h"

@implementation PtStViewSwitch

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        
        _label = [[VnViewLabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height)];
        _label.fontSize = frame.size.height - 12.0f;
        [self addSubview:_label];
        
        self.on = NO;
    }
    return self;
}

- (void)setOn:(BOOL)on
{
    _on = on;
    if (on) {
        _label.text = NSLocalizedString(@"ON", nil);
        _label.textColor = [UIColor whiteColor];
        _label.center = CGPointMake(self.width / 8.0f * 3.0f, self.height / 2.0f - 1.0f);
    }else{
        _label.text = NSLocalizedString(@"OFF", nil);
        _label.textColor = [UIColor colorWithWhite:142.0f/255.0f alpha:1.0f];
        _label.center = CGPointMake(self.width / 8.0f * 5.0f, self.height / 2.0f - 1.0f);
    }
    [self setNeedsDisplay];
}

- (void)addTarget:(id)target selector:(SEL)selector
{
    _target = target;
    _selector = selector;
}

#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.on = !_on;
    [_target performSelector:_selector withObject:self];
}

- (void)drawRect:(CGRect)rect
{
    //// General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Color Declarations
    UIColor* color;
    UIColor* shadowColor;
    
    if (_on) {
        color = [UIColor colorWithRed: 0.31 green: 0.745 blue: 0.475 alpha: 1];
        shadowColor = [UIColor colorWithRed: 0.22 green: 0.643 blue: 0.38 alpha: 1];
    }else{
        color = [UIColor colorWithRed: 0.827 green: 0.827 blue: 0.827 alpha: 1];
        shadowColor = [UIColor colorWithRed: 0.722 green: 0.722 blue: 0.722 alpha: 1];
    }
    
    //// Shadow Declarations
    UIColor* shadow = shadowColor;
    CGSize shadowOffset = CGSizeMake(1.1, 1.1);
    CGFloat shadowBlurRadius = 1;
    UIColor* shadow3 = [[UIColor blackColor] colorWithAlphaComponent: 0.1];
    CGSize shadow3Offset = CGSizeMake(1.1, 1.1);
    CGFloat shadow3BlurRadius = 1;

    
    //// Rounded Rectangle Drawing
    UIBezierPath* roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect: rect cornerRadius: rect.size.height / 2.0f];
    [color setFill];
    [roundedRectanglePath fill];
    
    ////// Rounded Rectangle Inner Shadow
    CGRect roundedRectangleBorderRect = CGRectInset([roundedRectanglePath bounds], -shadowBlurRadius, -shadowBlurRadius);
    roundedRectangleBorderRect = CGRectOffset(roundedRectangleBorderRect, -shadowOffset.width, -shadowOffset.height);
    roundedRectangleBorderRect = CGRectInset(CGRectUnion(roundedRectangleBorderRect, [roundedRectanglePath bounds]), -1, -1);
    
    UIBezierPath* roundedRectangleNegativePath = [UIBezierPath bezierPathWithRect: roundedRectangleBorderRect];
    [roundedRectangleNegativePath appendPath: roundedRectanglePath];
    roundedRectangleNegativePath.usesEvenOddFillRule = YES;
    
    CGContextSaveGState(context);
    {
        CGFloat xOffset = shadowOffset.width + round(roundedRectangleBorderRect.size.width);
        CGFloat yOffset = shadowOffset.height;
        CGContextSetShadowWithColor(context,
                                    CGSizeMake(xOffset + copysign(0.1, xOffset), yOffset + copysign(0.1, yOffset)),
                                    shadowBlurRadius,
                                    shadow.CGColor);
        
        [roundedRectanglePath addClip];
        CGAffineTransform transform = CGAffineTransformMakeTranslation(-round(roundedRectangleBorderRect.size.width), 0);
        [roundedRectangleNegativePath applyTransform: transform];
        [[UIColor grayColor] setFill];
        [roundedRectangleNegativePath fill];
    }
    float padding = 4.0f;
    float radius = (rect.size.height - padding * 2.0f) / 2.0f;
    if (_on) {
        //// Oval Drawing
        UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(rect.size.width - padding - radius * 2.0f, padding, radius * 2.0f, radius * 2.0f)];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, shadow3Offset, shadow3BlurRadius, shadow3.CGColor);
        [[UIColor whiteColor] setFill];
        [ovalPath fill];
    }else{
        //// Oval Drawing
        UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(padding, padding, radius * 2.0f, radius * 2.0f)];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, shadow3Offset, shadow3BlurRadius, shadow3.CGColor);
        [[UIColor whiteColor] setFill];
        [ovalPath fill];
        
    }
    CGContextRestoreGState(context);
}

@end
