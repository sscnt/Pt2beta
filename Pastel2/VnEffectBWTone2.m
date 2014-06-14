//
//  VnEffectBWTone2.m
//  Pastel2
//
//  Created by SSC on 2014/06/14.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectBWTone2.h"

@implementation VnEffectBWTone2

- (id)init
{
    self = [super init];
    if(self){
        self.effectId = VnEffectIdBWTone2;
    }
    return self;
}

-(void)makeFilterGroup
{
    
    // Channel Mixer
    VnAdjustmentLayerChannelMixerFilter* mixerFilter1 = [[VnAdjustmentLayerChannelMixerFilter alloc] init];
    [mixerFilter1 setGreyChannelRed:0 Green:0 Blue:100 Constant:0];
    mixerFilter1.monochrome = YES;
    mixerFilter1.blendingMode = VnBlendingModeSoftLight;
    mixerFilter1.topLayerOpacity = 0.30f;
    
    // Channel Mixer
    VnAdjustmentLayerChannelMixerFilter* mixerFilter2 = [[VnAdjustmentLayerChannelMixerFilter alloc] init];
    [mixerFilter2 setGreyChannelRed:0 Green:0 Blue:100 Constant:0];
    mixerFilter2.monochrome = YES;
    mixerFilter2.blendingMode = VnBlendingModeColor;
    
    self.startFilter = mixerFilter1;
    [mixerFilter1 addTarget:mixerFilter2];
    self.endFilter = mixerFilter2;
    
    
}

@end
