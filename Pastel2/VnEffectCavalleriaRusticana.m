//
//  GPUEffectCavalleriaRusticana.m
//  Gravy_1.0
//
//  Created by SSC on 2013/12/15.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "VnEffectCavalleriaRusticana.h"

@implementation VnEffectCavalleriaRusticana

- (id)init
{
    self = [super init];
    if(self){
        self.defaultOpacity = 0.90f;
        self.faceOpacity = 0.60f;
        self.effectId = VnEffectIdCavalleriaRusticana;
    }
    return self;
}

- (void)makeFilterGroup
{
    // Curve
    VnFilterToneCurve* curveFilter1 = [[VnFilterToneCurve alloc] initWithACV:@"cr1"];
    
    
    // Fill Layer
    VnFilterSolidColor* solidColor = [[VnFilterSolidColor alloc] init];
    [solidColor setColorRed:7.0f/255.0f green:37.0f/255.0f blue:61.0f/255.0 alpha:1.0f];
    solidColor.blendingMode = VnBlendingModeExclusion;
    
    
    // Hue / Saturation
    VnAdjustmentLayerHueSaturation* hueSaturation = [[VnAdjustmentLayerHueSaturation alloc] init];
    hueSaturation.hue = 216.0f;
    hueSaturation.saturation = 25.0f;
    hueSaturation.lightness = 0.0f;
    hueSaturation.colorize = YES;
    hueSaturation.blendingMode = VnBlendingModeSoftLight;
    
    self.startFilter = curveFilter1;
    [curveFilter1 addTarget:solidColor];
    [solidColor addTarget:hueSaturation];
    self.endFilter = hueSaturation;
}

@end
