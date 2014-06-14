//
//  VnEffectVividVintage.m
//  Pastel2
//
//  Created by SSC on 2014/06/11.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectVividVintage.h"

@implementation VnEffectVividVintage

- (id)init
{
    self = [super init];
    if(self){
        self.effectId = VnEffectIdVividVintage;
    }
    return self;
}

- (void)makeFilterGroup
{
    
    // Curve
    VnFilterToneCurve* curveFilter1 = [[VnFilterToneCurve alloc] initWithACV:@"ad001"];
    curveFilter1.topLayerOpacity = 0.50f;
    
    // Gradient Map
    VnAdjustmentLayerGradientMap* gradientMap1 = [[VnAdjustmentLayerGradientMap alloc] init];
    [gradientMap1 addColorRed:66.0f Green:66.0f Blue:66.0f Opacity:100.0f Location:0 Midpoint:50];
    [gradientMap1 addColorRed:6.0f Green:61.0f Blue:82.0f Opacity:100.0f Location:4096 Midpoint:50];
    gradientMap1.topLayerOpacity = 0.70f;
    gradientMap1.blendingMode = VnBlendingModeExclusion;
    
    // Curve
    VnFilterToneCurve* curveFilter2 = [[VnFilterToneCurve alloc] initWithACV:@"ad002"];
    curveFilter2.topLayerOpacity = 0.75f;
    
    // Curve
    VnFilterToneCurve* curveFilter3 = [[VnFilterToneCurve alloc] initWithACV:@"ad003"];
    curveFilter3.topLayerOpacity = 0.50f;
    curveFilter3.blendingMode = VnBlendingModeSoftLight;
    
    self.startFilter = curveFilter1;
    [curveFilter1 addTarget:gradientMap1];
    [gradientMap1 addTarget:curveFilter2];
    [curveFilter2 addTarget:curveFilter3];
    self.endFilter = curveFilter3;
    
    
    
}

@end
