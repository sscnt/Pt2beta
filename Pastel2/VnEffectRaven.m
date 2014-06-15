//
//  VnEffectRaven.m
//  Pastel2
//
//  Created by SSC on 2014/06/15.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectRaven.h"

@implementation VnEffectRaven

- (id)init
{
    self = [super init];
    if(self){
        self.effectId = VnEffectIdRaven;
    }
    return self;
}

- (void)makeFilterGroup
{
    // Curve
    VnFilterToneCurve* curveFilter1 = [[VnFilterToneCurve alloc] initWithACV:@"ci001"];
    
    // Hue / Saturation
    VnAdjustmentLayerHueSaturation* hueSaturation = [[VnAdjustmentLayerHueSaturation alloc] init];
    hueSaturation.hue = 0.0f;
    hueSaturation.saturation = -25;
    hueSaturation.lightness = 0.0f;
    hueSaturation.colorize = NO;
    
    // Fill Layer
    VnFilterSolidColor* solidColor1 = [[VnFilterSolidColor alloc] init];
    [solidColor1 setColorRed:153.0f/255.0f green:157.0f/255.0f blue:119.0f/255.0 alpha:1.0f];
    solidColor1.topLayerOpacity = 0.16f;
    
    // Channel Mixer
    VnAdjustmentLayerChannelMixerFilter* mixerFilter1 = [[VnAdjustmentLayerChannelMixerFilter alloc] init];
    mixerFilter1.monochrome = YES;
    [mixerFilter1 setGreyChannelRed:40 Green:40 Blue:20 Constant:0];
    mixerFilter1.topLayerOpacity = 0.05f;
    
    // Levels
    VnFilterLevels* levelsFilter1 = [[VnFilterLevels alloc] init];
    [levelsFilter1 setMin:s255(0.0f) gamma:0.91f max:s255(215.0f) minOut:s255(0.0f) maxOut:s255(255.0f)];
    
    // Selective Color
    VnAdjustmentLayerSelectiveColor* selectiveColor1 = [[VnAdjustmentLayerSelectiveColor alloc] init];
    [selectiveColor1 setYellowsCyan:0 Magenta:75 Yellow:25 Black:0];
    [selectiveColor1 setGreensCyan:8 Magenta:0 Yellow:50 Black:100];
    [selectiveColor1 setBluesCyan:0 Magenta:0 Yellow:0 Black:25];
    [selectiveColor1 setBlacksCyan:0 Magenta:0 Yellow:0 Black:10];
    
    // Fill Layer
    VnFilterSolidColor* solidColor2 = [[VnFilterSolidColor alloc] init];
    [solidColor2 setColorRed:5.0f/255.0f green:5.0f/255.0f blue:5.0f/255.0 alpha:1.0f];
    solidColor2.topLayerOpacity = 0.60f;
    solidColor2.blendingMode = VnBlendingModeLighten;
    
    // Channel Mixer
    VnAdjustmentLayerChannelMixerFilter* mixerFilter2 = [[VnAdjustmentLayerChannelMixerFilter alloc] init];
    mixerFilter2.monochrome = YES;
    [mixerFilter2 setGreyChannelRed:40 Green:40 Blue:20 Constant:0];
    
    self.startFilter = curveFilter1;
    [curveFilter1 addTarget:hueSaturation];
    [hueSaturation addTarget:solidColor1];
    [solidColor1 addTarget:mixerFilter1];
    [mixerFilter1 addTarget:levelsFilter1];
    [levelsFilter1 addTarget:selectiveColor1];
    [selectiveColor1 addTarget:solidColor2];
    [solidColor2 addTarget:mixerFilter2];
    self.endFilter = mixerFilter2;
    
}

@end
