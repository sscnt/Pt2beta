//
//  GPUEffectDreamyVintage.m
//  Gravy_1.0
//
//  Created by SSC on 2013/12/15.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "VnEffectDreamyVintage.h"

@implementation VnEffectDreamyVintage

- (id)init
{
    self = [super init];
    if(self){
        self.defaultOpacity = 0.80f;
        self.faceOpacity = 0.60f;
        self.effectId = VnEffectIdDreamyVintage;
    }
    return self;
}

- (void)makeFilterGroup
{
    
    // Gradient Map
    VnAdjustmentLayerGradientMap* gradientMap = [[VnAdjustmentLayerGradientMap alloc] init];
    [gradientMap addColorRed:111.0f Green:21.0f Blue:108.0f Opacity:100.0f Location:0 Midpoint:50];
    [gradientMap addColorRed:253.0f Green:124.0f Blue:0.0f Opacity:100.0f Location:4096 Midpoint:50];
    gradientMap.blendingMode = VnBlendingModeSoftLight;
    
    // Saturation
    VnAdjustmentLayerHueSaturation* saturationFilter = [[VnAdjustmentLayerHueSaturation alloc] init];
    saturationFilter.saturation = -10.0f;
    
    // Curve
    VnFilterToneCurve* curveFilter = [[VnFilterToneCurve alloc] initWithACV:@"ar001"];
    
    // Levels
    VnFilterLevels* levelsFilter1 = [[VnFilterLevels alloc] init];
    [levelsFilter1 setMin:s255(0.0f) gamma:0.90f max:s255(255.0f) minOut:s255(0.0f) maxOut:s255(255.0f)];
    levelsFilter1.topLayerOpacity = 1.0f;
    levelsFilter1.blendingMode = VnBlendingModeSoftLight;
    
    self.startFilter = gradientMap;
    [gradientMap addTarget:saturationFilter];
    [saturationFilter addTarget:curveFilter];
    [curveFilter addTarget:levelsFilter1];
    self.endFilter = levelsFilter1;
}

@end
