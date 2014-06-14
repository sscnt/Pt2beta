//
//  VnEffectColorVintageMatte.m
//  Pastel
//
//  Created by SSC on 2014/05/03.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectColorVintageMatte.h"

@implementation VnEffectColorVintageMatte

- (id)init
{
    self = [super init];
    if(self){
        self.effectId = VnEffectIdColorVintageMatte;
    }
    return self;
}

- (void)makeFilterGroup
{
    
    
    VnFilterDuplicate* inputFilter = [[VnFilterDuplicate alloc] init];
    GPUImageNormalBlendFilter* normalFilter = [[GPUImageNormalBlendFilter alloc] init];
    GPUImageOpacityFilter* opacity = [[GPUImageOpacityFilter alloc] init];
    opacity.opacity = 0.70f;
    
    // Levels
    VnFilterLevels* levelsFilter1 = [[VnFilterLevels alloc] init];
    [levelsFilter1 setRedMin:s255(6.0f) gamma:1.13f max:s255(252.0f) minOut:s255(15.0f) maxOut:s255(255.0f)];
    [levelsFilter1 setGreenMin:s255(3.0f) gamma:1.0f max:s255(254.0f) minOut:s255(0.0f) maxOut:s255(255.0f)];
    [levelsFilter1 setBlueMin:s255(15.0f) gamma:0.98f max:s255(255.0f) minOut:s255(28.0f) maxOut:s255(230.0f)];
    
    // Levels
    VnFilterLevels* levelsFilter2 = [[VnFilterLevels alloc] init];
    [levelsFilter2 setMin:s255(15.0f) gamma:1.05f max:s255(253.0f) minOut:s255(20.0f) maxOut:s255(245.0f)];
    
    // Gradient Map
    VnAdjustmentLayerGradientMap* gradientMap = [[VnAdjustmentLayerGradientMap alloc] init];
    [gradientMap addColorRed:0.0f Green:0.0f Blue:0.0f Opacity:100.0f Location:0 Midpoint:50];
    [gradientMap addColorRed:229.0f Green:229.0f Blue:229.0f Opacity:100.0f Location:4096 Midpoint:50];
    gradientMap.blendingMode = VnBlendingModeLuminotisy;
    gradientMap.topLayerOpacity = 0.60f;
    
    // Curve
    VnFilterToneCurve* curveFilter = [[VnFilterToneCurve alloc] initWithACV:@"an001"];
    curveFilter.topLayerOpacity = 0.85f;
    
    self.startFilter = inputFilter;
    [inputFilter addTarget:normalFilter];
    [inputFilter addTarget:levelsFilter1];
    [levelsFilter1 addTarget:levelsFilter2];
    [levelsFilter2 addTarget:opacity];
    [opacity addTarget:normalFilter atTextureLocation:1];
    [normalFilter addTarget:gradientMap];
    [gradientMap addTarget:curveFilter];
    self.endFilter = curveFilter;
    
}

@end
