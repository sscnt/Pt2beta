//
//  VnEffectOverlayFeelsLikeHome.m
//  Pastel2
//
//  Created by SSC on 2014/06/17.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectOverlayFeelsLikeHome.h"

@implementation VnEffectOverlayFeelsLikeHome

- (id)init
{
    self = [super init];
    if(self){
        self.effectId = VnEffectIdOverlayFeelsLikeHome;
    }
    return self;
}

- (void)makeFilterGroup
{
    // Fill Layer
    VnAdjustmentLayerGradientColorFill* gradientColor1 = [[VnAdjustmentLayerGradientColorFill alloc] initWithEffectObj:self];
    [gradientColor1 setStyle:GradientStyleLinear];
    [gradientColor1 setAngleDegree:-131];
    [gradientColor1 setScalePercent:66];
    [gradientColor1 setOffsetX:0.0f Y:0.0f];
    [gradientColor1 addColorRed:255.0f Green:159.0f Blue:65.0f Opacity:100 Location:0 Midpoint:50];
    [gradientColor1 addColorRed:251.0 Green:230.0f Blue:180.0f Opacity:100 Location:4096 Midpoint:50];
    gradientColor1.topLayerOpacity = 0.25f;
    gradientColor1.blendingMode = VnBlendingModeSoftLight;
    
    // Fill Layer
    VnAdjustmentLayerGradientColorFill* gradientColor2 = [[VnAdjustmentLayerGradientColorFill alloc] initWithEffectObj:self];
    [gradientColor2 setStyle:GradientStyleRadial];
    [gradientColor2 setAngleDegree:-131];
    [gradientColor2 setScalePercent:150];
    [gradientColor2 setOffsetX:-30 Y:-34];
    [gradientColor2 addColorRed:255.0f Green:64.0f Blue:64.0f Opacity:100 Location:0 Midpoint:50];
    [gradientColor2 addColorRed:255.0f Green:64.0f Blue:64.0f Opacity:0 Location:4096 Midpoint:50];
    gradientColor2.blendingMode = VnBlendingModeScreen;
    gradientColor2.topLayerOpacity = 0.31f;

    // Fill Layer
    VnAdjustmentLayerGradientColorFill* gradientColor3 = [[VnAdjustmentLayerGradientColorFill alloc] initWithEffectObj:self];
    [gradientColor3 setStyle:GradientStyleLinear];
    [gradientColor3 setAngleDegree:-131];
    [gradientColor3 setScalePercent:100];
    [gradientColor3 setOffsetX:0 Y:0];
    [gradientColor3 addColorRed:241.0f Green:252.0f Blue:121.0f Opacity:100 Location:0 Midpoint:50];
    [gradientColor3 addColorRed:241.0f Green:252.0f Blue:121.0f Opacity:0 Location:4096 Midpoint:50];
    gradientColor3.topLayerOpacity = 0.12f;
    gradientColor3.blendingMode = VnBlendingModeScreen;
    
    self.startFilter = gradientColor1;
    [gradientColor1 addTarget:gradientColor2];
    [gradientColor2 addTarget:gradientColor3];
    self.endFilter = gradientColor3;
}

@end
