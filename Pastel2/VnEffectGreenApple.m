//
//  VnEffectGreenApple.m
//  Pastel
//
//  Created by SSC on 2014/05/09.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectGreenApple.h"

@implementation VnEffectGreenApple

- (id)init
{
    self = [super init];
    if(self){
        self.defaultOpacity = 0.80f;
        self.faceOpacity = 0.60f;
        self.effectId = VnEffectIdGreenApple;
    }
    return self;
}

- (void)makeFilterGroup
{
    
    // Curve
    VnFilterToneCurve* curveFilter1 = [[VnFilterToneCurve alloc] initWithACV:@"bc001"];
    curveFilter1.topLayerOpacity = 0.85f;
    
    // Selective Color
    VnAdjustmentLayerSelectiveColor* selectiveColor1 = [[VnAdjustmentLayerSelectiveColor alloc] init];
    [selectiveColor1 setRedsCyan:10 Magenta:17 Yellow:24 Black:0];
    [selectiveColor1 setYellowsCyan:0 Magenta:0 Yellow:2 Black:0];
    
    
    // Channel Mixer
    VnAdjustmentLayerChannelMixerFilter* mixerFilter1 = [[VnAdjustmentLayerChannelMixerFilter alloc] init];
    [mixerFilter1 setRedChannelRed:100 Green:0 Blue:0 Constant:0];
    [mixerFilter1 setGreenChannelRed:0 Green:100 Blue:0 Constant:0];
    [mixerFilter1 setBlueChannelRed:14 Green:14 Blue:72 Constant:0];
    mixerFilter1.topLayerOpacity = 0.30f;
    
    
    // Fill Layer
    VnFilterSolidColor* solidColor1 = [[VnFilterSolidColor alloc] init];
    [solidColor1 setColorRed:93.0f/255.0f green:31.0f/255.0f blue:185.0f/255.0 alpha:1.0f];
    solidColor1.topLayerOpacity = 0.30f;
    solidColor1.blendingMode = VnBlendingModeSoftLight;
    
    
    // Fill Layer
    VnFilterSolidColor* solidColor2 = [[VnFilterSolidColor alloc] init];
    [solidColor2 setColorRed:0.0f/255.0f green:13.0f/255.0f blue:56.0f/255.0 alpha:1.0f];
    solidColor2.blendingMode = VnBlendingModeExclusion;
    
    
    // Curve
    VnFilterToneCurve* curveFilter2 = [[VnFilterToneCurve alloc] initWithACV:@"bc002"];
    curveFilter2.topLayerOpacity = 0.85f;
    
    // Selective Color
    VnAdjustmentLayerSelectiveColor* selectiveColor2 = [[VnAdjustmentLayerSelectiveColor alloc] init];
    [selectiveColor2 setRedsCyan:15 Magenta:14 Yellow:8 Black:0];
    [selectiveColor2 setMagentasCyan:-15 Magenta:20 Yellow:-11 Black:0];
    
    
    // Levels
    VnFilterLevels* levelsFilter1 = [[VnFilterLevels alloc] init];
    [levelsFilter1 setRedMin:s255(16.0f) gamma:0.62f max:s255(255.0f) minOut:s255(0.0f) maxOut:s255(255.0f)];
    [levelsFilter1 setGreenMin:s255(1.0f) gamma:1.24f max:s255(255.0f) minOut:s255(0.0f) maxOut:s255(255.0f)];
    [levelsFilter1 setBlueMin:s255(0.0f) gamma:1.05f max:s255(255.0f) minOut:s255(0.0f) maxOut:s255(255.0f)];
    
    
    // Curve
    VnFilterToneCurve* curveFilter3 = [[VnFilterToneCurve alloc] initWithACV:@"bc003"];
    curveFilter3.topLayerOpacity = 0.90f;
    
    // Curve
    VnFilterToneCurve* curveFilter4 = [[VnFilterToneCurve alloc] initWithACV:@"bc004"];
    curveFilter4.topLayerOpacity = 0.65f;
    
    self.startFilter = curveFilter1;
    [curveFilter1 addTarget:selectiveColor1];
    [selectiveColor1 addTarget:mixerFilter1];
    [mixerFilter1 addTarget:solidColor1];
    [solidColor1 addTarget:solidColor2];
    [solidColor2 addTarget:curveFilter2];
    [curveFilter2 addTarget:selectiveColor2];
    [selectiveColor2 addTarget:levelsFilter1];
    [levelsFilter1 addTarget:curveFilter3];
    [curveFilter3 addTarget:curveFilter4];
    self.endFilter = curveFilter4;
}

@end
