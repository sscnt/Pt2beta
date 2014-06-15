//
//  VnEffectVSCOMemory.m
//  Pastel2
//
//  Created by SSC on 2014/06/15.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectVSCOMemory.h"

@implementation VnEffectVSCOMemory

- (id)init
{
    self = [super init];
    if(self){
        self.effectId = VnEffectIdVSCOMemory;
    }
    return self;
}

- (void)makeFilterGroup
{
    // Curve
    VnFilterToneCurve* curveFilter1 = [[VnFilterToneCurve alloc] initWithACV:@"ce001"];
    
    // Cntrast
    VnFilterLevels* levelsFilter1 = [[VnFilterLevels alloc] init];
    [levelsFilter1 setMin:s255(35.0f) gamma:1.14f max:s255(245.0f) minOut:s255(0.0f) maxOut:s255(255.0f)];
    levelsFilter1.topLayerOpacity = 0.50f;
    levelsFilter1.blendingMode = VnBlendingModeLuminotisy;
    
    // Hue / Saturation
    VnAdjustmentLayerHueSaturation* hueSaturation = [[VnAdjustmentLayerHueSaturation alloc] init];
    hueSaturation.hue = 0.0f;
    hueSaturation.saturation = 5.0f;
    hueSaturation.lightness = 0.0f;
    hueSaturation.colorize = NO;
    
    // Selective Color
    VnAdjustmentLayerSelectiveColor* selectiveColor1 = [[VnAdjustmentLayerSelectiveColor alloc] init];
    [selectiveColor1 setYellowsCyan:0 Magenta:70 Yellow:20 Black:0];
    [selectiveColor1 setGreensCyan:0 Magenta:0 Yellow:49 Black:100];
    [selectiveColor1 setBluesCyan:0 Magenta:0 Yellow:0 Black:30];
    [selectiveColor1 setBlacksCyan:0 Magenta:0 Yellow:0 Black:25];
    
    // Curve
    VnFilterToneCurve* curveFilter2 = [[VnFilterToneCurve alloc] initWithACV:@"ce002"];
    curveFilter2.topLayerOpacity = 0.50f;
    
    // Curve
    VnFilterToneCurve* curveFilter3 = [[VnFilterToneCurve alloc] initWithACV:@"ce003"];
    curveFilter3.topLayerOpacity = 0.50f;
    
    
    self.startFilter = curveFilter1;
    [curveFilter1 addTarget:levelsFilter1];
    [levelsFilter1 addTarget:hueSaturation];
    [hueSaturation addTarget:selectiveColor1];
    [selectiveColor1 addTarget:curveFilter2];
    [curveFilter2 addTarget:curveFilter3];
    self.endFilter = curveFilter3;
}

@end
