//
//  VnEffectAmelia.m
//  Pastel2
//
//  Created by SSC on 2014/06/17.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectAmelia.h"

@implementation VnEffectAmelia

- (id)init
{
    self = [super init];
    if(self){
        self.defaultOpacity = 0.80f;
        self.effectId = VnEffectIdAmeria;
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
    
    // Photo Filter
    VnAdjustmentLayerPhotoFilter* photoFilter = [[VnAdjustmentLayerPhotoFilter alloc] init];
    photoFilter.color = (GPUVector3){s255(210.0f), s255(126.0f), s255(34.0f)};
    photoFilter.density = 0.03f;
    photoFilter.preserveLuminosity = YES;
    
    // Fill Layer
    VnFilterSolidColor* solidColor1 = [[VnFilterSolidColor alloc] init];
    [solidColor1 setColorRed:153.0f/255.0f green:156.0f/255.0f blue:120.0f/255.0 alpha:1.0f];
    solidColor1.topLayerOpacity = 0.10f;
    
    // Levels
    VnFilterLevels* levelsFilter1 = [[VnFilterLevels alloc] init];
    [levelsFilter1 setMin:s255(0.0f) gamma:0.91f max:s255(255.0f) minOut:s255(0.0f) maxOut:s255(255.0f)];
    
    // Curve
    VnFilterToneCurve* curveFilter1 = [[VnFilterToneCurve alloc] initWithACV:@"cj001"];
    curveFilter1.topLayerOpacity = 0.20f;
    
    // Selective Color
    VnAdjustmentLayerSelectiveColor* selectiveColor1 = [[VnAdjustmentLayerSelectiveColor alloc] init];
    [selectiveColor1 setYellowsCyan:0 Magenta:75 Yellow:25 Black:0];
    [selectiveColor1 setGreensCyan:8 Magenta:0 Yellow:50 Black:100];
    [selectiveColor1 setBluesCyan:0 Magenta:0 Yellow:0 Black:25];
    [selectiveColor1 setBlacksCyan:0 Magenta:0 Yellow:0 Black:10];
    
    // Fill Layer
    VnFilterSolidColor* solidColor2 = [[VnFilterSolidColor alloc] init];
    [solidColor2 setColorRed:64.0f/255.0f green:82.0f/255.0f blue:103.0f/255.0 alpha:1.0f];
    solidColor2.topLayerOpacity = 0.50f;
    solidColor2.blendingMode = VnBlendingModeLighten;
    
    // Fill Layer
    VnFilterSolidColor* solidColor3 = [[VnFilterSolidColor alloc] init];
    [solidColor3 setColorRed:97.0f/255.0f green:79.0f/255.0f blue:119.0f/255.0 alpha:1.0f];
    solidColor3.topLayerOpacity = 0.50f;
    solidColor3.blendingMode = VnBlendingModeLighten;
    
    self.startFilter = mixerFilter;
    [mixerFilter addTarget:photoFilter];
    [photoFilter addTarget:solidColor1];
    [solidColor1 addTarget:levelsFilter1];
    [levelsFilter1 addTarget:curveFilter1];
    [curveFilter1 addTarget:selectiveColor1];
    [selectiveColor1 addTarget:solidColor2];
    [solidColor2 addTarget:solidColor3];
    self.endFilter = solidColor3;
}

@end
