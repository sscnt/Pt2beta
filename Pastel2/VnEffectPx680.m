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

- (UIImage*)process
{
    
    [VnCurrentImage saveTmpImage:self.imageToProcess];
    
    // Hue/Saturation
    @autoreleasepool {
        VnAdjustmentLayerHueSaturation* hueSaturation = [[VnAdjustmentLayerHueSaturation alloc] init];
        hueSaturation.hue = 0.0f;
        hueSaturation.saturation = -20;
        hueSaturation.lightness = 0.0f;
        hueSaturation.colorize = NO;
        
        [self mergeAndSaveTmpImageWithOverlayFilter:hueSaturation opacity:1.0f blendingMode:VnBlendingModeSoftLight];
    }

    // Curve
    @autoreleasepool {
        VnFilterToneCurve* curveFilter = [[VnFilterToneCurve alloc] initWithACV:@"px680"];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:curveFilter opacity:1.0f blendingMode:VnBlendingModeNormal];
    }
    
    return [VnCurrentImage tmpImage];
}


@end
