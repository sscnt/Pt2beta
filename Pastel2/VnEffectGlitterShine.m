//
//  VnEffectGlitterShine.m
//  Pastel2
//
//  Created by SSC on 2014/06/11.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectGlitterShine.h"

@implementation VnEffectGlitterShine

- (id)init
{
    self = [super init];
    if(self){
        self.effectId = VnEffectIdGlitterShine;
    }
    return self;
}

- (void)makeFilterGroup
{
    VnFilterBrightness* brightnessFilter = [[VnFilterBrightness alloc] init];
    brightnessFilter.brightness = -0.2f;
    
    // Hue/Saturation
    VnAdjustmentLayerHueSaturation* hueSaturation = [[VnAdjustmentLayerHueSaturation alloc] init];
    hueSaturation.hue = 0.0f;
    hueSaturation.saturation = 2.0f;
    hueSaturation.lightness = 0.0f;
    hueSaturation.colorize = NO;
    
    // Selective Color
    VnAdjustmentLayerSelectiveColor* selectiveColor1 = [[VnAdjustmentLayerSelectiveColor alloc] init];
    [selectiveColor1 setRedsCyan:18 Magenta:0 Yellow:0 Black:0];
    [selectiveColor1 setYellowsCyan:-4 Magenta:0 Yellow:15 Black:2];
    [selectiveColor1 setGreensCyan:16 Magenta:0 Yellow:7 Black:21];
    [selectiveColor1 setBluesCyan:0 Magenta:2 Yellow:100 Black:3];
    [selectiveColor1 setBlacksCyan:-4 Magenta:6 Yellow:16 Black:12];
    
    // Selective Color
    VnAdjustmentLayerSelectiveColor* selectiveColor2 = [[VnAdjustmentLayerSelectiveColor alloc] init];
    [selectiveColor2 setRedsCyan:9 Magenta:8 Yellow:13 Black:40];
    [selectiveColor2 setYellowsCyan:0 Magenta:0 Yellow:0 Black:43];
    [selectiveColor2 setGreensCyan:0 Magenta:0 Yellow:7 Black:29];
    [selectiveColor2 setBluesCyan:0 Magenta:0 Yellow:0 Black:15];
    [selectiveColor2 setBlacksCyan:3 Magenta:16 Yellow:0 Black:43];
    
    // Curve
    VnFilterToneCurve* curveFilter1 = [[VnFilterToneCurve alloc] initWithACV:@"bd001"];
    curveFilter1.topLayerOpacity = 0.80f;
    
    // Contrast
    VnFilterLevels* levelsFilter1 = [[VnFilterLevels alloc] init];
    [levelsFilter1 setMin:s255(35.0f) gamma:1.14 max:s255(246.0f) minOut:s255(0.0f) maxOut:s255(255.0f)];
    levelsFilter1.topLayerOpacity = 0.20f;
    levelsFilter1.blendingMode = VnBlendingModeLuminotisy;
    
    // Curve
    VnFilterToneCurve* curveFilter2 = [[VnFilterToneCurve alloc] initWithACV:@"bd002"];
    
    // Curve
    VnFilterToneCurve* curveFilter3 = [[VnFilterToneCurve alloc] initWithACV:@"bd003"];

    self.startFilter = brightnessFilter;
    [brightnessFilter addTarget:hueSaturation];
    [hueSaturation addTarget:selectiveColor1];
    [selectiveColor1 addTarget:selectiveColor2];
    [selectiveColor2 addTarget:curveFilter1];
    [curveFilter1 addTarget:levelsFilter1];
    [levelsFilter1 addTarget:curveFilter2];
    [curveFilter2 addTarget:curveFilter3];
    self.endFilter = curveFilter3;
}
@end
