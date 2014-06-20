//
//  VnEffectGentleColor.m
//  Pastel
//
//  Created by SSC on 2014/05/04.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectGentleColor.h"

@implementation VnEffectGentleColor

- (id)init
{
    self = [super init];
    if(self){
        self.effectId = VnEffectIdGentleColor;
    }
    return self;
}

- (void)makeFilterGroup
{
    {
        VnFilterLocalContrast* contrastFilter = [[VnFilterLocalContrast alloc] init];
        contrastFilter.blurRadiusInPixels = 40.0f;
        self.startFilter = self.endFilter = contrastFilter;
        return;
    }
    // Levels
    VnFilterLevels* levelsFilter1 = [[VnFilterLevels alloc] init];
    [levelsFilter1 setMin:s255(0.0f) gamma:0.92f max:s255(255.0f) minOut:s255(0.0f) maxOut:s255(255.0f)];
    levelsFilter1.topLayerOpacity = 0.15f;
    levelsFilter1.blendingMode = VnBlendingModeScreen;
    
    // Levels
    VnFilterLevels* levelsFilter2 = [[VnFilterLevels alloc] init];
    [levelsFilter2 setMin:s255(0.0f) gamma:0.92f max:s255(255.0f) minOut:s255(0.0f) maxOut:s255(255.0f)];
    levelsFilter2.topLayerOpacity = 0.60f;
    levelsFilter2.blendingMode = VnBlendingModeSoftLight;
    
    
    // Photo Filter
    VnAdjustmentLayerPhotoFilter* photoFilter = [[VnAdjustmentLayerPhotoFilter alloc] init];
    photoFilter.color = (GPUVector3){s255(236.0f), s255(138.0f), 0.0f};
    photoFilter.density = 0.50f;
    photoFilter.preserveLuminosity = YES;
    photoFilter.topLayerOpacity = 0.05f;
    
    
    
    // Hue/Saturation
    VnAdjustmentLayerHueSaturation* hueSaturation = [[VnAdjustmentLayerHueSaturation alloc] init];
    hueSaturation.hue = 0.0f;
    hueSaturation.saturation = 25;
    hueSaturation.lightness = 0.0f;
    hueSaturation.colorize = NO;
    hueSaturation.topLayerOpacity = 0.30f;
    hueSaturation.blendingMode = VnBlendingModeSoftLight;

    self.startFilter = levelsFilter1;
    [levelsFilter1 addTarget:levelsFilter2];
    [levelsFilter2 addTarget:photoFilter];
    [photoFilter addTarget:hueSaturation];
    self.endFilter = hueSaturation;
}

@end
