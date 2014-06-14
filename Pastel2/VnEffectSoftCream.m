//
//  VnEffectSoftCream.m
//  Pastel2
//
//  Created by SSC on 2014/06/12.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectSoftCream.h"

@implementation VnEffectSoftCream

- (id)init
{
    self = [super init];
    if(self){
        self.effectId = VnEffectIdSoftCream;
    }
    return self;
}

- (void)makeFilterGroup
{
    
    // Fill Layer
    VnFilterSolidColor* solidColor1 = [[VnFilterSolidColor alloc] init];
    [solidColor1 setColorRed:79.0f/255.0f green:52.0f/255.0f blue:43.0f/255.0 alpha:1.0f];
    solidColor1.topLayerOpacity = 0.52f;
    solidColor1.blendingMode = VnBlendingModeLighten;
    
    // Brightness
    VnFilterBrightness* brightnessFilter = [[VnFilterBrightness alloc] init];
    brightnessFilter.brightness = 0.10f;
    
    // Cntrast
    VnFilterLevels* levelsFilter1 = [[VnFilterLevels alloc] init];
    [levelsFilter1 setMin:s255(35.0f) gamma:1.14f max:s255(245.0f) minOut:s255(0.0f) maxOut:s255(255.0f)];
    levelsFilter1.topLayerOpacity = 0.44f;
    levelsFilter1.blendingMode = VnBlendingModeLuminotisy;
    
    // Levels
    VnFilterLevels* levelsFilter2 = [[VnFilterLevels alloc] init];
    [levelsFilter2 setMin:s255(0.0f) gamma:1.0f max:s255(255.0f) minOut:s255(0.0f) maxOut:s255(255.0f)];
    [levelsFilter2 setBlueMin:s255(0.0f) gamma:1.00f max:1.0f minOut:s255(15.0f) maxOut:s255(245.0f)];
    
    // Fill Layer
    VnFilterSolidColor* solidColor2 = [[VnFilterSolidColor alloc] init];
    [solidColor2 setColorRed:134.0f/255.0f green:132.0f/255.0f blue:117.0f/255.0 alpha:1.0f];
    solidColor2.topLayerOpacity = 0.30f;
    solidColor2.blendingMode = VnBlendingModeColor;
    
    // Fill Layer
    VnFilterSolidColor* solidColor3 = [[VnFilterSolidColor alloc] init];
    [solidColor3 setColorRed:253.0f/255.0f green:221.0f/255.0f blue:187.0f/255.0 alpha:1.0f];
    solidColor3.topLayerOpacity = 0.30f;
    solidColor3.blendingMode = VnBlendingModeSoftLight;
    
    // Levels
    VnFilterLevels* levelsFilter3 = [[VnFilterLevels alloc] init];
    [levelsFilter3 setMin:s255(0.0f) gamma:1.0f max:s255(255.0f) minOut:s255(9.0f) maxOut:s255(255.0f)];
    
    // Curve
    VnFilterToneCurve* curveFilter2 = [[VnFilterToneCurve alloc] initWithACV:@"bu001"];
    
    // Black White
    VnAdjustmentLayerChannelMixerFilter* mixerFilter = [[VnAdjustmentLayerChannelMixerFilter alloc] init];
    mixerFilter.monochrome = YES;
    [mixerFilter setGreyChannelRed:40 Green:40 Blue:20 Constant:0];
    mixerFilter.topLayerOpacity = 0.10f;

    self.startFilter = solidColor1;
    [solidColor1 addTarget:brightnessFilter];
    [brightnessFilter addTarget:levelsFilter1];
    [levelsFilter1 addTarget:levelsFilter2];
    [levelsFilter2 addTarget:solidColor2];
    [solidColor2 addTarget:solidColor3];
    [solidColor3 addTarget:levelsFilter3];
    [levelsFilter3 addTarget:curveFilter2];
    [curveFilter2 addTarget:mixerFilter];
    self.endFilter = mixerFilter;
}

@end
