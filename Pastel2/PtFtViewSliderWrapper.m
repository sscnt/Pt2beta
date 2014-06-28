//
//  PtFtViewSliderWrapper.m
//  Pastel2
//
//  Created by SSC on 2014/06/28.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "PtFtViewSliderWrapper.h"

@implementation PtFtViewSliderWrapper

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [PtFtConfig overlayBarBgColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    //// Color Declarations
    UIColor* color = [PtFtConfig artisticBarBgColor];
    
    //// Rectangle Drawing
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(0.0f, [PtFtConfig overlayBarHeight], rect.size.width, [PtFtConfig artisticBarHeight])];
    [color setFill];
    [rectanglePath fill];
}

- (void)removeAllButtons
{
    [_overlayButton removeFromSuperview];
    [_artisticButton removeFromSuperview];
    [_colorButton removeFromSuperview];
}

- (void)addColorFilterButton:(PtFtViewLayerBarButton *)button
{
    _colorButton = button;
    button.center = CGPointMake(button.width / 2.0f + ([PtFtConfig artisticLayerButtonSize].width - [PtFtConfig colorLayerButtonSize].width) / 2.0f , [PtFtConfig overlayBarHeight] + [PtFtConfig artisticBarHeight] + [PtFtConfig colorBarHeight] / 2.0f);
    [self addSubview:button];
}

- (void)addArtisticFilterButton:(PtFtViewLayerBarButton *)button
{
    _artisticButton = button;
    button.center = CGPointMake(button.width / 2.0f , [PtFtConfig overlayBarHeight] + [PtFtConfig artisticBarHeight] / 2.0f);
    [self addSubview:button];
}

- (void)addOverlayFilterButton:(PtFtViewLayerBarButton *)button
{
    _overlayButton = button;
    button.center = CGPointMake(button.width / 2.0f+ ([PtFtConfig artisticLayerButtonSize].width - [PtFtConfig overlayLayerButtonSize].width) / 2.0f, [PtFtConfig overlayBarHeight] / 2.0f);
    [self addSubview:button];
}

@end
