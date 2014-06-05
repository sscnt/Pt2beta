//
//  VnViewSlider.h
//  Pastel
//
//  Created by SSC on 2014/05/11.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LmCmViewSlider.h"

@class LmCmViewZoomSlider;

@protocol LmCmViewZoomSliderDelegate
- (void)slider:(LmCmViewZoomSlider*)slider DidValueChange:(CGFloat)value;
- (void)sliderDidValueResetToDefault:(LmCmViewZoomSlider*)slider;
- (BOOL)sliderShouldValueResetToDefault:(LmCmViewZoomSlider*)slider;
- (void)touchesBeganWithSlider:(LmCmViewZoomSlider*)slider;
- (void)touchesEndedWithSlider:(LmCmViewZoomSlider*)slider;
@end

@interface LmCmViewZoomSlider : UIView <LmCmViewSliderDelegate>
{
    float _paddingTop;
}

@property (nonatomic, strong) LmCmViewSlider* sliderView;
@property (nonatomic, assign) CGFloat value;
@property (nonatomic, assign) CGFloat defaultValue;
@property (nonatomic, assign) CGFloat alpha;
@property (nonatomic, weak) id<LmCmViewZoomSliderDelegate> delegate;
@property (nonatomic, assign) BOOL locked;
@property (nonatomic, strong) UILabel* scaleLabel;
@property (nonatomic, assign) BOOL active;

@property (nonatomic, strong) UIColor* sliderStrokeColor;
@property (nonatomic, strong) UIColor* sliderThumbColor;

- (void)setScaleToLabel:(float)scale;

@end
