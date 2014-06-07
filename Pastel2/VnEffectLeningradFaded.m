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

- (UIImage*)process
{
    
    [VnCurrentImage saveTmpImage:self.imageToProcess];
    
    // Channel Mixer
    @autoreleasepool {
        VnAdjustmentLayerChannelMixerFilter* mixerFilter = [[VnAdjustmentLayerChannelMixerFilter alloc] init];
        mixerFilter.monochrome = YES;
        [mixerFilter setGreyChannelRed:40 Green:30 Blue:30 Constant:0];

        [self mergeAndSaveTmpImageWithOverlayFilter:mixerFilter opacity:0.20f blendingMode:VnBlendingModeNormal];
    }
    
    // Curve
    @autoreleasepool {
        VnFilterToneCurve* curveFilter = [[VnFilterToneCurve alloc] initWithACV:@"lngrfd"];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:curveFilter opacity:1.0f blendingMode:VnBlendingModeNormal];
    }
    
    return [VnCurrentImage tmpImage];
}

@end
