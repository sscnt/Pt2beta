//
//  VnEffectGlamurBw.m
//  Pastel2
//
//  Created by SSC on 2014/06/13.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectGlamourBw.h"

@implementation VnEffectGlamourBw

- (id)init
{
    self = [super init];
    if(self){
        self.effectId = VnEffectIdGlamourBw;
    }
    return self;
}

- (void)makeFilterGroup
{
    
    // Channel Mixer
    VnAdjustmentLayerChannelMixerFilter* mixerFilter1 = [[VnAdjustmentLayerChannelMixerFilter alloc] init];
    [mixerFilter1 setGreyChannelRed:40 Green:40 Blue:20 Constant:0];
    mixerFilter1.monochrome = YES;
    mixerFilter1.blendingMode = VnBlendingModeHardLight;
    
    // Gradient Map
    VnAdjustmentLayerGradientMap* gradientMap1 = [[VnAdjustmentLayerGradientMap alloc] init];
    [gradientMap1 addColorRed:0.0f Green:0.0f Blue:0.0f Opacity:100.0f Location:0 Midpoint:50];
    [gradientMap1 addColorRed:255.0f Green:255.0f Blue:255.0f Opacity:100.0f Location:4096 Midpoint:50];
    
    // Curve
    VnFilterToneCurve* curveFilter2 = [[VnFilterToneCurve alloc] initWithACV:@"glmbw"];
    
    self.startFilter = mixerFilter1;
    [mixerFilter1 addTarget:gradientMap1];
    [gradientMap1 addTarget:curveFilter2];
    self.endFilter = curveFilter2;
    
}

@end
