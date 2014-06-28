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
        
        //// Label
        _overlayLabel = [[VnViewLabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 50.0f, [PtFtConfig overlayBarHeight])];
        _overlayLabel.textColor = [UIColor colorWithWhite:0.90f alpha:1.0f];
        _overlayLabel.fontSize = 14.0f;
        _overlayLabel.center = CGPointMake(frame.size.width - _overlayLabel.width / 2.0f - 6.0f,  _overlayLabel.height / 2.0f);
        [self addSubview:_overlayLabel];
        
        _artisticLabel = [[VnViewLabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 50.0f, [PtFtConfig artisticBarHeight])];
        _artisticLabel.textColor = [UIColor colorWithWhite:0.90f alpha:1.0f];
        _artisticLabel.fontSize = 14.0f;
        _artisticLabel.center = CGPointMake(frame.size.width - _artisticLabel.width / 2.0f - 6.0f, _overlayLabel.bottom + _artisticLabel.height / 2.0f);
        [self addSubview:_artisticLabel];
        
        _colorLabel = [[VnViewLabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 50.0f, [PtFtConfig colorBarHeight])];
        _colorLabel.textColor = [UIColor colorWithWhite:0.90f alpha:1.0f];
        _colorLabel.fontSize = 14.0f;
        _colorLabel.center = CGPointMake(frame.size.width - _colorLabel.width / 2.0f - 6.0f, _artisticLabel.bottom + _colorLabel.height / 2.0f);
        [self addSubview:_colorLabel];
        
        self.overlayOpacity = 0.0f;
        self.colorOpacity = 0.0f;
        self.artisticOpacity = 0.0f;
        
    }
    return self;
}

- (void)setColorHidden:(BOOL)colorHidden
{
    _colorHidden = colorHidden;
    _colorLabel.hidden = colorHidden;
    _colorButton.hidden = colorHidden;
    _colorSlider.hidden = colorHidden;
}

- (void)setArtisticHidden:(BOOL)artisticHidden
{
    _artisticHidden = artisticHidden;
    _artisticLabel.hidden = artisticHidden;
    _artisticButton.hidden = artisticHidden;
    _artisticSlider.hidden = artisticHidden;
}

- (void)setOverlayHidden:(BOOL)overlayHidden
{
    _overlayHidden = overlayHidden;
    _overlayLabel.hidden = overlayHidden;
    _overlayButton.hidden = overlayHidden;
    _overlaySlider.hidden = overlayHidden;
}

- (void)setColorOpacity:(float)colorOpacity
{
    _colorOpacity = colorOpacity;
    _colorLabel.text = [NSString stringWithFormat:@"+%d", (int)(colorOpacity * 100.0f)];
}

- (void)setArtisticOpacity:(float)artisticOpacity
{
    _artisticOpacity = artisticOpacity;
    _artisticLabel.text = [NSString stringWithFormat:@"+%d", (int)(artisticOpacity * 100.0f)];
}

- (void)setOverlayOpacity:(float)overlayOpacity
{
    _overlayOpacity = overlayOpacity;
    _overlayLabel.text = [NSString stringWithFormat:@"+%d", (int)(overlayOpacity * 100.0f)];
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

- (void)addColorSliderBar:(PtAdViewSliderBar *)slider
{
    _colorSlider = slider;
    if ([UIDevice isiPad]) {
        
    }else{
        slider.center = CGPointMake(slider.width / 2.0f + [PtFtConfig artisticLayerButtonSize].width - 20.0f, [PtFtConfig overlayBarHeight] + [PtFtConfig artisticBarHeight] + [PtFtConfig colorBarHeight] / 2.0f);
        [self addSubview:slider];
    }
}

- (void)addArtisticSliderBar:(PtAdViewSliderBar *)slider
{
    _artisticSlider = slider;
    if ([UIDevice isiPad]) {
        
    }else{
        slider.center = CGPointMake(slider.width / 2.0f + [PtFtConfig artisticLayerButtonSize].width - 20.0f, [PtFtConfig overlayBarHeight] + [PtFtConfig artisticBarHeight] / 2.0f);
        [self addSubview:slider];
    }
}

- (void)addOverlaySliderBar:(PtAdViewSliderBar *)slider
{
    _overlaySlider = slider;
    if ([UIDevice isiPad]) {
        
    }else{
        slider.center = CGPointMake(slider.width / 2.0f + [PtFtConfig artisticLayerButtonSize].width - 20.0f, [PtFtConfig overlayBarHeight] / 2.0f);
        [self addSubview:slider];
    }
}

@end
