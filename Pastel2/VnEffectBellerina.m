//
//  VnEffectBellerina.m
//  Pastel
//
//  Created by SSC on 2014/05/10.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectBellerina.h"

@implementation VnEffectBellerina

- (id)init
{
    self = [super init];
    if(self){
        self.effectId = VnEffectIdBellerina;
    }
    return self;
}

- (void)makeFilterGroup
{
    // Levels
    VnFilterLevels* levelsFilter1 = [[VnFilterLevels alloc] init];
    [levelsFilter1 setMin:s255(0.0f) gamma:1.61f max:s255(255.0f) minOut:s255(0.0f) maxOut:s255(255.0f)];
    levelsFilter1.blendingMode = VnBlendingModeSoftLight;
    levelsFilter1.topLayerOpacity = 0.80f;
    
    
    // Photo Filter
    VnAdjustmentLayerPhotoFilter* photoFilter1 = [[VnAdjustmentLayerPhotoFilter alloc] init];
    photoFilter1.color = (GPUVector3){s255(236.0f), s255(138.0f), 0.0f};
    photoFilter1.density = 0.50f;
    photoFilter1.preserveLuminosity = YES;
    photoFilter1.topLayerOpacity = 0.20f;
    
    
    
    // Fill Layer
    VnFilterSolidColor* solidColor1 = [[VnFilterSolidColor alloc] init];
    [solidColor1 setColorRed:73.0f/255.0f green:9.0f/255.0f blue:133.0f/255.0 alpha:1.0f];
    solidColor1.topLayerOpacity = 0.40f;
    solidColor1.blendingMode = VnBlendingModeLighten;
    
    
    // Fill Layer
    VnFilterSolidColor* solidColor2 = [[VnFilterSolidColor alloc] init];
    [solidColor2 setColorRed:161.0f/255.0f green:135.0f/255.0f blue:105.0f/255.0 alpha:1.0f];
    solidColor2.topLayerOpacity = 0.15f;
    solidColor2.blendingMode = VnBlendingModeLighten;
    
    
    // Fill Layer
    VnAdjustmentLayerGradientColorFill* gradientColor1 = [[VnAdjustmentLayerGradientColorFill alloc] init];
    [gradientColor1 forceProcessingAtSize:self.imageSize];
    [gradientColor1 setStyle:GradientStyleRadial];
    [gradientColor1 setAngleDegree:0.0f];
    [gradientColor1 setScalePercent:124];
    [gradientColor1 setOffsetX:0.0f Y:0.0f];
    [gradientColor1 addColorRed:253.0f Green:253.0f Blue:253.0f Opacity:0.0f Location:0 Midpoint:50];
    [gradientColor1 addColorRed:187.0f Green:175.0f Blue:163.0f Opacity:100.0f Location:4096 Midpoint:50];
    gradientColor1.topLayerOpacity = 0.14f;
    gradientColor1.blendingMode = VnBlendingModeDifference;
    gradientColor1.addingX = self.addingX;
    gradientColor1.addingY = self.addingY;
    gradientColor1.multiplierX = self.multiplierX;
    gradientColor1.multiplierY = self.multiplierY;
    
    // Fill Layer
    
    VnAdjustmentLayerGradientColorFill* gradientColor2 = [[VnAdjustmentLayerGradientColorFill alloc] init];
    [gradientColor2 forceProcessingAtSize:self.imageSize];
    [gradientColor2 setStyle:GradientStyleRadial];
    [gradientColor2 setAngleDegree:0.0f];
    [gradientColor2 setScalePercent:119];
    [gradientColor2 setOffsetX:0.0f Y:0.0f];
    [gradientColor2 addColorRed:92.0f Green:69.0f Blue:54.0f Opacity:0.0f Location:0 Midpoint:50];
    [gradientColor2 addColorRed:0.0f Green:0.0f Blue:0.0f Opacity:100.0f Location:4096 Midpoint:50];
    gradientColor2.topLayerOpacity = 0.05f;
    gradientColor2.blendingMode = VnBlendingModeOverlay;
    gradientColor2.addingX = self.addingX;
    gradientColor2.addingY = self.addingY;
    gradientColor2.multiplierX = self.multiplierX;
    gradientColor2.multiplierY = self.multiplierY;
    
    
    // Levels
    VnFilterLevels* levelsFilter2 = [[VnFilterLevels alloc] init];
    [levelsFilter2 setMin:s255(16.0f) gamma:1.00f max:s255(255.0f) minOut:s255(0.0f) maxOut:s255(255.0f)];
    levelsFilter2.topLayerOpacity = 0.40f;
    levelsFilter2.blendingMode = VnBlendingModeScreen;
    
    
    // Levels
    VnFilterLevels* levelsFilter3 = [[VnFilterLevels alloc] init];
    [levelsFilter3 setMin:s255(40.0f) gamma:1.05f max:s255(247.0f) minOut:s255(0.0f) maxOut:s255(255.0f)];
    levelsFilter3.topLayerOpacity = 0.80f;
    
    self.startFilter = levelsFilter1;
    [levelsFilter1 addTarget:photoFilter1];
    [photoFilter1 addTarget:solidColor1];
    [solidColor1 addTarget:solidColor2];
    [solidColor2 addTarget:gradientColor1];
    [gradientColor1 addTarget:gradientColor2];
    [gradientColor2 addTarget:levelsFilter2];
    [levelsFilter2 addTarget:levelsFilter3];
    self.endFilter = levelsFilter3;
}

@end
