//
//  VnEffectOverlayPeachHaze.m
//  Pastel2
//
//  Created by SSC on 2014/06/19.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectOverlayPeachHaze.h"

@implementation VnEffectOverlayPeachHaze

- (id)init
{
    self = [super init];
    if(self){
        self.defaultOpacity = 0.8f;
        self.effectId = VnEffectIdOverlayPeachHaze;
    }
    return self;
}

- (void)makeFilterGroup
{
    
    // Fill Layer
    VnFilterSolidColor* solidColor1 = [[VnFilterSolidColor alloc] init];
    [solidColor1 setColorRed:s255(245.0f) green:s255(178.0f) blue:s255(167.0f) alpha:1.0f];
    solidColor1.blendingMode = VnBlendingModeDifference;
    solidColor1.topLayerOpacity = 0.10f;
    
    // Gradient Map
    VnAdjustmentLayerGradientMap* gradientMap1 = [[VnAdjustmentLayerGradientMap alloc] init];
    [gradientMap1 addColorRed:6.0f Green:64.0f Blue:89.0f Opacity:100.0f Location:0 Midpoint:50];
    [gradientMap1 addColorRed:2.0f Green:36.0f Blue:51.0f Opacity:100.0f Location:4096 Midpoint:50];
    gradientMap1.topLayerOpacity = 0.70f;
    gradientMap1.blendingMode = VnBlendingModeExclusion;

    self.startFilter = solidColor1;
    [solidColor1 addTarget:gradientMap1];
    self.endFilter = gradientMap1;
    
}

@end
