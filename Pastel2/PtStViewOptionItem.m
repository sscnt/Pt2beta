//
//  PtStViewOptionItem.m
//  Pastel2
//
//  Created by SSC on 2014/06/27.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "PtStViewOptionItem.h"

@implementation PtStViewOptionItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _label = [[VnViewLabel alloc] initWithFrame:self.bounds];
        _label.fontSize = 18.0f;
        _label.textAlignment = NSTextAlignmentLeft;
        _label.textColor = [UIColor colorWithWhite:0.10f alpha:1.0f];
        [self addSubview:_label];
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    _label.text = title;
}

- (void)addSwitch:(PtStViewSwitch *)sw
{
    sw.center = CGPointMake(self.width - sw.width / 2.0f - 10.0f, self.height / 2.0f);
    [_label setWidth:sw.frame.origin.x - 30.0f];
    _label.center = CGPointMake(_label.width / 2.0f + 20.0f, self.height / 2.0f - 1.0f);
    [self addSubview:sw];
}

- (void)drawRect:(CGRect)rect
{
    //// Color Declarations
    UIColor* topColor = [UIColor colorWithWhite:1.0f alpha:1.0f];
    UIColor* bottomColor = [UIColor colorWithWhite:0.8f alpha:1.0f];
    
    //// Rectangle Drawing
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(0.0f, rect.size.height - 1.0f, rect.size.width, 0.5f)];
    [topColor setFill];
    [rectanglePath fill];
    
    //// Rectangle Drawing
    rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(0.0f, rect.size.height - 0.50f, rect.size.width, 0.5f)];
    [bottomColor setFill];
    [rectanglePath fill];
}


@end
