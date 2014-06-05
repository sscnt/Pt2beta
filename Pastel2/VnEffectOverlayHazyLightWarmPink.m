//
//  VnEffectOverlayHazyLightWarmPink.m
//  Pastel
//
//  Created by SSC on 2014/05/06.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectOverlayHazyLightWarmPink.h"

@implementation VnEffectOverlayHazyLightWarmPink

- (id)init
{
    self = [super init];
    if(self){
        self.defaultOpacity = 0.60f;
        self.faceOpacity = 0.60f;
        self.effectId = VnEffectIdOverlayHazyLightWarmPink;
    }
    return self;
}

- (void)makeFilterGroup
{
    // Gradient Map
    VnAdjustmentLayerGradientColorFill* gradientColor = [[VnAdjustmentLayerGradientColorFill alloc] init];
    [gradientColor forceProcessingAtSize:self.imageSize];
    [gradientColor setStyle:GradientStyleLinear];
    [gradientColor setAngleDegree:-110.0f];
    [gradientColor setScalePercent:101];
    [gradientColor setOffsetX:0.0f Y:0.0f];
    [gradientColor addColorRed:253.0f Green:210.0f Blue:128.0f Opacity:100.0f Location:0 Midpoint:50];
    [gradientColor addColorRed:249.0f Green:102.0f Blue:102.0f Opacity:100.0f Location:2159 Midpoint:50];
    [gradientColor addColorRed:253.0f Green:223.0f Blue:207.0f Opacity:0.0f Location:4096 Midpoint:50];
    gradientColor.blendingMode = VnBlendingModeScreen;
    
    self.startFilter = gradientColor;
    self.endFilter = gradientColor;
}

@end
