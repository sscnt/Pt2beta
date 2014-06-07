//
//  VnEffectBreezeFaded.m
//  Pastel
//
//  Created by SSC on 2014/05/12.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectLeningradFaded.h"

@implementation VnEffectLeningradFaded

- (id)init
{
    self = [super init];
    if(self){
        self.effectId = VnEffectIdLeningradFaded;
    }
    return self;
}

- (void)makeFilterGroup
{
    // Channel Mixer
    VnAdjustmentLayerChannelMixerFilter* mixerFilter = [[VnAdjustmentLayerChannelMixerFilter alloc] init];
    mixerFilter.monochrome = YES;
    [mixerFilter setGreyChannelRed:40 Green:30 Blue:30 Constant:0];
    mixerFilter.topLayerOpacity = 0.20f;
    
    // Curve
    VnFilterToneCurve* curveFilter = [[VnFilterToneCurve alloc] initWithACV:@"lngrfd"];
    
    self.startFilter = mixerFilter;
    [mixerFilter addTarget:curveFilter];
    self.endFilter = curveFilter;
    
}

@end
