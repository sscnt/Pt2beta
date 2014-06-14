//
//  VnEffectRoseyMatte.m
//  Pastel2
//
//  Created by SSC on 2014/06/13.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectRoseyMatte.h"

@implementation VnEffectRoseyMatte

- (id)init
{
    self = [super init];
    if(self){
        self.defaultOpacity = 0.9f;
        self.effectId = VnEffectIdRoseyMatte;
    }
    return self;
}

- (void)makeFilterGroup
{
    // Brightness
    VnFilterBrightness* brightnessFilter = [[VnFilterBrightness alloc] init];
    brightnessFilter.brightness = 0.2f;
    
    // Cntrast
    VnFilterLevels* levelsFilter1 = [[VnFilterLevels alloc] init];
    [levelsFilter1 setMin:s255(35.0f) gamma:1.14f max:s255(245.0f) minOut:s255(0.0f) maxOut:s255(255.0f)];
    levelsFilter1.topLayerOpacity = 0.30f;
    levelsFilter1.blendingMode = VnBlendingModeLuminotisy;
    
    // Levels
    VnFilterLevels* levelsFilter2 = [[VnFilterLevels alloc] init];
    [levelsFilter2 setMin:s255(13.0f) gamma:1.31f max:s255(242.0f) minOut:s255(0.0f) maxOut:s255(255.0f)];
    levelsFilter2.topLayerOpacity = 0.30f;
    levelsFilter2.blendingMode = VnBlendingModeLuminotisy;
    
    // Gradient Map
    VnAdjustmentLayerGradientMap* gradientMap1 = [[VnAdjustmentLayerGradientMap alloc] init];
    [gradientMap1 addColorRed:236.0f Green:147.0f Blue:178.0f Opacity:100.0f Location:0 Midpoint:50];
    [gradientMap1 addColorRed:255.0f Green:255.0f Blue:255.0f Opacity:100.0f Location:4096 Midpoint:50];
    gradientMap1.topLayerOpacity = 0.28f;
    
    // Color Balance
    VnAdjustmentLayerColorBalance* colorBalance1 = [[VnAdjustmentLayerColorBalance alloc] init];
    GPUVector3 shadows1;
    shadows1.one = s255(0.0f);
    shadows1.two = s255(0.0f);
    shadows1.three = s255(0.0f);
    [colorBalance1 setShadows:shadows1];
    GPUVector3 midtones1;
    midtones1.one = s255(0.0f);
    midtones1.two = s255(0.0f);
    midtones1.three = s255(0.0f);
    [colorBalance1 setMidtones:midtones1];
    GPUVector3 highlights1;
    highlights1.one = s255(-7.0f);
    highlights1.two = s255(0.0f);
    highlights1.three = s255(0.0f);
    [colorBalance1 setHighlights:highlights1];
    colorBalance1.preserveLuminosity = YES;
    
    // Fill Layer
    VnFilterSolidColor* solidColor1 = [[VnFilterSolidColor alloc] init];
    [solidColor1 setColorRed:239.0f/255.0f green:172.0f/255.0f blue:185.0f  /255.0 alpha:1.0f];
    solidColor1.topLayerOpacity = 0.10f;
    
    // Curve
    VnFilterToneCurve* curveFilter1 = [[VnFilterToneCurve alloc] initWithACV:@"br001"];
    
    // Levels
    VnFilterLevels* levelsFilter3 = [[VnFilterLevels alloc] init];
    [levelsFilter3 setMin:s255(23.0f) gamma:0.79f max:s255(255.0f) minOut:s255(0.0f) maxOut:s255(255.0f)];
    
    // Curve
    VnFilterToneCurve* curveFilter2 = [[VnFilterToneCurve alloc] initWithACV:@"br002"];
    
    // Curve
    VnFilterToneCurve* curveFilter3 = [[VnFilterToneCurve alloc] initWithACV:@"br003"];
    curveFilter3.topLayerOpacity = 0.71f;

    self.startFilter = brightnessFilter;
    [brightnessFilter addTarget:levelsFilter1];
    [levelsFilter1 addTarget:levelsFilter2];
    [levelsFilter2 addTarget:gradientMap1];
    [gradientMap1 addTarget:colorBalance1];
    [colorBalance1 addTarget:solidColor1];
    [solidColor1 addTarget:curveFilter1];
    [curveFilter1 addTarget:levelsFilter3];
    [levelsFilter3 addTarget:curveFilter2];
    [curveFilter2 addTarget:curveFilter3];
    self.endFilter = curveFilter3;
}

@end
