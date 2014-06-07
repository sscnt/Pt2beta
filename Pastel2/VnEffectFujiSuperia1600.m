//
//  VnEffectFujiSuperia1600.m
//  Pastel
//
//  Created by SSC on 2014/05/12.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectFujiSuperia1600.h"

@implementation VnEffectFujiSuperia1600

- (id)init
{
    self = [super init];
    if(self){
        self.effectId = VnEffectIdFujiSuperia1600;
    }
    return self;
}

- (void)makeFilterGroup
{
    // Hue/Saturation
    VnAdjustmentLayerHueSaturation* hueSaturation = [[VnAdjustmentLayerHueSaturation alloc] init];
    hueSaturation.hue = 0.0f;
    hueSaturation.saturation = -5;
    hueSaturation.lightness = 0.0f;
    hueSaturation.colorize = NO;
    hueSaturation.blendingMode = VnBlendingModeSoftLight;
    
    // Curve
    VnFilterToneCurve* curveFilter = [[VnFilterToneCurve alloc] initWithACV:@"fs1600"];
    
    self.startFilter = hueSaturation;
    [hueSaturation addTarget:curveFilter];
    self.endFilter = curveFilter;

}

@end
