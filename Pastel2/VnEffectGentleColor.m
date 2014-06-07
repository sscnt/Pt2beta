//
//  VnEffectGentleColor.m
//  Pastel
//
//  Created by SSC on 2014/05/04.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectGentleColor.h"

@implementation VnEffectGentleColor

- (id)init
{
    self = [super init];
    if(self){
        self.effectId = VnEffectIdGentleColor;
    }
    return self;
}

- (UIImage*)process
{
    
    [VnCurrentImage saveTmpImage:self.imageToProcess];
    
    // Levels
    @autoreleasepool {
        GPUImageLevelsFilter* levelsFilter = [[GPUImageLevelsFilter alloc] init];
        [levelsFilter setMin:s255(0.0f) gamma:0.92f max:s255(255.0f) minOut:s255(0.0f) maxOut:s255(255.0f)];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:levelsFilter opacity:0.15f blendingMode:VnBlendingModeScreen];
    }
    
    // Levels
    @autoreleasepool {
        GPUImageLevelsFilter* levelsFilter = [[GPUImageLevelsFilter alloc] init];
        [levelsFilter setMin:s255(0.0f) gamma:0.92f max:s255(255.0f) minOut:s255(0.0f) maxOut:s255(255.0f)];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:levelsFilter opacity:0.60f blendingMode:VnBlendingModeSoftLight];
    }
    
    // Photo Filter
    @autoreleasepool {
        VnAdjustmentLayerPhotoFilter* filter = [[VnAdjustmentLayerPhotoFilter alloc] init];
        filter.color = (GPUVector3){s255(236.0f), s255(138.0f), 0.0f};
        filter.density = 0.50f;
        filter.preserveLuminosity = YES;
        
        [self mergeAndSaveTmpImageWithOverlayFilter:filter opacity:0.05f blendingMode:VnBlendingModeNormal];
    }
    
    // Hue/Saturation
    @autoreleasepool {
        VnAdjustmentLayerHueSaturation* hueSaturation = [[VnAdjustmentLayerHueSaturation alloc] init];
        hueSaturation.hue = 0.0f;
        hueSaturation.saturation = 25;
        hueSaturation.lightness = 0.0f;
        hueSaturation.colorize = NO;
        
        [self mergeAndSaveTmpImageWithOverlayFilter:hueSaturation opacity:0.30f blendingMode:VnBlendingModeSoftLight];
    }
    
    return [VnCurrentImage tmpImage];
}

@end
