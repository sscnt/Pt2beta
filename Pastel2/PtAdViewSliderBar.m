//
//  PtAdViewSliderBar.m
//  Pastel2
//
//  Created by SSC on 2014/06/22.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "PtAdViewSliderBar.h"
#import "PtAdViewSlider.h"

@implementation PtAdViewSliderBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [PtAdConfig barBgColor];
        float padding = 0.0f;
        _slider = [[PtAdViewSlider alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width - padding * 2.0, frame.size.height)];
        _slider.vertical = NO;
        _slider.center = CGPointMake([self width] / 2.0f, [self height] / 2.0);
        _slider.thumbColor = [UIColor whiteColor];
        _slider.strokeColor = [UIColor colorWithWhite:0.8f alpha:1.0f];
        _slider.indicatorColor = [UIColor whiteColor];
        _slider.thumbBgColor = self.backgroundColor;
        _slider.delegate = self;
        [self addSubview:_slider];
    }
    return self;
}

- (void)slider:(PtAdViewSlider *)slider DidValueChange:(CGFloat)value
{
    [self.delegate sliderDidValueChange:value];
}
- (void)touchesBeganWithSlider:(PtAdViewSlider*)slider
{
    
}
- (void)touchesMovedWithSlider:(PtAdViewSlider*)slider
{
    
}
- (void)touchesEndedWithSlider:(PtAdViewSlider*)slider
{
    
}

@end
