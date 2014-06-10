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
    VnFilterPassThrough* curveInput1 = [[VnFilterPassThrough alloc] init];
    VnImageNormalBlendFilter* curveMerge1 = [[VnImageNormalBlendFilter alloc] init];
    VnFilterToneCurve* curveFilter1 = [[VnFilterToneCurve alloc] initWithACV:@"vvv1"];
    curveMerge1.topLayerOpacity = 0.50f;
    
    // Gradient Map
    VnAdjustmentLayerGradientMap* gradientMap1 = [[VnAdjustmentLayerGradientMap alloc] init];
    [gradientMap1 addColorRed:66.0f Green:66.0f Blue:66.0f Opacity:100.0f Location:0 Midpoint:50];
    [gradientMap1 addColorRed:6.0f Green:61.0f Blue:82.0f Opacity:100.0f Location:4096 Midpoint:50];
    gradientMap1.topLayerOpacity = 0.70f;
    gradientMap1.blendingMode = VnBlendingModeExclusion;
    
    // Curve
    VnFilterPassThrough* curveInput2 = [[VnFilterPassThrough alloc] init];
    VnImageNormalBlendFilter* curveMerge2 = [[VnImageNormalBlendFilter alloc] init];
    VnFilterToneCurve* curveFilter2 = [[VnFilterToneCurve alloc] initWithACV:@"vvv2"];
    curveMerge2.topLayerOpacity = 0.75f;
    
    // Curve
    VnFilterPassThrough* curveInput3 = [[VnFilterPassThrough alloc] init];
    VnImageNormalBlendFilter* curveMerge3 = [[VnImageNormalBlendFilter alloc] init];
    VnFilterToneCurve* curveFilter3 = [[VnFilterToneCurve alloc] initWithACV:@"vvv3"];
    curveMerge3.topLayerOpacity = 0.50f;
    curveMerge3.blendingMode = VnBlendingModeSoftLight;
    
    self.startFilter = curveInput1;
    [curveInput1 addTarget:curveMerge1];
    [curveInput1 addTarget:curveFilter1];
    [curveFilter1 addTarget:curveMerge1 atTextureLocation:1];
    [curveMerge1 addTarget:gradientMap1];
    [gradientMap1 addTarget:curveInput2];
    [curveInput2 addTarget:curveMerge2];
    [curveInput2 addTarget:curveFilter2];
    [curveFilter2 addTarget:curveMerge2 atTextureLocation:1];
    [curveMerge2 addTarget:curveInput3];
    [curveInput3 addTarget:curveMerge3];
    [curveInput3 addTarget:curveFilter3];
    [curveFilter3 addTarget:curveMerge3 atTextureLocation:1];
    self.endFilter = curveMerge3;
    
    
    
}

@end
