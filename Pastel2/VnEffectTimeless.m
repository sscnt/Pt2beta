//
//  VnEffectTimeless.m
//  Pastel2
//
//  Created by SSC on 2014/06/19.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectTimeless.h"

@implementation VnEffectTimeless

- (id)init
{
    self = [super init];
    if(self){
        self.effectId = VnEffectIdTimeless;
    }
    return self;
}

- (void)makeFilterGroup
{
    // Levels
    VnFilterLevels* levelsFilter1 = [[VnFilterLevels alloc] init];
    [levelsFilter1 setMin:s255(43.0f) gamma:1.85f max:s255(241.0f)];
    levelsFilter1.topLayerOpacity = 0.30f;
    
    // Fill Layer
    VnFilterSolidColor* solidColor1 = [[VnFilterSolidColor alloc] init];
    [solidColor1 setColorRed:233.0f/255.0f green:224.0f/255.0f blue:203.0f/255.0 alpha:1.0f];
    solidColor1.blendingMode = VnBlendingModeSoftLight;
    solidColor1.topLayerOpacity = 0.30f;
    
    // Gradient Map
    VnAdjustmentLayerGradientMap* gradientMap1 = [[VnAdjustmentLayerGradientMap alloc] init];
    [gradientMap1 addColorRed:46.0f Green:44.0f Blue:40.0f Opacity:100.0f Location:0 Midpoint:50];
    [gradientMap1 addColorRed:243.0f Green:233.0f Blue:233.0f Opacity:100.0f Location:4096 Midpoint:50];
    gradientMap1.blendingMode = VnBlendingModeSoftLight;
    gradientMap1.topLayerOpacity = 0.30f;
    
    // Levels
    VnFilterLevels* levelsFilter2 = [[VnFilterLevels alloc] init];
    [levelsFilter2 setMin:s255(46.0f) gamma:1.21 max:s255(186.0f)];
    levelsFilter2.topLayerOpacity = 0.25f;
    levelsFilter2.blendingMode = VnBlendingModeLuminotisy;
    
    // Hue / Saturation
    VnAdjustmentLayerHueSaturation* hueSaturation = [[VnAdjustmentLayerHueSaturation alloc] init];
    hueSaturation.hue = 0.0f;
    hueSaturation.saturation = 10.0f;
    hueSaturation.lightness = 0.0f;
    hueSaturation.colorize = NO;
    
    // Photo Filter
    VnAdjustmentLayerPhotoFilter* photoFilter1 = [[VnAdjustmentLayerPhotoFilter alloc] init];
    photoFilter1.color = (GPUVector3){s255(254.0f), s255(177.0f), s255(121.0f)};
    photoFilter1.density = 0.1f;
    photoFilter1.preserveLuminosity = YES;
    photoFilter1.topLayerOpacity = 0.20f;
    
    // Levels
    VnFilterPassThrough* levelsInput = [[VnFilterPassThrough alloc] init];
    VnImageNormalBlendFilter* levelsMerge = [[VnImageNormalBlendFilter alloc] init];
    levelsMerge.topLayerOpacity = 1.0;
    
    VnFilterLevels* levelsFilter3 = [[VnFilterLevels alloc] init];
    [levelsFilter3 setRedMin:0.0f gamma:1.00f max:s255(252.0f) minOut:0.0f maxOut:1.0f];
    [levelsFilter3 setGreenMin:0.0f gamma:1.00f max:s255(249.0f) minOut:0.0f maxOut:s255(240.0)];
    [levelsFilter3 setBlueMin:s255(7.0f) gamma:1.01 max:s255(253.0f) minOut:s255(5.0f) maxOut:s255(210.0f)];
    
    VnFilterLevels* levelsFilter4 = [[VnFilterLevels alloc] init];
    [levelsFilter4 setMin:s255(0.0f) gamma:1.4f max:s255(255.0f)];
    
    self.startFilter = levelsFilter1;
    [levelsFilter1 addTarget:solidColor1];
    [solidColor1 addTarget:gradientMap1];
    [gradientMap1 addTarget:levelsFilter2];
    [levelsFilter2 addTarget:hueSaturation];
    [hueSaturation addTarget:photoFilter1];
    [photoFilter1 addTarget:levelsInput];
    [levelsInput addTarget:levelsFilter3];
    [levelsInput addTarget:levelsMerge atTextureLocation:0];
    [levelsFilter3 addTarget:levelsFilter4];
    [levelsFilter4 addTarget:levelsMerge atTextureLocation:1];
    self.endFilter = levelsMerge;
}

@end
