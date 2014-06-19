//
//  VnEffectLume.m
//  Pastel2
//
//  Created by SSC on 2014/06/19.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectLume.h"

@implementation VnEffectLume

- (id)init
{
    self = [super init];
    if(self){
        self.effectId = VnEffectIdLume;
    }
    return self;
}

- (void)makeFilterGroup
{
    
    // Lighten
    VnFilterDuplicate* lightenFilter = [[VnFilterDuplicate alloc] init];
    lightenFilter.blendingMode = VnBlendingModeScreen;
    lightenFilter.topLayerOpacity = 0.10f;
    
    // Fill Layer
    VnFilterSolidColor* solidColor1 = [[VnFilterSolidColor alloc] init];
    [solidColor1 setColorRed:241.0f/255.0f green:229.0f/255.0f blue:216.0f/255.0 alpha:1.0f];
    solidColor1.blendingMode = VnBlendingModeSoftLight;
    solidColor1.topLayerOpacity = 0.40f;
    
    // Gradient Map
    VnAdjustmentLayerGradientMap* gradientMap1 = [[VnAdjustmentLayerGradientMap alloc] init];
    [gradientMap1 addColorRed:0.0f Green:0.0f Blue:0.0f Opacity:100.0f Location:0 Midpoint:50];
    [gradientMap1 addColorRed:255.0f Green:255.0f Blue:255.0f Opacity:100.0f Location:4096 Midpoint:50];
    gradientMap1.blendingMode = VnBlendingModeSoftLight;
    gradientMap1.topLayerOpacity = 0.40f;
    
    // Levels
    VnFilterLevels* levelsFilter1 = [[VnFilterLevels alloc] init];
    [levelsFilter1 setMin:s255(18.0f) gamma:1.30f max:s255(217.0f)];
    levelsFilter1.blendingMode = VnBlendingModeOverlay;
    levelsFilter1.topLayerOpacity = 0.40f;
    
    // Levels
    VnFilterLevels* levelsFilter2 = [[VnFilterLevels alloc] init];
    [levelsFilter2 setMin:s255(0.0f) gamma:1.0f max:s255(255.0f)];
    [levelsFilter2 setRedMin:0.0f gamma:1.12f max:s255(240.0f) minOut:0.0f maxOut:1.0f];
    levelsFilter2.topLayerOpacity = 0.15f;
    
    // Levels
    VnFilterLevels* levelsFilter3 = [[VnFilterLevels alloc] init];
    [levelsFilter3 setMin:s255(53.0f) gamma:1.14f max:s255(255.0f)];
    levelsFilter3.blendingMode = VnBlendingModeLuminotisy;
    levelsFilter3.topLayerOpacity = 0.50f;
    
    self.startFilter = lightenFilter;
    [lightenFilter addTarget:solidColor1];
    [solidColor1 addTarget:gradientMap1];
    [gradientMap1 addTarget:levelsFilter1];
    [levelsFilter1 addTarget:levelsFilter2];
    [levelsFilter2 addTarget:levelsFilter3];
    self.endFilter = levelsFilter3;
    
}

@end
