//
//  VnEffectColorOphelia.m
//  Pastel
//
//  Created by SSC on 2014/05/03.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectColorOphelia.h"

@implementation VnEffectColorOphelia

- (id)init
{
    self = [super init];
    if(self){
        self.effectId = VnEffectIdColorOphelia;
    }
    return self;
}

- (void)makeFilterGroup
{
    // Gradient Map
    VnAdjustmentLayerGradientMap* gradientMap1 = [[VnAdjustmentLayerGradientMap alloc] init];
    [gradientMap1 addColorRed:149.0f Green:23.0f Blue:112.0f Opacity:100.0f Location:0 Midpoint:50];
    [gradientMap1 addColorRed:234.0f Green:201.0f Blue:175.0f Opacity:100.0f Location:3829 Midpoint:50];
    [gradientMap1 addColorRed:234.0f Green:201.0f Blue:175.0f Opacity:100.0f Location:4096 Midpoint:50];
    gradientMap1.topLayerOpacity = 0.10f;
    gradientMap1.blendingMode = VnBlendingModeScreen;
    
    
    // Gradient Map
    VnAdjustmentLayerGradientMap* gradientMap2 = [[VnAdjustmentLayerGradientMap alloc] init];
    [gradientMap2 addColorRed:149.0f Green:23.0f Blue:112.0f Opacity:100.0f Location:0 Midpoint:50];
    [gradientMap2 addColorRed:234.0f Green:201.0f Blue:175.0f Opacity:100.0f Location:3829 Midpoint:50];
    [gradientMap2 addColorRed:234.0f Green:201.0f Blue:175.0f Opacity:100.0f Location:4096 Midpoint:50];
    gradientMap2.topLayerOpacity = 0.10f;
    gradientMap2.blendingMode = VnBlendingModeNormal;
    
    
    // Gradient Map
    VnAdjustmentLayerGradientMap* gradientMap3 = [[VnAdjustmentLayerGradientMap alloc] init];
    [gradientMap3 addColorRed:149.0f Green:23.0f Blue:112.0f Opacity:100.0f Location:0 Midpoint:50];
    [gradientMap3 addColorRed:234.0f Green:201.0f Blue:175.0f Opacity:100.0f Location:3829 Midpoint:50];
    [gradientMap3 addColorRed:234.0f Green:201.0f Blue:175.0f Opacity:100.0f Location:4096 Midpoint:50];
    gradientMap3.topLayerOpacity = 0.35f;
    gradientMap3.blendingMode = VnBlendingModeSoftLight;
    
    self.startFilter = gradientMap1;
    [gradientMap1 addTarget:gradientMap2];
    [gradientMap2 addTarget:gradientMap3];
    self.endFilter = gradientMap3;
    
    
}

@end
