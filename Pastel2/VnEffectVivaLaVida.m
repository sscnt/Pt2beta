//
//  VnEffectVivaLaVida.m
//  Pastel2
//
//  Created by SSC on 2014/06/14.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectVivaLaVida.h"

@implementation VnEffectVivaLaVida

- (id)init
{
    self = [super init];
    if(self){
        self.effectId = VnEffectIdVivaLaVida;
    }
    return self;
}

- (void)makeFilterGroup
{
    
    // Fill Layer
    VnFilterSolidColor* solidColor1 = [[VnFilterSolidColor alloc] init];
    [solidColor1 setColorRed:131.0f/255.0f green:121.0f/255.0f blue:101.0f/255.0 alpha:1.0f];
    solidColor1.topLayerOpacity = 0.44f * 0.76f;
    solidColor1.blendingMode = VnBlendingModeHardLight;
    
    // Contrast
    VnFilterLevels* levelsFilter1 = [[VnFilterLevels alloc] init];
    [levelsFilter1 setMin:s255(35.0f) gamma:1.14 max:s255(246.0f) minOut:s255(0.0f) maxOut:s255(255.0f)];
    levelsFilter1.topLayerOpacity = 0.20f;
    levelsFilter1.blendingMode = VnBlendingModeLuminotisy;
    
    // Brightness
    VnFilterBrightness* brightnessFilter = [[VnFilterBrightness alloc] init];
    brightnessFilter.brightness = 0.1f;
    
    // Levels
    VnFilterLevels* levelsFilter2 = [[VnFilterLevels alloc] init];
    [levelsFilter2 setMin:0.0f gamma:1.0f max:1.0f minOut:0.0f maxOut:1.0f];
    [levelsFilter2 setBlueMin:s255(0.0f) gamma:1.0f max:1.0f minOut:s255(31.0f) maxOut:s255(229.0f)];
    
    // Brightness
    VnFilterBrightness* brightnessFilter2 = [[VnFilterBrightness alloc] init];
    brightnessFilter2.brightness = -0.05f;
    
    // Fill Layer
    VnFilterSolidColor* solidColor2 = [[VnFilterSolidColor alloc] init];
    [solidColor2 setColorRed:203.0f/255.0f green:194.0f/255.0f blue:176.0f/255.0 alpha:1.0f];
    solidColor2.topLayerOpacity = 0.44f * 0.66;
    solidColor2.blendingMode = VnBlendingModeDarken;
    
    // Levels
    VnFilterLevels* levelsFilter3 = [[VnFilterLevels alloc] init];
    [levelsFilter3 setMin:0.0f gamma:1.0f max:1.0f minOut:0.0f maxOut:1.0f];
    [levelsFilter3 setGreenMin:s255(0.0f) gamma:1.04f max:1.0f minOut:s255(8.0f) maxOut:s255(243.0f)];
    
    // Levels
    VnFilterLevels* levelsFilter4 = [[VnFilterLevels alloc] init];
    [levelsFilter4 setMin:0.0f gamma:1.0f max:1.0f minOut:0.0f maxOut:1.0f];
    [levelsFilter4 setBlueMin:s255(0.0f) gamma:1.0f max:1.0f minOut:s255(8.0f) maxOut:s255(244.0f)];
    
    // Curve
    VnFilterToneCurve* curveFilter = [[VnFilterToneCurve alloc] initWithACV:@"ac001"];
    
    // Contrast
    VnFilterLevels* levelsFilter5 = [[VnFilterLevels alloc] init];
    [levelsFilter5 setMin:s255(35.0f) gamma:1.14 max:s255(246.0f) minOut:s255(0.0f) maxOut:s255(255.0f)];
    levelsFilter5.topLayerOpacity = 0.18f;
    levelsFilter5.blendingMode = VnBlendingModeLuminotisy;
    
    // Brightness
    VnFilterBrightness* brightnessFilter3 = [[VnFilterBrightness alloc] init];
    brightnessFilter3.brightness = 0.1f;
    
    // Gradient Map
    VnAdjustmentLayerGradientMap* gradientMap = [[VnAdjustmentLayerGradientMap alloc] init];
    [gradientMap addColorRed:238.0f Green:215.0f Blue:200.0f Opacity:100.0f Location:0 Midpoint:50];
    [gradientMap addColorRed:12.0f Green:12.0f Blue:11.0f Opacity:100.0f Location:4096 Midpoint:50];
    gradientMap.topLayerOpacity = 0.3f;
    gradientMap.blendingMode = VnBlendingModeSoftLight;
    
    // Levels
    VnFilterLevels* levelsFilter6 = [[VnFilterLevels alloc] init];
    [levelsFilter6 setMin:0.0f gamma:1.0f max:1.0f minOut:0.0f maxOut:1.0f];
    [levelsFilter6 setBlueMin:s255(0.0f) gamma:1.0f max:1.0f minOut:s255(39.0f) maxOut:s255(229.0f)];
    levelsFilter6.topLayerOpacity = 0.50f;
    
    self.startFilter = solidColor1;
    [solidColor1 addTarget:levelsFilter1];
    [levelsFilter1 addTarget:brightnessFilter];
    [brightnessFilter addTarget:levelsFilter2];
    [levelsFilter2 addTarget:brightnessFilter2];
    [brightnessFilter2 addTarget:solidColor2];
    [solidColor2 addTarget:levelsFilter3];
    [levelsFilter3 addTarget:levelsFilter4];
    [levelsFilter4 addTarget:curveFilter];
    [curveFilter addTarget:levelsFilter5];
    [levelsFilter5 addTarget:brightnessFilter3];
    [brightnessFilter3 addTarget:levelsFilter6];
    self.endFilter = levelsFilter6;
}

@end
