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
    
    // Curve
    VnFilterPassThrough* curveInput = [[VnFilterPassThrough alloc] init];
    VnImageNormalBlendFilter* curveMerge = [[VnImageNormalBlendFilter alloc] init];
    VnFilterToneCurve* curveFilter2 = [[VnFilterToneCurve alloc] initWithACV:@"dc2"];
    curveMerge.topLayerOpacity = 0.20f;
    
    // Fill Layer
    VnFilterSolidColor* solidColor1 = [[VnFilterSolidColor alloc] init];
    [solidColor1 setColorRed:243.0f/255.0f green:211.0f/255.0f blue:57.0f/255.0 alpha:1.0f];
    solidColor1.topLayerOpacity = 0.10f;
    solidColor1.blendingMode = VnBlendingModeColor;
    
    
    // Selective Color
    VnAdjustmentLayerSelectiveColor* selectiveColor1 = [[VnAdjustmentLayerSelectiveColor alloc] init];
    [selectiveColor1 setRedsCyan:14 Magenta:0 Yellow:15 Black:0];
    [selectiveColor1 setYellowsCyan:-3 Magenta:4 Yellow:-11 Black:0];
    
    
    // Selective Color
    VnAdjustmentLayerSelectiveColor* selectiveColor2 = [[VnAdjustmentLayerSelectiveColor alloc] init];
    [selectiveColor2 setRedsCyan:50 Magenta:8 Yellow:9 Black:0];
    [selectiveColor2 setYellowsCyan:13 Magenta:-8 Yellow:-6 Black:0];
    
    // Color Balance
    VnAdjustmentLayerColorBalance* colorBalance1 = [[VnAdjustmentLayerColorBalance alloc] init];
    GPUVector3 shadows1;
    shadows1.one = -7.0f/255.0f;
    shadows1.two = -7.0f/255.0f;
    shadows1.three = 9.0f/255.0f;
    [colorBalance1 setShadows:shadows1];
    GPUVector3 midtones1;
    midtones1.one = 4.0f/255.0f;
    midtones1.two = 2.0f/255.0f;
    midtones1.three = 10.0f/255.0f;
    [colorBalance1 setMidtones:midtones1];
    GPUVector3 highlights1;
    highlights1.one = -1.0f/255.0f;
    highlights1.two = 3.0/255.0f;
    highlights1.three = -13.0f/255.0f;
    [colorBalance1 setHighlights:highlights1];
    colorBalance1.preserveLuminosity = YES;
    
    
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
    
    
    // Channel Mixer
    VnAdjustmentLayerChannelMixerFilter* mixerFilter3 = [[VnAdjustmentLayerChannelMixerFilter alloc] init];
    [mixerFilter3 setRedChannelRed:106 Green:-18 Blue:12 Constant:0];
    [mixerFilter3 setGreenChannelRed:0 Green:100 Blue:0 Constant:0];
    [mixerFilter3 setBlueChannelRed:-22 Green:18 Blue:98 Constant:0];
    
    
    // Fill Layer
    VnAdjustmentLayerGradientColorFill* gradientColor2 = [[VnAdjustmentLayerGradientColorFill alloc] initWithEffectObj:self];
    [gradientColor2 setStyle:GradientStyleRadial];
    [gradientColor2 setAngleDegree:0.0f];
    [gradientColor2 setScalePercent:150];
    [gradientColor2 setOffsetX:0.0f Y:0.0f];
    [gradientColor2 addColorRed:12.0f Green:12.0f Blue:71.0f Opacity:0.0f Location:0 Midpoint:50];
    [gradientColor2 addColorRed:12.0f Green:12.0f Blue:71.0f Opacity:100.0f Location:4096 Midpoint:50];
    gradientColor2.topLayerOpacity = 0.60f;
    gradientColor2.blendingMode = VnBlendingModeSoftLight;

    self.startFilter = curveFilter1;
    [curveFilter1 addTarget:mixerFilter1];
    [mixerFilter1 addTarget:mixerFilter2];
    [mixerFilter2 addTarget:curveInput];
    [curveInput addTarget:curveMerge];
    [curveInput addTarget:curveFilter2];
    [curveFilter2 addTarget:curveMerge atTextureLocation:1];
    [curveMerge addTarget:solidColor1];
    [solidColor1 addTarget:selectiveColor1];
    [selectiveColor1 addTarget:selectiveColor2];
    [selectiveColor2 addTarget:colorBalance1];
    [colorBalance1 addTarget:curveFilter3];
    [curveFilter3 addTarget:colorBalance3];
    [colorBalance3 addTarget:mixerFilter3];
    [mixerFilter3 addTarget:gradientColor2];
    self.endFilter = gradientColor2;
}

@end
