//
//  VnEffectElkins.m
//  Pastel2
//
//  Created by SSC on 2014/06/17.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectElkins.h"

@implementation VnEffectElkins

- (id)init
{
    self = [super init];
    if(self){
        self.effectId = VnEffectIdElkins;
    }
    return self;
}

- (void)makeFilterGroup
{
    
    // Channel Mixer
    VnAdjustmentLayerChannelMixerFilter* mixerFilter = [[VnAdjustmentLayerChannelMixerFilter alloc] init];
    mixerFilter.monochrome = YES;
    [mixerFilter setGreyChannelRed:40 Green:40 Blue:20 Constant:0];
    mixerFilter.topLayerOpacity = 0.40f;
    
    // Fill Layer
    VnFilterSolidColor* solidColor1 = [[VnFilterSolidColor alloc] init];
    [solidColor1 setColorRed:153.0f/255.0f green:156.0f/255.0f blue:120.0f/255.0 alpha:1.0f];
    solidColor1.topLayerOpacity = 0.10f;
    
    // Levels
    VnFilterLevels* levelsFilter1 = [[VnFilterLevels alloc] init];
    [levelsFilter1 setMin:s255(0.0f) gamma:0.96f max:s255(235.0f) minOut:s255(0.0f) maxOut:s255(255.0f)];
    
    // Curve
    VnFilterToneCurve* curveFilter1 = [[VnFilterToneCurve alloc] initWithACV:@"cl001"];
    curveFilter1.topLayerOpacity = 0.20f;
    
    // Selective Color
    VnAdjustmentLayerSelectiveColor* selectiveColor1 = [[VnAdjustmentLayerSelectiveColor alloc] init];
    [selectiveColor1 setYellowsCyan:0 Magenta:75 Yellow:25 Black:0];
    [selectiveColor1 setGreensCyan:8 Magenta:0 Yellow:50 Black:100];
    [selectiveColor1 setBluesCyan:0 Magenta:0 Yellow:0 Black:25];
    [selectiveColor1 setBlacksCyan:0 Magenta:0 Yellow:0 Black:10];
    
    // Exposure
    VnFilterExposure* exposureFilter = [[VnFilterExposure alloc] init];
    exposureFilter.offset = 0.1439;
    exposureFilter.gamma = 0.70f;
    
    // Photo Filter
    VnAdjustmentLayerPhotoFilter* photoFilter = [[VnAdjustmentLayerPhotoFilter alloc] init];
    photoFilter.color = (GPUVector3){s255(243.0f), s255(132.0f), s255(23.0f)};
    photoFilter.density = 0.05f;
    photoFilter.preserveLuminosity = YES;
    
    // Fill Layer
    VnFilterSolidColor* solidColor2 = [[VnFilterSolidColor alloc] init];
    [solidColor2 setColorRed:70.0f/255.0f green:78.0f/255.0f blue:65.0f/255.0 alpha:1.0f];
    solidColor2.topLayerOpacity = 0.10f;
    solidColor2.blendingMode = VnBlendingModeLighten;
    
    // Fill Layer
    VnFilterSolidColor* solidColor3 = [[VnFilterSolidColor alloc] init];
    [solidColor3 setColorRed:195.0f/255.0f green:193.0f/255.0f blue:140.0f/255.0 alpha:1.0f];
    solidColor3.topLayerOpacity = 0.30f;
    solidColor3.blendingMode = VnBlendingModeMultiply;
    
    // Fill Layer
    VnAdjustmentLayerGradientColorFill* gradientColor1 = [[VnAdjustmentLayerGradientColorFill alloc] initWithEffectObj:self];
    [gradientColor1 setStyle:GradientStyleRadial];
    [gradientColor1 setAngleDegree:90];
    [gradientColor1 setScalePercent:100];
    [gradientColor1 setOffsetX:0.0f Y:0.0f];
    [gradientColor1 addColorRed:0.0f Green:0.0f Blue:0.0f Opacity:0.0f Location:0 Midpoint:50];
    [gradientColor1 addColorRed:0.0f Green:0.0f Blue:0.0f Opacity:60.0f Location:4096 Midpoint:50];
    gradientColor1.topLayerOpacity = 0.20f;
    gradientColor1.blendingMode = VnBlendingModeVividLight;
    
    // Exposure
    VnFilterExposure* exposureFilter2 = [[VnFilterExposure alloc] init];
    exposureFilter.exposure = 0.50f;
    
    // Contrast
    VnFilterLevels* levelsFilter2 = [[VnFilterLevels alloc] init];
    [levelsFilter2 setMin:s255(35.0f) gamma:1.14 max:s255(246.0f) minOut:s255(0.0f) maxOut:s255(255.0f)];
    levelsFilter2.topLayerOpacity = 0.40f;
    levelsFilter2.blendingMode = VnBlendingModeLuminotisy;
    
    self.startFilter = mixerFilter;
    [mixerFilter addTarget:solidColor1];
    [solidColor1 addTarget:levelsFilter1];
    [levelsFilter1 addTarget:curveFilter1];
    [curveFilter1 addTarget:selectiveColor1];
    [selectiveColor1 addTarget:exposureFilter];
    [exposureFilter addTarget:photoFilter];
    [photoFilter addTarget:solidColor2];
    [solidColor2 addTarget:solidColor3];
    [solidColor3 addTarget:gradientColor1];
    [gradientColor1 addTarget:exposureFilter2];
    [exposureFilter2 addTarget:levelsFilter2];
    self.endFilter = levelsFilter2;
    
}

@end
