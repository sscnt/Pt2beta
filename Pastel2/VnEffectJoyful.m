//
//  GPUEffectJoyful.m
//  Gravy_1.0
//
//  Created by SSC on 2013/11/30.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "VnEffectJoyful.h"

@implementation VnEffectJoyful

- (id)init
{
    self = [super init];
    if(self){
        self.defaultOpacity = 1.0f;
        self.faceOpacity = 0.80f;
        self.effectId = VnEffectIdJoyful;
    }
    return self;
}

- (void)makeFilterGroup
{
    
    // Curve
    VnFilterPassThrough* curveInput = [[VnFilterPassThrough alloc] init];
    VnImageNormalBlendFilter* curveMerge = [[VnImageNormalBlendFilter alloc] init];
    VnFilterToneCurve* curveFilter1 = [[VnFilterToneCurve alloc] initWithACV:@"jf1"];
    curveMerge.topLayerOpacity = 0.40f;
    
    
    // Fill Layer
    VnAdjustmentLayerGradientColorFill* gradientColor1 = [[VnAdjustmentLayerGradientColorFill alloc] init];
    [gradientColor1 forceProcessingAtSize:self.imageSize];
    [gradientColor1 setStyle:GradientStyleLinear];
    [gradientColor1 setAngleDegree:-135];
    [gradientColor1 setScalePercent:150];
    [gradientColor1 setOffsetX:0.0f Y:0.0f];
    [gradientColor1 addColorRed:239.0f Green:219.0f Blue:205.0f Opacity:100.0f Location:0 Midpoint:60];
    [gradientColor1 addColorRed:251.0f Green:216.0f Blue:197.0f Opacity:100.0f Location:1229 Midpoint:50];
    [gradientColor1 addColorRed:108.0f Green:46.0f Blue:22.0f Opacity:100.0f Location:4096 Midpoint:50];
    gradientColor1.topLayerOpacity = 0.50f;
    gradientColor1.blendingMode = VnBlendingModeSoftLight;
    gradientColor1.addingX = self.addingX;
    gradientColor1.addingY = self.addingY;
    gradientColor1.multiplierX = self.multiplierX;
    gradientColor1.multiplierY = self.multiplierY;
    
    
    // Selective Color
    VnAdjustmentLayerSelectiveColor* selectiveColor1 = [[VnAdjustmentLayerSelectiveColor alloc] init];
    [selectiveColor1 setRedsCyan:17 Magenta:2 Yellow:4 Black:0];
    [selectiveColor1 setYellowsCyan:-8 Magenta:18 Yellow:3 Black:0];
    
    
    
    // Channel Mixer
    VnAdjustmentLayerChannelMixerFilter* mixerFilter1 = [[VnAdjustmentLayerChannelMixerFilter alloc] init];
    [mixerFilter1 setRedChannelRed:100 Green:0 Blue:0 Constant:0];
    [mixerFilter1 setGreenChannelRed:0 Green:100 Blue:0 Constant:0];
    [mixerFilter1 setBlueChannelRed:14 Green:14 Blue:72 Constant:0];
    
    // Fill Layer
    VnFilterSolidColor* solidColor1 = [[VnFilterSolidColor alloc] init];
    [solidColor1 setColorRed:66.0f/255.0f green:52.0f/255.0f blue:125.0f/255.0 alpha:1.0f];
    solidColor1.topLayerOpacity = 0.05f;
    solidColor1.blendingMode = VnBlendingModeHardLight;
    
    
    // Fill Layer
    VnFilterSolidColor* solidColor2 = [[VnFilterSolidColor alloc] init];
    [solidColor2 setColorRed:148.0f/255.0f green:111.0f/255.0f blue:102.0f/255.0 alpha:1.0f];
    solidColor2.topLayerOpacity = 0.10f;
    solidColor2.blendingMode = VnBlendingModeHue;
    
    
    // Color Balance
    VnAdjustmentLayerColorBalance* colorBalance1 = [[VnAdjustmentLayerColorBalance alloc] init];
    GPUVector3 shadows1;
    shadows1.one = 0.0f;
    shadows1.two = 0.0f/255.0f;
    shadows1.three = 0.0f/255.0f;
    [colorBalance1 setShadows:shadows1];
    GPUVector3 midtones1;
    midtones1.one = 20.0f/255.0f;
    midtones1.two = -5.0f/255.0f;
    midtones1.three = -19.0f/255.0f;
    [colorBalance1 setMidtones:midtones1];
    GPUVector3 highlights1;
    highlights1.one = -10.0f/255.0f;
    highlights1.two = -7.0f/255.0f;
    highlights1.three = -3.0f/155.0f;
    [colorBalance1 setHighlights:highlights1];
    colorBalance1.preserveLuminosity = YES;
    
    
    
    // Curve
    VnFilterToneCurve* curveFilter2 = [[VnFilterToneCurve alloc] initWithACV:@"jf2"];
    
    // Channel Mixer
    VnAdjustmentLayerChannelMixerFilter* mixerFilter2 = [[VnAdjustmentLayerChannelMixerFilter alloc] init];
    [mixerFilter2 setRedChannelRed:114 Green:12 Blue:-28 Constant:0];
    [mixerFilter2 setGreenChannelRed:4 Green:92 Blue:2 Constant:0];
    [mixerFilter2 setBlueChannelRed:-2 Green:-8 Blue:104 Constant:0];
    
    
    // Fill Layer
    VnFilterSolidColor* solidColor3 = [[VnFilterSolidColor alloc] init];
    [solidColor3 setColorRed:255.0f/255.0f green:239.0f/255.0f blue:107.0f/255.0 alpha:1.0f];
    solidColor3.topLayerOpacity = 0.30f;
    solidColor3.blendingMode = VnBlendingModeDarken;
    
    
    // Fill Layer
    VnAdjustmentLayerGradientColorFill* gradientColor2 = [[VnAdjustmentLayerGradientColorFill alloc] init];
    [gradientColor2 forceProcessingAtSize:self.imageSize];
    [gradientColor2 setStyle:GradientStyleRadial];
    [gradientColor2 setAngleDegree:90];
    [gradientColor2 setScalePercent:150];
    [gradientColor2 setOffsetX:12.5f Y:-28.8f];
    [gradientColor2 addColorRed:255.0f Green:238.0f Blue:127.0f Opacity:100.0f Location:0 Midpoint:50];
    [gradientColor2 addColorRed:255.0f Green:238.0f Blue:127.0f Opacity:0.0f Location:4096 Midpoint:50];
    gradientColor2.topLayerOpacity = 0.30f;
    gradientColor2.blendingMode = VnBlendingModeOverlay;
    gradientColor2.addingX = self.addingX;
    gradientColor2.addingY = self.addingY;
    gradientColor2.multiplierX = self.multiplierX;
    gradientColor2.multiplierY = self.multiplierY;
    
    
    // Fill Layer
    VnAdjustmentLayerGradientColorFill* gradientColor3 = [[VnAdjustmentLayerGradientColorFill alloc] init];
    [gradientColor3 forceProcessingAtSize:self.imageSize];
    [gradientColor3 setStyle:GradientStyleRadial];
    [gradientColor3 setAngleDegree:45];
    [gradientColor3 setScalePercent:150];
    [gradientColor3 setOffsetX:-4.0f Y:-7.0f];
    [gradientColor3 addColorRed:239.0f Green:229.0f Blue:64.0f Opacity:0.0f Location:0 Midpoint:50];
    [gradientColor3 addColorRed:239.0f Green:229.0f Blue:64.0f Opacity:0.0f Location:2415 Midpoint:50];
    [gradientColor3 addColorRed:239.0f Green:229.0f Blue:64.0f Opacity:100.0f Location:4096 Midpoint:50];
    gradientColor3.topLayerOpacity = 0.30f;
    gradientColor3.blendingMode = VnBlendingModeSoftLight;
    gradientColor3.addingX = self.addingX;
    gradientColor3.addingY = self.addingY;
    gradientColor3.multiplierX = self.multiplierX;
    gradientColor3.multiplierY = self.multiplierY;
    
    
    // Fill Layer
    VnFilterSolidColor* solidColor4 = [[VnFilterSolidColor alloc] init];
    [solidColor4 setColorRed:0.0f/255.0f green:12.0f/255.0f blue:71.0f/255.0 alpha:1.0f];
    solidColor4.topLayerOpacity = 0.27f;
    solidColor4.blendingMode = VnBlendingModeExclusion;
    
    self.startFilter = curveInput;
    [curveInput addTarget:curveMerge];
    [curveInput addTarget:curveFilter1];
    [curveFilter1 addTarget:curveMerge atTextureLocation:1];
    [curveMerge addTarget:gradientColor1];
    [gradientColor1 addTarget:selectiveColor1];
    [selectiveColor1 addTarget:mixerFilter1];
    [mixerFilter1 addTarget:solidColor1];
    [solidColor1 addTarget:solidColor2];
    [solidColor2 addTarget:colorBalance1];
    [colorBalance1 addTarget:curveFilter2];
    [curveFilter2 addTarget:mixerFilter2];
    [mixerFilter2 addTarget:solidColor3];
    [solidColor3 addTarget:gradientColor2];
    [gradientColor2 addTarget:gradientColor3];
    [gradientColor3 addTarget:solidColor4];
    self.endFilter = solidColor4;
}

@end
