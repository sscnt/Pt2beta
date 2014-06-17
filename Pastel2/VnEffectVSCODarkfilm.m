//
//  VnEffectVSCODarkfilm.m
//  Pastel2
//
//  Created by SSC on 2014/06/15.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectVSCODarkfilm.h"

@implementation VnEffectVSCODarkfilm

- (id)init
{
    self = [super init];
    if(self){
        self.effectId = VnEffectIdVSCODarkfilm;
    }
    return self;
}

- (void)makeFilterGroup
{
    
    // Exposure
    VnFilterExposure* expFilter = [[VnFilterExposure alloc] init];
    expFilter.exposure = -0.66f;
    expFilter.offset = 0.0026;
    expFilter.gamma = 1.15f;
    
    // Hue / Saturation
    VnAdjustmentLayerHueSaturation* hueSaturation = [[VnAdjustmentLayerHueSaturation alloc] init];
    hueSaturation.hue = 0.0f;
    hueSaturation.saturation = 10;
    hueSaturation.lightness = 0.0f;
    hueSaturation.colorize = NO;
    
    // Selective Color
    VnAdjustmentLayerSelectiveColor* selectiveColor1 = [[VnAdjustmentLayerSelectiveColor alloc] init];
    [selectiveColor1 setRedsCyan:18 Magenta:0 Yellow:0 Black:0];
    [selectiveColor1 setYellowsCyan:-3 Magenta:0 Yellow:15 Black:2];
    [selectiveColor1 setGreensCyan:16 Magenta:0 Yellow:7 Black:21];
    [selectiveColor1 setBluesCyan:0 Magenta:2 Yellow:31 Black:3];
    [selectiveColor1 setBlacksCyan:-3 Magenta:6 Yellow:16 Black:12];
    
    // Selective Color
    VnAdjustmentLayerSelectiveColor* selectiveColor2 = [[VnAdjustmentLayerSelectiveColor alloc] init];
    [selectiveColor2 setRedsCyan:9 Magenta:8 Yellow:13 Black:40];
    [selectiveColor2 setYellowsCyan:0 Magenta:0 Yellow:0 Black:43];
    [selectiveColor2 setGreensCyan:0 Magenta:0 Yellow:0 Black:29];
    [selectiveColor2 setBluesCyan:0 Magenta:0 Yellow:0 Black:15];
    [selectiveColor2 setBlacksCyan:3 Magenta:16 Yellow:0 Black:53];
    
    // Curve
    VnFilterToneCurve* curveFilter1 = [[VnFilterToneCurve alloc] initWithACV:@"ch001"];
    curveFilter1.topLayerOpacity = 0.8f;
    
    // Fill Layer
    VnFilterSolidColor* solidColor2 = [[VnFilterSolidColor alloc] init];
    [solidColor2 setColorRed:64.0f/255.0f green:64.0f/255.0f blue:64.0f/255.0 alpha:1.0f];
    solidColor2.topLayerOpacity = 0.50f;
    solidColor2.blendingMode = VnBlendingModeLighten;
    
    // Cntrast
    VnFilterLevels* levelsFilter1 = [[VnFilterLevels alloc] init];
    [levelsFilter1 setMin:s255(35.0f) gamma:1.14f max:s255(245.0f) minOut:s255(0.0f) maxOut:s255(255.0f)];
    levelsFilter1.topLayerOpacity = 0.30f;
    levelsFilter1.blendingMode = VnBlendingModeLuminotisy;
    
    // Curve
    VnFilterToneCurve* curveFilter2 = [[VnFilterToneCurve alloc] initWithACV:@"ch002"];
    curveFilter2.topLayerOpacity = 0.70f;
    
    self.startFilter = expFilter;
    [expFilter addTarget:hueSaturation];
    [hueSaturation addTarget:selectiveColor1];
    [selectiveColor1 addTarget:selectiveColor2];
    [selectiveColor2 addTarget:curveFilter1];
    [curveFilter1 addTarget:levelsFilter1];
    [levelsFilter1 addTarget:curveFilter2];
    self.endFilter = curveFilter2;
}

@end
