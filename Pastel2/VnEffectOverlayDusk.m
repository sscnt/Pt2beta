//
//  VnEffectOverlayDusk.m
//  Pastel2
//
//  Created by SSC on 2014/06/17.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectOverlayDusk.h"

@implementation VnEffectOverlayDusk

- (id)init
{
    self = [super init];
    if(self){
        self.defaultOpacity = 0.7f;
        self.effectId = VnEffectIdOverlayDusk;
    }
    return self;
}

- (void)makeFilterGroup
{
    // Exposure
    VnFilterBrightness* brightnessFilter = [[VnFilterBrightness alloc] init];
    brightnessFilter.brightness = 0.2f;
    
    // Fill Layer
    VnFilterSolidColor* solidColor1 = [[VnFilterSolidColor alloc] init];
    [solidColor1 setColorRed:s255(188.0f) green:s255(176.0f) blue:s255(164.0f) alpha:1.0f];
    solidColor1.topLayerOpacity = 0.2f;
    solidColor1.blendingMode = VnBlendingModeDifference;
    
    self.startFilter = brightnessFilter;
    [brightnessFilter addTarget:solidColor1];
    self.endFilter = solidColor1;
}

@end
