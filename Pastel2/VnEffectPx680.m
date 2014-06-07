//
//  VnEffectPx680.m
//  Pastel
//
//  Created by SSC on 2014/05/12.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectPx680.h"

@implementation VnEffectPx680

- (id)init
{
    self = [super init];
    if(self){
        self.defaultOpacity = 0.50f;
        self.faceOpacity = 0.30f;
        self.effectId = VnEffectIdPx680;
    }
    return self;
}

- (void)makeFilterGroup
{
    VnAdjustmentLayerHueSaturation* hueSaturation = [[VnAdjustmentLayerHueSaturation alloc] init];
    hueSaturation.hue = 0.0f;
    hueSaturation.saturation = -20;
    hueSaturation.lightness = 0.0f;
    hueSaturation.colorize = NO;
    hueSaturation.blendingMode = VnBlendingModeSoftLight;
    
    // Curve
    VnFilterToneCurve* curveFilter = [[VnFilterToneCurve alloc] initWithACV:@"px680"];
    
    self.startFilter = hueSaturation;
    [hueSaturation addTarget:curveFilter];
    self.endFilter = curveFilter;
    
}


@end
