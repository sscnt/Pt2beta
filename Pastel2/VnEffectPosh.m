//
//  VnEffectPosh.m
//  Pastel2
//
//  Created by SSC on 2014/06/19.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectPosh.h"

@implementation VnEffectPosh

- (id)init
{
    self = [super init];
    if(self){
        self.effectId = VnEffectIdPosh;
    }
    return self;
}

- (void)makeFilterGroup
{
    // Input
    VnFilterPassThrough* inputFilter = [[VnFilterPassThrough alloc] init];
    VnImageNormalBlendFilter* inputMerge = [[VnImageNormalBlendFilter alloc] init];
    inputMerge.topLayerOpacity = 0.60f;
    inputMerge.blendingMode = VnBlendingModeSoftLight;
    
    // Levels
    VnFilterLevels* levelsFilter1 = [[VnFilterLevels alloc] init];
    [levelsFilter1 setMin:s255(34.0f) gamma:1.4f max:s255(221.0f)];
    levelsFilter1.topLayerOpacity = 0.40f;
    
    // Levels
    VnFilterLevels* levelsFilter2 = [[VnFilterLevels alloc] init];
    [levelsFilter2 setMin:s255(47.0f) gamma:1.37f max:s255(209.0f)];
    levelsFilter2.topLayerOpacity = 0.52f;
    
    // Fill Layer
    VnFilterSolidColor* solidColor1 = [[VnFilterSolidColor alloc] init];
    [solidColor1 setColorRed:229.0f/255.0f green:218.0f/255.0f blue:198.0f/255.0 alpha:1.0f];
    solidColor1.blendingMode = VnBlendingModeMultiply;
    solidColor1.topLayerOpacity = 0.15f;
    
    // Photo Filter
    VnAdjustmentLayerPhotoFilter* photoFilter1 = [[VnAdjustmentLayerPhotoFilter alloc] init];
    photoFilter1.color = (GPUVector3){s255(236.0f), s255(138.0f), 0.0f};
    photoFilter1.density = 0.20f;
    photoFilter1.preserveLuminosity = YES;
    photoFilter1.topLayerOpacity = 0.13f;
    
    // Fill Layer
    VnFilterSolidColor* solidColor2 = [[VnFilterSolidColor alloc] init];
    [solidColor2 setColorRed:36.0f/255.0f green:82.0f/255.0f blue:176.0f/255.0 alpha:1.0f];
    solidColor2.blendingMode = VnBlendingModeExclusion;
    solidColor2.topLayerOpacity = 0.20f;
    
    // Gradient Map
    VnAdjustmentLayerGradientMap* gradientMap1 = [[VnAdjustmentLayerGradientMap alloc] init];
    [gradientMap1 addColorRed:64.0f Green:104.0f Blue:186.0f Opacity:100.0f Location:0 Midpoint:50];
    [gradientMap1 addColorRed:124.0f Green:202.0f Blue:168.0f Opacity:100.0f Location:4096 Midpoint:50];
    gradientMap1.blendingMode = VnBlendingModeSoftLight;
    gradientMap1.topLayerOpacity = 0.25f;
    
    self.startFilter = inputFilter;
    [inputFilter addTarget:levelsFilter1];
    [inputFilter addTarget:inputMerge atTextureLocation:1];
    [levelsFilter1 addTarget:levelsFilter2];
    [levelsFilter2 addTarget:solidColor1];
    [solidColor1 addTarget:photoFilter1];
    [photoFilter1 addTarget:solidColor2];
    [solidColor2 addTarget:inputMerge atTextureLocation:0];
    [inputMerge addTarget:gradientMap1];
    self.endFilter = gradientMap1;
}

@end
