//
//  VnEffectPearl.m
//  Pastel2
//
//  Created by SSC on 2014/06/20.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectPearl.h"

@implementation VnEffectPearl

- (id)init
{
    self = [super init];
    if(self){
        self.effectId = VnEffectIdPearl;
    }
    return self;
}

- (void)makeFilterGroup
{
    // Levels
    VnFilterLevels* levelsFilter2 = [[VnFilterLevels alloc] init];
    [levelsFilter2 setMin:s255(30.0f) gamma:1.27f max:s255(235.0f)];
    levelsFilter2.topLayerOpacity = 0.20f;
    levelsFilter2.blendingMode = VnBlendingModeLuminotisy;
    
    // Hue / Saturation
    VnAdjustmentLayerHueSaturation* hueSaturation = [[VnAdjustmentLayerHueSaturation alloc] init];
    hueSaturation.hue = 0.0f;
    hueSaturation.saturation = 30.0f;
    hueSaturation.lightness = 0.0f;
    hueSaturation.colorize = NO;
    hueSaturation.topLayerOpacity = 0.60f;
    
    // Levels
    VnFilterLevels* levelsFilter3 = [[VnFilterLevels alloc] init];
    [levelsFilter3 setRedMin:s255(20.0f) gamma:1.30f max:s255(245.0f)];
    [levelsFilter3 setGreenMin:0.0f gamma:1.12 max:s255(209.0f) minOut:0.0f maxOut:s255(245.0f)];
    [levelsFilter3 setBlueMin:0.0f gamma:1.51f max:s255(240.0f) minOut:s255(25.0f) maxOut:s255(249.0f)];
    levelsFilter3.topLayerOpacity = 0.90f;
    
    // Fill Layer
    VnFilterSolidColor* solidColor1 = [[VnFilterSolidColor alloc] init];
    [solidColor1 setColorRed:13.0f/255.0f green:59.0f/255.0f blue:102.0f/255.0 alpha:1.0f];
    solidColor1.blendingMode = VnBlendingModeExclusion;
    solidColor1.topLayerOpacity = 0.30f;
    
    // Fill Layer
    VnAdjustmentLayerGradientColorFill* gradientColor1 = [[VnAdjustmentLayerGradientColorFill alloc] initWithEffectObj:self];
    [gradientColor1 setStyle:GradientStyleRadial];
    [gradientColor1 setAngleDegree:0.0f];
    [gradientColor1 setScalePercent:122];
    [gradientColor1 setOffsetX:0.0f Y:0.0f];
    [gradientColor1 addColorRed:8.0f Green:8.0f Blue:8.0f Opacity:0.0f Location:0 Midpoint:50];
    [gradientColor1 addColorRed:8.0f Green:8.0f Blue:8.0f Opacity:0.0f Location:2048 Midpoint:50];
    [gradientColor1 addColorRed:8.0f Green:8.0f Blue:8.0f Opacity:100.0f Location:4096 Midpoint:50];
    gradientColor1.topLayerOpacity = 0.20f;
    gradientColor1.blendingMode = VnBlendingModeOverlay;
    
    // Gradient Map
    VnAdjustmentLayerGradientMap* gradientMap1 = [[VnAdjustmentLayerGradientMap alloc] init];
    [gradientMap1 addColorRed:0.0f Green:0.0f Blue:0.0f Opacity:100.0f Location:0 Midpoint:50];
    [gradientMap1 addColorRed:255.0f Green:255.0f Blue:255.0f Opacity:100.0f Location:4096 Midpoint:50];
    gradientMap1.blendingMode = VnBlendingModeOverlay;
    gradientMap1.topLayerOpacity = 0.4f;
    
    // Gradient Map
    VnAdjustmentLayerGradientMap* gradientMap2 = [[VnAdjustmentLayerGradientMap alloc] init];
    [gradientMap2 addColorRed:172.0f Green:219.0f Blue:253.0f Opacity:100.0f Location:0 Midpoint:50];
    [gradientMap2 addColorRed:255.0f Green:255.0f Blue:255.0f Opacity:100.0f Location:4096 Midpoint:50];
    gradientMap2.blendingMode = VnBlendingModeScreen;
    gradientMap2.topLayerOpacity = 0.20f;
    
    // Photo Filter
    VnAdjustmentLayerPhotoFilter* photoFilter1 = [[VnAdjustmentLayerPhotoFilter alloc] init];
    photoFilter1.color = (GPUVector3){s255(236.0f), s255(138.0f), 0.0f};
    photoFilter1.density = 0.3f;
    photoFilter1.preserveLuminosity = YES;
    photoFilter1.topLayerOpacity = 0.25f;

    self.startFilter = levelsFilter2;
    [levelsFilter2 addTarget:hueSaturation];
    [hueSaturation addTarget:levelsFilter3];
    [levelsFilter3 addTarget:solidColor1];
    [solidColor1 addTarget:gradientColor1];
    [gradientColor1 addTarget:gradientMap1];
    [gradientMap1 addTarget:gradientMap2];
    [gradientMap2 addTarget:photoFilter1];
    self.endFilter = photoFilter1;
    
    
}

@end
