//
//  VnEffectBlush.m
//  Pastel2
//
//  Created by SSC on 2014/06/19.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectBlush.h"

@implementation VnEffectBlush

- (id)init
{
    self = [super init];
    if(self){
        self.effectId = VnEffectIdBlush;
    }
    return self;
}

- (void)makeFilterGroup
{
    // Input
    VnFilterPassThrough* inputFilter = [[VnFilterPassThrough alloc] init];
    VnImageNormalBlendFilter* inputMerge = [[VnImageNormalBlendFilter alloc] init];
    inputMerge.topLayerOpacity = 0.50f;
    inputMerge.blendingMode = VnBlendingModeSoftLight;
    
    // Lighten
    VnFilterDuplicate* lightenFilter = [[VnFilterDuplicate alloc] init];
    lightenFilter.blendingMode = VnBlendingModeScreen;
    lightenFilter.topLayerOpacity = 0.10f;
    
    // Levels
    VnFilterLevels* levelsFilter1 = [[VnFilterLevels alloc] init];
    [levelsFilter1 setRedMin:0.0f gamma:1.0f max:s255(240.0f) minOut:s255(15.0f) maxOut:1.0f];
    [levelsFilter1 setGreenMin:0.0f gamma:0.95f max:1.0f minOut:0.0f maxOut:1.0f];
    [levelsFilter1 setBlueMin:0.0f gamma:1.14f max:1.0f minOut:0.0f maxOut:s255(220.0f)];
    
    // Levels
    VnFilterLevels* levelsFilter2 = [[VnFilterLevels alloc] init];
    [levelsFilter2 setMin:s255(20.0f) gamma:1.14f max:s255(255.0f) minOut:s255(40.0f) maxOut:s255(230.0f)];
    
    // Levels
    VnFilterLevels* levelsFilter3 = [[VnFilterLevels alloc] init];
    [levelsFilter3 setMin:s255(66.0f) gamma:1.74f max:s255(215.0f)];
    levelsFilter3.blendingMode = VnBlendingModeLuminotisy;
    levelsFilter3.topLayerOpacity = 0.71f;
    
    // Gradient Map
    VnAdjustmentLayerGradientMap* gradientMap1 = [[VnAdjustmentLayerGradientMap alloc] init];
    [gradientMap1 addColorRed:15.0f Green:149.0f Blue:193.0f Opacity:100.0f Location:0 Midpoint:50];
    [gradientMap1 addColorRed:11.0f Green:86.0f Blue:189.0f Opacity:100.0f Location:4096 Midpoint:50];
    gradientMap1.blendingMode = VnBlendingModeExclusion;
    gradientMap1.topLayerOpacity = 0.20f;
    
    // Gradient Map
    VnAdjustmentLayerGradientMap* gradientMap2 = [[VnAdjustmentLayerGradientMap alloc] init];
    [gradientMap2 addColorRed:0.0f Green:0.0f Blue:0.0f Opacity:100.0f Location:0 Midpoint:50];
    [gradientMap2 addColorRed:255.0f Green:255.0f Blue:255.0f Opacity:100.0f Location:4096 Midpoint:50];
    gradientMap2.blendingMode = VnBlendingModeSoftLight;
    gradientMap2.topLayerOpacity = 0.20f;
    
    self.startFilter = inputFilter;
    [inputFilter addTarget:lightenFilter];
    [inputFilter addTarget:inputMerge atTextureLocation:1];
    [lightenFilter addTarget:levelsFilter1];
    [levelsFilter1 addTarget:levelsFilter2];
    [levelsFilter2 addTarget:levelsFilter3];
    [levelsFilter3 addTarget:gradientMap1];
    [gradientMap1 addTarget:inputMerge atTextureLocation:0];
    [inputMerge addTarget:gradientMap2];
    self.endFilter = gradientMap2;
    
}

@end
