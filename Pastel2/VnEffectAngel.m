//
//  VnEffectAngel.m
//  Pastel2
//
//  Created by SSC on 2014/06/14.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectAngel.h"

@implementation VnEffectAngel

- (id)init
{
    self = [super init];
    if(self){
        self.defaultOpacity = 1.0f;
        self.effectId = VnEffectIdAngel;
    }
    return self;
}

- (void)makeFilterGroup
{
    // Levels
    VnFilterLevels* levelsFilter1 = [[VnFilterLevels alloc] init];
    [levelsFilter1 setMin:s255(6.0f) gamma:1.10f max:s255(255.0f) minOut:s255(0.0f) maxOut:s255(255.0f)];
    levelsFilter1.topLayerOpacity = 0.4f;
    levelsFilter1.blendingMode = VnBlendingModeScreen;
    
    // Fill Layer
    VnFilterSolidColor* solidColor1 = [[VnFilterSolidColor alloc] init];
    [solidColor1 setColorRed:87.0f/255.0f green:78.0f/255.0f blue:143.0f/255.0 alpha:1.0f];
    solidColor1.topLayerOpacity = 0.14f;
    solidColor1.blendingMode = VnBlendingModeExclusion;
    
    // Levels
    VnFilterLevels* levelsFilter2 = [[VnFilterLevels alloc] init];
    [levelsFilter2 setMin:s255(67.0f) gamma:1.70f max:s255(218.0f) minOut:s255(0.0f) maxOut:s255(255.0f)];
    levelsFilter2.topLayerOpacity = 0.7f;
    levelsFilter2.blendingMode = VnBlendingModeLuminotisy;
    
    // Fill Layer
    VnFilterSolidColor* solidColor2 = [[VnFilterSolidColor alloc] init];
    [solidColor2 setColorRed:232.0f/255.0f green:212.0f/255.0f blue:171.0f/255.0 alpha:1.0f];
    solidColor2.topLayerOpacity = 0.25f;
    solidColor2.blendingMode = VnBlendingModeColorBurn;
    
    // Levels
    VnFilterLevels* levelsFilter3 = [[VnFilterLevels alloc] init];
    [levelsFilter3 setMin:s255(0.0f) gamma:1.0f max:s255(255.0f) minOut:s255(0.0f) maxOut:s255(255.0f)];
    [levelsFilter3 setBlueMin:0.0f gamma:1.0f max:1.0f minOut:s255(80.0f) maxOut:1.0f];
    levelsFilter3.topLayerOpacity = 0.4f;
    
    // Hue / Saturation
    VnAdjustmentLayerHueSaturation* hueSaturation1 = [[VnAdjustmentLayerHueSaturation alloc] init];
    hueSaturation1.hue = 0.0f;
    hueSaturation1.saturation = 10;
    hueSaturation1.lightness = 0.0;
    hueSaturation1.colorize = NO;
    hueSaturation1.topLayerOpacity = 0.30f;
    
    // Photo Filter
    VnAdjustmentLayerPhotoFilter* photoFilter1 = [[VnAdjustmentLayerPhotoFilter alloc] init];
    photoFilter1.color = (GPUVector3){s255(236.0f), s255(138.0f), 0.0f};
    photoFilter1.density = 0.20f;
    photoFilter1.preserveLuminosity = YES;
    photoFilter1.topLayerOpacity = 0.10f;
    
    // Fill Layer
    VnAdjustmentLayerGradientColorFill* gradientColor1 = [[VnAdjustmentLayerGradientColorFill alloc] initWithEffectObj:self];
    [gradientColor1 setStyle:GradientStyleRadial];
    [gradientColor1 setAngleDegree:0.0f];
    [gradientColor1 setScalePercent:150];
    [gradientColor1 setOffsetX:0.0f Y:0.0f];
    [gradientColor1 addColorRed:8.0f Green:8.0f Blue:8.0f Opacity:0.0f Location:0 Midpoint:50];
    [gradientColor1 addColorRed:8.0f Green:8.0f Blue:8.0f Opacity:0.0f Location:2048 Midpoint:50];
    [gradientColor1 addColorRed:8.0f Green:8.0f Blue:8.0f Opacity:100.0f Location:4096 Midpoint:50];
    gradientColor1.topLayerOpacity = 0.20f;
    gradientColor1.blendingMode = VnBlendingModeOverlay;

    self.startFilter = levelsFilter1;
    [levelsFilter1 addTarget:solidColor1];
    [solidColor1 addTarget:levelsFilter2];
    [levelsFilter2 addTarget:solidColor2];
    [solidColor2 addTarget:levelsFilter3];
    [levelsFilter3 addTarget:hueSaturation1];
    [hueSaturation1 addTarget:photoFilter1];
    [photoFilter1 addTarget:gradientColor1];
    self.endFilter = gradientColor1;
    
    
}

@end
