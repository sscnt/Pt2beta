//
//  VnEffectRetroVintage.m
//  Pastel2
//
//  Created by SSC on 2014/06/14.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectRetroVintage.h"

@implementation VnEffectRetroVintage

- (id)init
{
    self = [super init];
    if(self){
        self.effectId = VnEffectIdVintageFilm;
    }
    return self;
}

- (void)makeFilterGroup
{
    
    //// Lighten
    VnFilterDuplicate* lightenFilter = [[VnFilterDuplicate alloc] init];
    lightenFilter.topLayerOpacity = 0.70f;
    lightenFilter.blendingMode = VnBlendingModeScreen;
    
    // Levels
    VnFilterPassThrough* levelsInput = [[VnFilterPassThrough alloc] init];
    VnImageNormalBlendFilter* levelsMerge = [[VnImageNormalBlendFilter alloc] init];
    levelsMerge.topLayerOpacity = 0.67f;
    
    VnFilterLevels* levelsFilter1 = [[VnFilterLevels alloc] init];
    [levelsFilter1 setRedMin:s255(60.0f) gamma:2.85 max:s255(231.0f) minOut:s255(42.0f) maxOut:1.0f];
    [levelsFilter1 setGreenMin:s255(0.0) gamma:1.47 max:s255(201) minOut:0.0f maxOut:s255(236.0f)];
    [levelsFilter1 setBlueMin:s255(0.0f) gamma:1.30f max:1.0f minOut:0.0f maxOut:s255(210.0f)];
    
    VnFilterLevels* levelsFilter2 = [[VnFilterLevels alloc] init];
    [levelsFilter2 setMin:s255(43.0f) gamma:0.74f max:s255(255.0f) minOut:0.0f maxOut:1.0f];
    
    // Hue / Saturation
    VnAdjustmentLayerHueSaturation* hueSaturation2 = [[VnAdjustmentLayerHueSaturation alloc] init];
    hueSaturation2.hue = 0.0f;
    hueSaturation2.saturation = 25.0f;
    hueSaturation2.lightness = 0.0f;
    hueSaturation2.colorize = YES;
    hueSaturation2.topLayerOpacity = 0.40f;
    
    
    // Gradient Map
    VnAdjustmentLayerGradientMap* gradientMap = [[VnAdjustmentLayerGradientMap alloc] init];
    [gradientMap addColorRed:45.0f Green:151.0f Blue:201.0f Opacity:100.0f Location:0 Midpoint:50];
    [gradientMap addColorRed:57.0f Green:196.0f Blue:191.0f Opacity:100.0f Location:4096 Midpoint:50];
    gradientMap.topLayerOpacity = 0.35f;
    gradientMap.blendingMode = VnBlendingModeSoftLight;
    
    // Fill Layer
    VnFilterSolidColor* solidColor1 = [[VnFilterSolidColor alloc] init];
    [solidColor1 setColorRed:53.0f/255.0f green:70.0f/255.0f blue:120.0f/255.0 alpha:1.0f];
    solidColor1.topLayerOpacity = 0.54f;
    solidColor1.blendingMode = VnBlendingModeExclusion;
    
    // Da Haze
    VnFilterPassThrough* inputFilter = [[VnFilterPassThrough alloc] init];
    VnImageNormalBlendFilter* inputMerge = [[VnImageNormalBlendFilter alloc] init];
    inputMerge.topLayerOpacity = 0.80f;
    inputMerge.blendingMode = VnBlendingModeSoftLight;
    
    self.startFilter = inputFilter;
    [inputFilter addTarget:lightenFilter];
    [lightenFilter addTarget:levelsInput];
    [levelsInput addTarget:levelsMerge];
    [levelsInput addTarget:levelsFilter1];
    [levelsFilter1 addTarget:levelsFilter2];
    [levelsFilter2 addTarget:levelsMerge atTextureLocation:1];
    [levelsMerge addTarget:hueSaturation2];
    [hueSaturation2 addTarget:gradientMap];
    [gradientMap addTarget:solidColor1];
    [solidColor1 addTarget:inputMerge];
    [inputFilter addTarget:inputMerge atTextureLocation:1];
    self.endFilter = inputMerge;

}

@end
