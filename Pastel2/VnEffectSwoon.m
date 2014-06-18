//
//  VnEffectSwoon.m
//  Pastel2
//
//  Created by SSC on 2014/06/18.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectSwoon.h"

@implementation VnEffectSwoon

- (id)init
{
    self = [super init];
    if(self){
        self.effectId = VnEffectIdSwoon;
    }
    return self;
}

- (void)makeFilterGroup
{
    // Levels
    VnFilterLevels* levelsFilter1 = [[VnFilterLevels alloc] init];
    [levelsFilter1 setMin:s255(5.0f) gamma:1.05f max:1.0];
    levelsFilter1.blendingMode = VnBlendingModeScreen;
    levelsFilter1.topLayerOpacity = 0.30f;
    
    // Levels
    VnFilterLevels* levelsFilter2 = [[VnFilterLevels alloc] init];
    [levelsFilter2 setMin:s255(5.0f) gamma:1.05f max:1.0];
    levelsFilter2.blendingMode = VnBlendingModeMultiply;
    levelsFilter2.topLayerOpacity = 0.05f;
    
    // Levels
    VnFilterLevels* levelsFilter3 = [[VnFilterLevels alloc] init];
    [levelsFilter3 setRedMin:s255(27.0f) gamma:1.17f max:s255(247.0f)];
    [levelsFilter3 setGreenMin:s255(26.0f) gamma:1.23f max:s255(255.0f)];
    [levelsFilter3 setBlueMin:0.0f gamma:1.0f max:1.0f minOut:s255(26.0f) maxOut:s255(221.0f)];
    
    // Levels
    VnFilterLevels* levelsFilter4 = [[VnFilterLevels alloc] init];
    [levelsFilter4 setMin:s255(23.0f) gamma:1.17f max:1.0f];
    
    // Fill Layer
    VnAdjustmentLayerGradientColorFill* gradientColor1 = [[VnAdjustmentLayerGradientColorFill alloc] initWithEffectObj:self];
    [gradientColor1 setStyle:GradientStyleRadial];
    [gradientColor1 setAngleDegree:0.0f];
    [gradientColor1 setScalePercent:150];
    [gradientColor1 setOffsetX:0.0f Y:0.0f];
    [gradientColor1 addColorRed:8.0f Green:8.0f Blue:8.0f Opacity:0.0f Location:0 Midpoint:50];
    [gradientColor1 addColorRed:8.0f Green:8.0f Blue:8.0f Opacity:100.0f Location:4096 Midpoint:50];
    gradientColor1.blendingMode = VnBlendingModeOverlay;
    gradientColor1.topLayerOpacity = 0.20f;
    
    // Fill Layer
    VnFilterSolidColor* solidColor1 = [[VnFilterSolidColor alloc] init];
    [solidColor1 setColorRed:2.0f/255.0f green:19.0f/255.0f blue:115.0f/255.0 alpha:1.0f];
    solidColor1.topLayerOpacity = 0.20f;
    solidColor1.blendingMode = VnBlendingModeExclusion;
    
    // Levels
    VnFilterLevels* levelsFilter5 = [[VnFilterLevels alloc] init];
    [levelsFilter5 setMin:s255(23.0f) gamma:1.17f max:1.0f];
    [levelsFilter5 setBlueMin:0.0f gamma:1.0f max:s255(244.0f) minOut:s255(82.0f) maxOut:1.0f];
    levelsFilter5.topLayerOpacity = 0.10f;
    
    // Fill Layer
    VnFilterSolidColor* solidColor6 = [[VnFilterSolidColor alloc] init];
    [solidColor6 setColorRed:232.0f/255.0f green:49.0f/255.0f blue:105.0f/255.0 alpha:1.0f];
    solidColor6.topLayerOpacity = 0.05f;
    solidColor6.blendingMode = VnBlendingModeSoftLight;
    
    // Gradient Map
    VnAdjustmentLayerGradientMap* gradientMap1 = [[VnAdjustmentLayerGradientMap alloc] init];
    [gradientMap1 addColorRed:46.0f Green:45.0f Blue:43.0f Opacity:100.0f Location:0 Midpoint:50];
    [gradientMap1 addColorRed:255.0f Green:255.0f Blue:255.0f Opacity:100.0f Location:4096 Midpoint:50];
    gradientMap1.blendingMode = VnBlendingModeSoftLight;
    gradientMap1.topLayerOpacity = 0.70f;
    
    // Levels
    VnFilterLevels* levelsFilter7 = [[VnFilterLevels alloc] init];
    [levelsFilter7 setMin:s255(83.0f) gamma:1.58f max:s255(236.0f)];
    levelsFilter7.topLayerOpacity = 0.35f;
    
    self.startFilter = levelsFilter1;
    [levelsFilter1 addTarget:levelsFilter2];
    [levelsFilter2 addTarget:levelsFilter3];
    [levelsFilter3 addTarget:levelsFilter4];
    [levelsFilter4 addTarget:gradientColor1];
    [gradientColor1 addTarget:solidColor1];
    [solidColor1 addTarget:levelsFilter5];
    [levelsFilter5 addTarget:solidColor6];
    [solidColor6 addTarget:gradientMap1];
    [gradientMap1 addTarget:levelsFilter7];
    self.endFilter = levelsFilter7;
}

@end
