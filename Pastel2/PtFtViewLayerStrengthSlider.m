//
//  VnViewSlider.m
//  Pastel
//
//  Created by SSC on 2014/05/11.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "PtFtViewLayerStrengthSlider.h"

@implementation PtFtViewLayerStrengthSlider

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //// Slider
        _paddingLeft = 54.0f;
        CGFloat sliderWidth = frame.size.width - _paddingLeft;
        _sliderView = [[PtFtViewSlider alloc] initWithFrame:CGRectMake(_paddingLeft, 0.0f, sliderWidth, 42.0f)];
        _sliderView.center = CGPointMake(_sliderView.center.x, self.bounds.size.height / 2.0f);
        _sliderView.delegate = self;
        [self addSubview:_sliderView];
    }
    return self;
}

- (void)setLocked:(BOOL)locked
{
    _locked = locked;
    _sliderView.locked = locked;
}

- (CGFloat)value
{
    return _sliderView.value;
}

- (void)setValue:(CGFloat)value
{
    _sliderView.value = value;
}

- (void)setButton:(PtFtButtonLayerBar*)button
{
    if (_button) {
        [_button removeFromSuperview];
        _button = nil;
    }
    _button = button;
    _button.center = CGPointMake(_paddingLeft / 2.0f, self.frame.size.height / 2.0f);
    [self addSubview:_button];
}

- (void)setSliderBgColor:(UIColor *)sliderBgColor
{
    _sliderBgColor = sliderBgColor;
    _sliderView.bgColor = _sliderBgColor;
}

- (void)setSliderThumbColor:(UIColor *)sliderThumbColor
{
    _sliderThumbColor = sliderThumbColor;
    _sliderView.thumbColor = sliderThumbColor;
}

- (void)setSliderStrokeColor:(UIColor *)sliderStrokeColor
{
    _sliderStrokeColor = sliderStrokeColor;
    _sliderView.strokeColor = sliderStrokeColor;
}


#pragma mark delegate

- (void)slider:(PtFtViewSlider*)slider DidValueChange:(CGFloat)value
{
    [self.delegate slider:self DidValueChange:value];
}

- (void)touchesBeganWithSlider:(PtFtViewSlider*)slider
{
    [self.delegate touchesBeganWithSlider:self];
}

- (void)touchesMovedWithSlider:(PtFtViewSlider*)slider
{
    
}

- (void)touchesEndedWithSlider:(PtFtViewSlider*)slider
{
    [self.delegate touchesEndedWithSlider:self];
}

@end
