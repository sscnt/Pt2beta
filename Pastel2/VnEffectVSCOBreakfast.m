//
//  VnEffectVSCOBreakfast.m
//  Pastel2
//
//  Created by SSC on 2014/06/15.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectVSCOBreakfast.h"

@implementation VnEffectVSCOBreakfast

- (id)init
{
    self = [super init];
    if(self){
        self.effectId = VnEffectIdVSCOBreakfast;
    }
    return self;
}

- (void)makeFilterGroup
{
    
    // Channel Mixer
    VnAdjustmentLayerChannelMixerFilter* mixerFilter = [[VnAdjustmentLayerChannelMixerFilter alloc] init];
    mixerFilter.monochrome = YES;
    [mixerFilter setGreyChannelRed:40 Green:40 Blue:20 Constant:0];
    mixerFilter.topLayerOpacity = 0.25f;
    
    // Curve
    VnFilterToneCurve* curveFilter = [[VnFilterToneCurve alloc] initWithACV:@"cd001"];
    
    // Fill Layer
    VnFilterSolidColor* solidColor1 = [[VnFilterSolidColor alloc] init];
    [solidColor1 setColorRed:78.0f/255.0f green:78.0f/255.0f blue:78.0f/255.0 alpha:1.0f];
    solidColor1.topLayerOpacity = 0.40f;
    solidColor1.blendingMode = VnBlendingModeLighten;
    
    self.startFilter = mixerFilter;
    [mixerFilter addTarget:curveFilter];
    [curveFilter addTarget:solidColor1];
    self.endFilter = solidColor1;
}

@end
