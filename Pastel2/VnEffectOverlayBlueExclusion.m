//
//  VnEffectOverlayBlueExclusion.m
//  Pastel2
//
//  Created by SSC on 2014/06/18.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectOverlayBlueExclusion.h"

@implementation VnEffectOverlayBlueExclusion

- (id)init
{
    self = [super init];
    if(self){
        self.effectId = VnEffectIdOverlayBlueExclusion;
    }
    return self;
}

- (void)makeFilterGroup
{
    
    // Gradient Map
    VnAdjustmentLayerGradientMap* gradientMap1 = [[VnAdjustmentLayerGradientMap alloc] init];
    [gradientMap1 addColorRed:9.0f Green:35.0f Blue:71.0f Opacity:100.0f Location:0 Midpoint:50];
    [gradientMap1 addColorRed:26.0f Green:26.0f Blue:26.0f Opacity:100.0f Location:4096 Midpoint:50];
    gradientMap1.blendingMode = VnBlendingModeExclusion;
    
    self.startFilter = self.endFilter = gradientMap1;
    
}

@end
