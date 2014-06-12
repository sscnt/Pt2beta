//
//  VnEffectVintageHaze.m
//  Pastel2
//
//  Created by SSC on 2014/06/12.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectVintageHaze.h"

@implementation VnEffectVintageHaze

- (id)init
{
    self = [super init];
    if(self){
        self.effectId = VnEffectIdVintageHaze;
    }
    return self;
}

- (void)makeFilterGroup
{
    //// Soft contrast
    VnFilterPassThrough* softInput = [[VnFilterPassThrough alloc] init];
    VnImageNormalBlendFilter* softMerge = [[VnImageNormalBlendFilter alloc] init];
    softMerge.blendingMode = VnBlendingModeSoftLight;
    softMerge.topLayerOpacity = 0.70f;
    
    //// Lighten
    VnFilterDuplicate* lightenFilter = [[VnFilterDuplicate alloc] init];
    lightenFilter.topLayerOpacity = 0.25f;
    lightenFilter.blendingMode = VnBlendingModeScreen;
    
    // Photo Filter
    VnAdjustmentLayerPhotoFilter* photoFilter1 = [[VnAdjustmentLayerPhotoFilter alloc] init];
    photoFilter1.color = (GPUVector3){s255(236.0f), s255(138.0f), 0.0f};
    photoFilter1.density = 0.30f;
    photoFilter1.preserveLuminosity = YES;
    photoFilter1.topLayerOpacity = 0.35f;
    
    // Fill Layer
    VnFilterSolidColor* solidColor2 = [[VnFilterSolidColor alloc] init];
    [solidColor2 setColorRed:252.0f/255.0f green:234.0f/255.0f blue:195.0f/255.0 alpha:1.0f];
    solidColor2.topLayerOpacity = 0.50f;
    solidColor2.blendingMode = VnBlendingModeMultiply;
    
    // Hue / Saturation
    VnAdjustmentLayerHueSaturation* hueSaturation2 = [[VnAdjustmentLayerHueSaturation alloc] init];
    hueSaturation2.hue = 43.0f;
    hueSaturation2.saturation = 25.0f;
    hueSaturation2.lightness = 0.0f;
    hueSaturation2.colorize = YES;
    hueSaturation2.topLayerOpacity = 0.50f;
    
    // Levels
    VnFilterLevels* levelsFilter1 = [[VnFilterLevels alloc] init];
    [levelsFilter1 setMin:s255(8.0f) gamma:1.40f max:s255(245.0f) minOut:0.0f maxOut:1.0f];
    levelsFilter1.topLayerOpacity = 0.0f;
    levelsFilter1.blendingMode = VnBlendingModeNormal;
    
    // Fill Layer
    VnAdjustmentLayerGradientColorFill* gradientColor1 = [[VnAdjustmentLayerGradientColorFill alloc] initWithEffectObj:self];
    [gradientColor1 setStyle:GradientStyleRadial];
    [gradientColor1 setAngleDegree:90];
    [gradientColor1 setScalePercent:150];
    [gradientColor1 setOffsetX:0.0f Y:0.0f];
    [gradientColor1 addColorRed:255.0f Green:255.0f Blue:255.0f Opacity:0.0f Location:0 Midpoint:50];
    [gradientColor1 addColorRed:255.0f Green:255.0f Blue:255.0f Opacity:0.0f Location:1433 Midpoint:50];
    [gradientColor1 addColorRed:0.0f Green:0.0f Blue:0.0f Opacity:100.0f Location:4096 Midpoint:50];
    gradientColor1.topLayerOpacity = 0.45f;
    gradientColor1.blendingMode = VnBlendingModeSoftLight;
    
    // Gradient Map
    VnAdjustmentLayerGradientMap* gradientMap1 = [[VnAdjustmentLayerGradientMap alloc] init];
    [gradientMap1 addColorRed:242.0f Green:232.0f Blue:207.0f Opacity:100.0f Location:0 Midpoint:50];
    [gradientMap1 addColorRed:255.0f Green:255.0f Blue:255.0f Opacity:100.0f Location:4096 Midpoint:50];
    gradientMap1.topLayerOpacity = 0.30f;
    gradientMap1.blendingMode = VnBlendingModeNormal;
    
    self.startFilter = softInput;
    [softInput addTarget:softMerge atTextureLocation:1];
    [softInput addTarget:lightenFilter];
    [lightenFilter addTarget:photoFilter1];
    [photoFilter1 addTarget:solidColor2];
    [solidColor2 addTarget:hueSaturation2];
    [hueSaturation2 addTarget:levelsFilter1];
    [levelsFilter1 addTarget:gradientColor1];
    [gradientColor1 addTarget:softMerge atTextureLocation:0];
    [softMerge addTarget:gradientMap1];
    self.endFilter = gradientMap1;
    
}

@end
