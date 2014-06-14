//
//  VnEffectFawn.m
//  Pastel2
//
//  Created by SSC on 2014/06/14.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectFawn.h"

@implementation VnEffectFawn

- (id)init
{
    self = [super init];
    if(self){
        self.effectId = VnEffectIdFawn;
    }
    return self;
}

- (void)makeFilterGroup
{
    
    // Levels
    VnFilterLevels* levelsFilter1 = [[VnFilterLevels alloc] init];
    [levelsFilter1 setMin:s255(0.0f) gamma:0.80f max:s255(255.0f) minOut:s255(0.0f) maxOut:s255(255.0f)];
    levelsFilter1.topLayerOpacity = 0.15f;
    levelsFilter1.blendingMode = VnBlendingModeScreen;
    
    // Hue / Saturation
    VnAdjustmentLayerHueSaturation* hueSaturation1 = [[VnAdjustmentLayerHueSaturation alloc] init];
    hueSaturation1.hue = 0.0f;
    hueSaturation1.saturation = 10;
    hueSaturation1.lightness = 0.0;
    hueSaturation1.colorize = NO;
    hueSaturation1.topLayerOpacity = 0.20f;
    
    // Fill Layer
    VnAdjustmentLayerGradientColorFill* gradientColor1 = [[VnAdjustmentLayerGradientColorFill alloc] initWithEffectObj:self];
    [gradientColor1 setStyle:GradientStyleRadial];
    [gradientColor1 setAngleDegree:0.0f];
    [gradientColor1 setScalePercent:200];
    [gradientColor1 setOffsetX:0.0f Y:0.0f];
    [gradientColor1 addColorRed:227.0f Green:218.0f Blue:211.0f Opacity:0.0f Location:0 Midpoint:50];
    [gradientColor1 addColorRed:66.0f Green:39.0f Blue:16.0f Opacity:100.0f Location:4096 Midpoint:50];
    gradientColor1.topLayerOpacity = 0.60f;
    gradientColor1.blendingMode = VnBlendingModeSoftLight;
    
    // Fill Layer
    VnFilterSolidColor* solidColor1 = [[VnFilterSolidColor alloc] init];
    [solidColor1 setColorRed:6.0/255.0f green:0.0f/255.0f blue:111.0f/255.0 alpha:1.0f];
    solidColor1.topLayerOpacity = 0.38f;
    solidColor1.blendingMode = VnBlendingModeLighten;
    
    // Fill Layer
    VnFilterSolidColor* solidColor2 = [[VnFilterSolidColor alloc] init];
    [solidColor2 setColorRed:127.0f/255.0f green:105.0f/255.0f blue:80.0f/255.0 alpha:1.0f];
    solidColor2.topLayerOpacity = 0.14f;
    solidColor2.blendingMode = VnBlendingModeLighten;
    
    // Contrast
    VnFilterLevels* levelsFilter2 = [[VnFilterLevels alloc] init];
    [levelsFilter2 setMin:s255(0.0f) gamma:1.65 max:s255(255.0f) minOut:s255(0.0f) maxOut:s255(255.0f)];
    levelsFilter2.topLayerOpacity = 0.65f;
    levelsFilter2.blendingMode = VnBlendingModeSoftLight;
    
    // Photo Filter
    VnAdjustmentLayerPhotoFilter* photoFilter1 = [[VnAdjustmentLayerPhotoFilter alloc] init];
    photoFilter1.color = (GPUVector3){s255(236.0f), s255(138.0f), 0.0f};
    photoFilter1.density = 0.15f;
    photoFilter1.preserveLuminosity = YES;
    photoFilter1.topLayerOpacity = 0.60f;
    
    // Contrast
    VnFilterLevels* levelsFilter3 = [[VnFilterLevels alloc] init];
    [levelsFilter3 setMin:s255(40.0f) gamma:1.10f max:s255(250.0f) minOut:s255(0.0f) maxOut:s255(255.0f)];
    levelsFilter3.topLayerOpacity = 0.65f;
    
    self.startFilter = levelsFilter1;
    [levelsFilter1 addTarget:hueSaturation1];
    [hueSaturation1 addTarget:gradientColor1];
    [gradientColor1 addTarget:solidColor1];
    [solidColor1 addTarget:solidColor2];
    [solidColor2 addTarget:levelsFilter2];
    [levelsFilter2 addTarget:photoFilter1];
    [photoFilter1 addTarget:levelsFilter3];
    self.endFilter = levelsFilter3;
    

}

@end
