//
//  VnEffectBlackWhite20.m
//  Pastel2
//
//  Created by SSC on 2014/06/13.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectBlackWhite20.h"

@implementation VnEffectBlackWhite20

- (id)init
{
    self = [super init];
    if(self){
        self.effectId = VnEffectIdBlackWhite20;
    }
    return self;
}

- (void)makeFilterGroup
{
    // Lighten
    VnFilterDuplicate* lightenFilter1 = [[VnFilterDuplicate alloc] init];
    lightenFilter1.topLayerOpacity = 0.30f;
    lightenFilter1.blendingMode = VnBlendingModeScreen;
    
    // Darken
    VnFilterDuplicate* lightenFilter2 = [[VnFilterDuplicate alloc] init];
    lightenFilter2.topLayerOpacity = 0.10f;
    lightenFilter2.blendingMode = VnBlendingModeMultiply;
    
    // Levels
    VnFilterLevels* levelsFilter1 = [[VnFilterLevels alloc] init];
    [levelsFilter1 setRedMin:s255(0.0f) gamma:1.0f max:s255(255.0f) minOut:s255(0.0f) maxOut:s255(239.0f)];
    [levelsFilter1 setGreenMin:s255(0.0f) gamma:1.0f max:s255(255.0f) minOut:s255(0.0f) maxOut:s255(239.0f)];
    [levelsFilter1 setBlueMin:s255(0.0f) gamma:1.30f max:s255(255.0f) minOut:s255(0.0f) maxOut:s255(239.0f)];
    
    // Channel Mixer
    VnAdjustmentLayerChannelMixerFilter* mixerFilter1 = [[VnAdjustmentLayerChannelMixerFilter alloc] init];
    [mixerFilter1 setRedChannelRed:133 Green:-41 Blue:0 Constant:0];
    [mixerFilter1 setGreenChannelRed:0 Green:100 Blue:0 Constant:0];
    [mixerFilter1 setBlueChannelRed:0 Green:-16 Blue:96 Constant:0];
    
    
    // Gradient Map
    VnAdjustmentLayerGradientMap* gradientMap1 = [[VnAdjustmentLayerGradientMap alloc] init];
    [gradientMap1 addColorRed:0.0f Green:0.0f Blue:0.0f Opacity:100.0f Location:0 Midpoint:50];
    [gradientMap1 addColorRed:255.0f Green:242.0f Blue:227.0f Opacity:100.0f Location:4096 Midpoint:50];
    
    // Gradient Map
    VnAdjustmentLayerGradientMap* gradientMap2 = [[VnAdjustmentLayerGradientMap alloc] init];
    [gradientMap2 addColorRed:0.0f Green:0.0f Blue:0.0f Opacity:100.0f Location:0 Midpoint:50];
    [gradientMap2 addColorRed:238.0f Green:236.0f Blue:221.0f Opacity:100.0f Location:4096 Midpoint:50];
    gradientMap2.blendingMode = VnBlendingModeSoftLight;
    
    // Curve
    VnFilterToneCurve* curveFilter1 = [[VnFilterToneCurve alloc] initWithACV:@"bw20"];
    
    // Hue / Saturation
    VnAdjustmentLayerHueSaturation* hueSaturation = [[VnAdjustmentLayerHueSaturation alloc] init];
    hueSaturation.hue = 0.0f;
    hueSaturation.saturation = -100.0f;
    hueSaturation.lightness = 0.0f;
    hueSaturation.colorize = NO;
    
    self.startFilter = lightenFilter1;
    [lightenFilter1 addTarget:lightenFilter2];
    [lightenFilter2 addTarget:levelsFilter1];
    [levelsFilter1 addTarget:mixerFilter1];
    [mixerFilter1 addTarget:gradientMap1];
    [gradientMap1 addTarget:gradientMap2];
    [gradientMap2 addTarget:curveFilter1];
    [curveFilter1 addTarget:hueSaturation];
    self.endFilter = hueSaturation;
}

@end
