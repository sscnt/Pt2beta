//
//  VnEffectVogue.m
//  Pastel2
//
//  Created by SSC on 2014/06/17.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectVogue.h"

@implementation VnEffectVogue

- (id)init
{
    self = [super init];
    if(self){
        self.defaultOpacity = 0.70f;
        self.effectId = VnEffectIdVogue;
    }
    return self;
}

- (void)makeFilterGroup
{
    // Curve
    VnFilterToneCurve* curveFilter1 = [[VnFilterToneCurve alloc] initWithACV:@"cn003"];
    
    // Curve
    VnFilterToneCurve* curveFilter2 = [[VnFilterToneCurve alloc] initWithACV:@"cn004"];
    curveFilter2.topLayerOpacity = 0.50f;
    
    // Hue / Saturation
    VnAdjustmentLayerHueSaturation* hueSaturation = [[VnAdjustmentLayerHueSaturation alloc] init];
    hueSaturation.hue = 0.0f;
    hueSaturation.saturation = -5.0f;
    hueSaturation.lightness = 0.0f;
    hueSaturation.colorize = NO;

    // Fill Layer
    VnFilterSolidColor* solidColor1 = [[VnFilterSolidColor alloc] init];
    [solidColor1 setColorRed:90.0f/255.0f green:86.0f/255.0f blue:78.0f/255.0 alpha:1.0f];
    solidColor1.topLayerOpacity = 0.30f;
    solidColor1.blendingMode = VnBlendingModeLighten;

    self.startFilter = curveFilter1;
    [curveFilter1 addTarget:curveFilter2];
    [curveFilter2 addTarget:hueSaturation];
    [hueSaturation addTarget:solidColor1];
    self.endFilter = solidColor1;
    
}

@end
