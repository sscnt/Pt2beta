//
//  VnEffectVSCOSummer.m
//  Pastel2
//
//  Created by SSC on 2014/06/15.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectVSCOSummer.h"

@implementation VnEffectVSCOSummer

- (id)init
{
    self = [super init];
    if(self){
        self.defaultOpacity = 0.60f;
        self.effectId = VnEffectIdVSCOSummer;
    }
    return self;
}

- (void)makeFilterGroup
{
    // Hue / Saturation
    VnAdjustmentLayerHueSaturation* hueSaturation = [[VnAdjustmentLayerHueSaturation alloc] init];
    hueSaturation.hue = 0.0f;
    hueSaturation.saturation = -20;
    hueSaturation.lightness = 0.0f;
    hueSaturation.colorize = NO;
    
    // Curve
    VnFilterToneCurve* curveFilter1 = [[VnFilterToneCurve alloc] initWithACV:@"cf001"];
    
    // Exposure
    VnFilterExposure* expFilter = [[VnFilterExposure alloc] init];
    expFilter.offset = 0.0288f;

    self.startFilter = hueSaturation;
    [hueSaturation addTarget:curveFilter1];
    [curveFilter1 addTarget:expFilter];
    self.endFilter = expFilter;
}

@end
