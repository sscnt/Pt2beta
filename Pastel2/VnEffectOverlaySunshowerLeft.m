//
//  VnEffectOverlaySunshowerLeft.m
//  Pastel2
//
//  Created by SSC on 2014/06/17.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectOverlaySunshowerLeft.h"

@implementation VnEffectOverlaySunshowerLeft

- (id)init
{
    self = [super init];
    if(self){
        self.defaultOpacity = 0.70f;
        self.effectId = VnEffectIdOverlaySunshowerLeft;
    }
    return self;
}

- (void)makeFilterGroup
{
    
    // Fill Layer
    VnAdjustmentLayerGradientColorFill* gradientColor1 = [[VnAdjustmentLayerGradientColorFill alloc] initWithEffectObj:self];
    [gradientColor1 setStyle:GradientStyleLinear];
    [gradientColor1 setAngleDegree:-45];
    [gradientColor1 setScalePercent:150];
    [gradientColor1 setOffsetX:15 Y:10];
    [gradientColor1 addColorRed:250.0f Green:248.0f Blue:242.0f Opacity:100 Location:0 Midpoint:50];
    [gradientColor1 addColorRed:239.0f Green:196.0f Blue:168.0f Opacity:80 Location:2048 Midpoint:50];
    [gradientColor1 addColorRed:239.0f Green:196.0f Blue:168.0f Opacity:0 Location:4096 Midpoint:50];
    gradientColor1.blendingMode = VnBlendingModeHardLight;
    
    self.startFilter = self.endFilter = gradientColor1;
}

@end
