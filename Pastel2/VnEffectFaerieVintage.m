//
//  GPUEffectFaerieVintage.m
//  Gravy_1.0
//
//  Created by SSC on 2013/12/15.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "VnEffectFaerieVintage.h"

@implementation VnEffectFaerieVintage

- (id)init
{
    self = [super init];
    if(self){
        self.effectId = VnEffectIdFaerieVintage;
    }
    return self;
}

- (void)makeFilterGroup
{
    
    // Fill Layer
    VnFilterSolidColor* solidColor1 = [[VnFilterSolidColor alloc] init];
    [solidColor1 setColorRed:114.0f/255.0f green:87.0f/255.0f blue:71.0f/255.0 alpha:1.0f];
    solidColor1.topLayerOpacity = 0.35f;
    solidColor1.blendingMode = VnBlendingModeColor;
    
    // Fill Layer
    VnFilterSolidColor* solidColor2 = [[VnFilterSolidColor alloc] init];
    [solidColor2 setColorRed:202.0f/255.0f green:179.0f/255.0f blue:154.0f/255.0 alpha:1.0f];
    solidColor2.topLayerOpacity = 0.10f;
    solidColor2.blendingMode = VnBlendingModeSoftLight;
    
    // Curve
    VnFilterPassThrough* curveInput = [[VnFilterPassThrough alloc] init];
    VnImageNormalBlendFilter* curveMerge = [[VnImageNormalBlendFilter alloc] init];
    VnFilterToneCurve* curveFilter1 = [[VnFilterToneCurve alloc] initWithACV:@"fv1"];
    curveMerge.topLayerOpacity = 0.40f;
    
    // Selective Color
    VnAdjustmentLayerSelectiveColor* selectiveColor1 = [[VnAdjustmentLayerSelectiveColor alloc] init];
    [selectiveColor1 setRedsCyan:1 Magenta:0 Yellow:44 Black:0];
    [selectiveColor1 setYellowsCyan:11 Magenta:8 Yellow:100 Black:0];
    [selectiveColor1 setCyansCyan:0 Magenta:0 Yellow:-1 Black:0];
    [selectiveColor1 setMagentasCyan:0 Magenta:0 Yellow:100 Black:0];
    [selectiveColor1 setWhitesCyan:0 Magenta:0 Yellow:-100 Black:0];
    [selectiveColor1 setNeutralsCyan:0 Magenta:0 Yellow:-80 Black:0];
    
    // Channel Mixer
    VnAdjustmentLayerChannelMixerFilter* mixerFilter1 = [[VnAdjustmentLayerChannelMixerFilter alloc] init];
    [mixerFilter1 setRedChannelRed:100 Green:0 Blue:0 Constant:0];
    [mixerFilter1 setGreenChannelRed:0 Green:100 Blue:0 Constant:0];
    [mixerFilter1 setBlueChannelRed:14 Green:14 Blue:72 Constant:0];
    
    // Color Balance
    VnAdjustmentLayerColorBalance* colorBalance1 = [[VnAdjustmentLayerColorBalance alloc] init];
    GPUVector3 shadows;
    shadows.one = -4.0f/255.0f;
    shadows.two = 0.0f/255.0f;
    shadows.three = 10.0f/255.0f;
    [colorBalance1 setShadows:shadows];
    GPUVector3 midtones;
    midtones.one = -6.0f/255.0f;
    midtones.two = -5.0f/255.0f;
    midtones.three = -26.0f/255.0f;
    [colorBalance1 setMidtones:midtones];
    GPUVector3 highlights;
    highlights.one = 0.0f/255.0f;
    highlights.two = -9.0f/255.0f;
    highlights.three = -15.0f/255.0f;
    [colorBalance1 setHighlights:highlights];
    colorBalance1.preserveLuminosity = YES;
    
    // Curve
    VnFilterToneCurve* curveFilter2 = [[VnFilterToneCurve alloc] initWithACV:@"fv2"];
    
    // Channel Mixer
    VnAdjustmentLayerChannelMixerFilter* mixerFilter2 = [[VnAdjustmentLayerChannelMixerFilter alloc] init];
    [mixerFilter2 setRedChannelRed:114.0f Green:12.0f Blue:-28.0f Constant:2];
    [mixerFilter2 setGreenChannelRed:4.0f Green:92.0f Blue:2.0f Constant:0];
    [mixerFilter2 setBlueChannelRed:-2.0f Green:-8.0f Blue:104.0f Constant:0];
    mixerFilter2.topLayerOpacity = 0.80f;
    
    // Fill Layer
    VnFilterSolidColor* solidColor3 = [[VnFilterSolidColor alloc] init];
    [solidColor3 setColorRed:255.0f/255.0f green:247.0f/255.0f blue:182.0f/255.0 alpha:1.0f];
    solidColor3.topLayerOpacity = 0.30f;
    solidColor3.blendingMode = VnBlendingModeDarken;
    
    // Fill Layer
    VnFilterSolidColor* solidColor4 = [[VnFilterSolidColor alloc] init];
    [solidColor4 setColorRed:0.0f/255.0f green:12.0f/255.0f blue:71.0f/255.0 alpha:1.0f];
    solidColor4.topLayerOpacity = 0.27f;
    solidColor4.blendingMode = VnBlendingModeExclusion;
    
    self.startFilter = solidColor1;
    [solidColor1 addTarget:solidColor2];
    [solidColor2 addTarget:curveInput];
    [curveInput addTarget:curveMerge];
    [curveInput addTarget:curveFilter1];
    [curveFilter1 addTarget:curveMerge atTextureLocation:1];
    [curveMerge addTarget:selectiveColor1];
    [selectiveColor1 addTarget:mixerFilter1];
    [mixerFilter1 addTarget:colorBalance1];
    [colorBalance1 addTarget:curveFilter2];
    [curveFilter2 addTarget:mixerFilter2];
    [mixerFilter2 addTarget:solidColor3];
    [solidColor3 addTarget:solidColor4];
    self.endFilter = solidColor4;
}

@end
