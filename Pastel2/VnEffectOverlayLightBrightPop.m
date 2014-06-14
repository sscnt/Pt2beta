//
//  VnEffectOverlayLightBrightPop.m
//  Pastel
//
//  Created by SSC on 2014/05/06.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectOverlayLightBrightPop.h"

@implementation VnEffectOverlayLightBrightPop

- (id)init
{
    self = [super init];
    if(self){
        self.effectId = VnEffectIdOverlayLightBrightPop;
    }
    return self;
}

- (void)makeFilterGroup
{
    // Curve
    VnFilterToneCurve* curveFilter = [[VnFilterToneCurve alloc] initWithACV:@"bn001"];
    
    // Levels
    VnFilterLevels* levelsFilter = [[VnFilterLevels alloc] init];
    [levelsFilter setMin:s255(40.0f) gamma:1.05f max:s255(250.0f) minOut:s255(0.0f) maxOut:s255(255.0f)];
    levelsFilter.topLayerOpacity = 0.70f;
    
    // Photo Filter
    VnAdjustmentLayerPhotoFilter* photoFilter = [[VnAdjustmentLayerPhotoFilter alloc] init];
    photoFilter.color = (GPUVector3){s255(235.0f), s255(145.0f), 0.0f};
    photoFilter.density = 0.25f;
    photoFilter.preserveLuminosity = YES;
    photoFilter.topLayerOpacity = 0.15f;
    
    self.startFilter = curveFilter;
    [curveFilter addTarget:levelsFilter];
    [levelsFilter addTarget:photoFilter];
    self.endFilter = photoFilter;
    
    
}

@end
