//
//  VnEffectOverlayLightBrightMatte.m
//  Pastel
//
//  Created by SSC on 2014/05/04.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectOverlayLightBrightMatte.h"

@implementation VnEffectOverlayLightBrightMatte

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
    
    // Levels
    VnFilterLevels* levelsFilter1 = [[VnFilterLevels alloc] init];
    [levelsFilter1 setMin:s255(13.0f) gamma:1.00f max:s255(255.0f) minOut:s255(0.0f) maxOut:s255(255.0f)];
    levelsFilter1.topLayerOpacity = 0.55f;
    levelsFilter1.blendingMode = VnBlendingModeScreen;
    
    // Levels
    VnFilterLevels* levelsFilter2 = [[VnFilterLevels alloc] init];
    [levelsFilter2 setMin:s255(40.0f) gamma:1.05f max:s255(250.0f) minOut:s255(0.0f) maxOut:s255(255.0f)];
    levelsFilter2.topLayerOpacity = 0.60f;
    
    // Photo Filter
    VnAdjustmentLayerPhotoFilter* photoFilter = [[VnAdjustmentLayerPhotoFilter alloc] init];
    photoFilter.color = (GPUVector3){s255(236.0f), s255(138.0f), 0.0f};
    photoFilter.density = 0.25f;
    photoFilter.preserveLuminosity = YES;
    photoFilter.topLayerOpacity = 0.22f;
    
    // Gradient Map
    VnAdjustmentLayerGradientMap* gradientMap = [[VnAdjustmentLayerGradientMap alloc] init];
    [gradientMap addColorRed:38.0f Green:38.0f Blue:38.0f Opacity:100.0f Location:0 Midpoint:50];
    [gradientMap addColorRed:228.0f Green:227.0f Blue:226.0f Opacity:100.0f Location:4096 Midpoint:50];
    gradientMap.topLayerOpacity = 0.60f;
    gradientMap.blendingMode = VnBlendingModeLuminotisy;
    
    // Fill Layer
    VnFilterSolidColor* solidColor = [[VnFilterSolidColor alloc] init];
    [solidColor setColorRed:s255(243.0f) green:s255(238.0f) blue:s255(230.0f) alpha:1.0f];
    solidColor.topLayerOpacity = 0.20f;
    solidColor.blendingMode = VnBlendingModeMultiply;
    
    // Curve
    VnFilterPassThrough* curveInput = [[VnFilterPassThrough alloc] init];
    VnImageNormalBlendFilter* curveMerge = [[VnImageNormalBlendFilter alloc] init];
    VnFilterToneCurve* curveFilter = [[VnFilterToneCurve alloc] initWithACV:@"olbm"];
    curveMerge.topLayerOpacity = 0.20f;
    
    self.startFilter = levelsFilter1;
    [levelsFilter1 addTarget:levelsFilter2];
    [levelsFilter2 addTarget:photoFilter];
    [photoFilter addTarget:gradientMap];
    [gradientMap addTarget:solidColor];
    [solidColor addTarget:curveInput];
    [curveInput addTarget:curveMerge];
    [curveInput addTarget:curveFilter];
    [curveFilter addTarget:curveMerge atTextureLocation:1];
    self.endFilter = curveMerge;
}

@end
