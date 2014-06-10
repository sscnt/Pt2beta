//
//  GPUEffectDreamyCreamy.m
//  Vintage
//
//  Created by SSC on 2014/04/01.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectDreamyCreamy.h"

@implementation VnEffectDreamyCreamy

- (id)init
{
    self = [super init];
    if(self){
        self.defaultOpacity = 1.0f;
        self.faceOpacity = 0.80f;
        self.effectId = VnEffectIdDreamyCreamy;
    }
    return self;
}

- (void)makeFilterGroup
{
    // Curve
    VnFilterToneCurve* curveFilter1 = [[VnFilterToneCurve alloc] initWithACV:@"dc1"];
    
    // Channel Mixer
    VnAdjustmentLayerChannelMixerFilter* mixerFilter1 = [[VnAdjustmentLayerChannelMixerFilter alloc] init];
    [mixerFilter1 setRedChannelRed:100 Green:0 Blue:0 Constant:0];
    [mixerFilter1 setGreenChannelRed:0 Green:100 Blue:0 Constant:0];
    [mixerFilter1 setBlueChannelRed:12 Green:0 Blue:64 Constant:0];
    
    // Channel Mixer
    VnAdjustmentLayerChannelMixerFilter* mixerFilter2 = [[VnAdjustmentLayerChannelMixerFilter alloc] init];
    [mixerFilter2 setRedChannelRed:100 Green:0 Blue:0 Constant:0];
    [mixerFilter2 setGreenChannelRed:0 Green:100 Blue:0 Constant:0];
    [mixerFilter2 setBlueChannelRed:-10 Green:26 Blue:102 Constant:0];
    
    
    self.startFilter = curveFilter1;
    [curveFilter1 addTarget:mixerFilter1];
    [mixerFilter1 addTarget:mixerFilter2];
    self.endFilter = mixerFilter2;
    return;
    
    // Curve
    VnFilterPassThrough* curveInput = [[VnFilterPassThrough alloc] init];
    VnImageNormalBlendFilter* curveMerge = [[VnImageNormalBlendFilter alloc] init];
    VnFilterToneCurve* curveFilter2 = [[VnFilterToneCurve alloc] initWithACV:@"dc2"];
    curveMerge.topLayerOpacity = 0.20f;
    
    // Fill Layer
    VnFilterSolidColor* solidColor1 = [[VnFilterSolidColor alloc] init];
    [solidColor1 setColorRed:243.0f/255.0f green:211.0f/255.0f blue:57.0f/255.0 alpha:1.0f];
    solidColor1.topLayerOpacity = 0.05f;
    solidColor1.blendingMode = VnBlendingModeColor;
    
    
    // Color Balance
    VnAdjustmentLayerColorBalance* colorBalance1 = [[VnAdjustmentLayerColorBalance alloc] init];
    GPUVector3 shadows1;
    shadows1.one = 0.0f/255.0f;
    shadows1.two = 2.0f/255.0f;
    shadows1.three = 5.0f/255.0f;
    [colorBalance1 setShadows:shadows1];
    GPUVector3 midtones1;
    midtones1.one = 0.0f/255.0f;
    midtones1.two = -1.0f/255.0f;
    midtones1.three = 3.0f/255.0f;
    [colorBalance1 setMidtones:midtones1];
    GPUVector3 highlights1;
    highlights1.one = 11.0f/255.0f;
    highlights1.two = 0.0/255.0f;
    highlights1.three = 10.0f/255.0f;
    [colorBalance1 setHighlights:highlights1];
    colorBalance1.preserveLuminosity = YES;
    
    
    // Selective Color
    VnAdjustmentLayerSelectiveColor* selectiveColor1 = [[VnAdjustmentLayerSelectiveColor alloc] init];
    [selectiveColor1 setRedsCyan:14 Magenta:0 Yellow:15 Black:0];
    [selectiveColor1 setYellowsCyan:-3 Magenta:4 Yellow:-11 Black:0];
    
    
    
    // Selective Color
    VnAdjustmentLayerSelectiveColor* selectiveColor2 = [[VnAdjustmentLayerSelectiveColor alloc] init];
    [selectiveColor2 setRedsCyan:50 Magenta:8 Yellow:9 Black:0];
    [selectiveColor2 setYellowsCyan:13 Magenta:-8 Yellow:-6 Black:0];
    
    
    // Color Balance
    VnAdjustmentLayerColorBalance* colorBalance2 = [[VnAdjustmentLayerColorBalance alloc] init];
    GPUVector3 shadows2;
    shadows2.one = -7.0f/255.0f;
    shadows2.two = -7.0f/255.0f;
    shadows2.three = 9.0f/255.0f;
    [colorBalance2 setShadows:shadows2];
    GPUVector3 midtones2;
    midtones2.one = 4.0f/255.0f;
    midtones2.two = 2.0f/255.0f;
    midtones2.three = 10.0f/255.0f;
    [colorBalance2 setMidtones:midtones2];
    GPUVector3 highlights2;
    highlights2.one = -1.0f/255.0f;
    highlights2.two = 3.0/255.0f;
    highlights2.three = -13.0f/255.0f;
    [colorBalance2 setHighlights:highlights2];
    colorBalance2.preserveLuminosity = YES;
    
    
    // Curve
    VnFilterToneCurve* curveFilter3 = [[VnFilterToneCurve alloc] initWithACV:@"dc3"];
    
    
    // Color Balance
    VnAdjustmentLayerColorBalance* colorBalance3 = [[VnAdjustmentLayerColorBalance alloc] init];
    GPUVector3 shadows3;
    shadows3.one = 0.0f/255.0f;
    shadows3.two = 0.0f/255.0f;
    shadows3.three = 0.0f/255.0f;
    [colorBalance3 setShadows:shadows3];
    GPUVector3 midtones3;
    midtones3.one = 1.0f/255.0f;
    midtones3.two = -2.0f/255.0f;
    midtones3.three = 8.0f/255.0f;
    [colorBalance3 setMidtones:midtones3];
    GPUVector3 highlights3;
    highlights3.one = -10.0f/255.0f;
    highlights3.two = -2.0/255.0f;
    highlights3.three = -6.0f/255.0f;
    [colorBalance3 setHighlights:highlights3];
    colorBalance3.preserveLuminosity = YES;
    
    
    // duplicate
    VnFilterDuplicate* duplicateFilter = [[VnFilterDuplicate alloc] init];
    duplicateFilter.topLayerOpacity = 0.50f;
    duplicateFilter.blendingMode = VnBlendingModeSoftLight;
    
    self.startFilter = curveFilter1;
    [curveFilter1 addTarget:mixerFilter1];
    [mixerFilter1 addTarget:mixerFilter2];
    [mixerFilter2 addTarget:curveInput];
    [curveInput addTarget:curveMerge];
    [curveInput addTarget:curveFilter2];
    [curveFilter2 addTarget:curveMerge atTextureLocation:1];
    [curveMerge addTarget:solidColor1];
    [solidColor1 addTarget:colorBalance1];
    [colorBalance1 addTarget:selectiveColor1];
    [selectiveColor1 addTarget:selectiveColor2];
    [selectiveColor2 addTarget:colorBalance2];
    [colorBalance2 addTarget:curveFilter3];
    [curveFilter3 addTarget:colorBalance3];
    [colorBalance3 addTarget:duplicateFilter];
    self.endFilter = duplicateFilter;
}

@end
