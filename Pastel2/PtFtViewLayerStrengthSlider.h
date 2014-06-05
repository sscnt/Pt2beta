//
//  VnViewSlider.h
//  Pastel
//
//  Created by SSC on 2014/05/11.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PtFtViewSlider.h"
#import "PtFtButtonLayerBar.h"

@class PtFtViewLayerStrengthSlider;

@protocol PtFtViewLayerStrengthSliderDelegate
- (void)slider:(PtFtViewLayerStrengthSlider*)slider DidValueChange:(CGFloat)value;
- (void)sliderDidValueResetToDefault:(PtFtViewLayerStrengthSlider*)slider;
- (BOOL)sliderShouldValueResetToDefault:(PtFtViewLayerStrengthSlider*)slider;
- (void)touchesBeganWithSlider:(PtFtViewLayerStrengthSlider*)slider;
- (void)touchesEndedWithSlider:(PtFtViewLayerStrengthSlider*)slider;
@end

@interface PtFtViewLayerStrengthSlider : UIView <PtFtViewSliderDelegate>
{
    float _paddingLeft;
}

@property (nonatomic, strong) PtFtViewSlider* sliderView;
@property (nonatomic, weak) PtFtButtonLayerBar* button;
@property (nonatomic, assign) CGFloat value;
@property (nonatomic, assign) CGFloat defaultValue;
@property (nonatomic, assign) CGFloat alpha;
@property (nonatomic, weak) id<PtFtViewLayerStrengthSliderDelegate> delegate;
@property (nonatomic, strong) NSString* title;
@property (nonatomic, assign) BOOL locked;
@property (nonatomic, assign) VnEffectGroup effectGroup;

@property (nonatomic, strong) UIColor* sliderStrokeColor;
@property (nonatomic, strong) UIColor* sliderBgColor;
@property (nonatomic, strong) UIColor* sliderThumbColor;

@end
