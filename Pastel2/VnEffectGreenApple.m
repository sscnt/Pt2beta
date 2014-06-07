//
//  VnEffectGreenApple.m
//  Pastel
//
//  Created by SSC on 2014/05/09.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectGreenApple.h"

@implementation VnEffectGreenApple

- (id)init
{
    self = [super init];
    if(self){
        self.defaultOpacity = 0.80f;
        self.faceOpacity = 0.60f;
        self.effectId = VnEffectIdGreenApple;
    }
    return self;
}

- (UIImage*)process
{
    
    [VnCurrentImage saveTmpImage:self.imageToProcess];
    
    // Curve
    @autoreleasepool {
        VnFilterToneCurve* curveFilter = [[VnFilterToneCurve alloc] initWithACV:@"grap1"];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:curveFilter opacity:0.85f blendingMode:VnBlendingModeNormal];
    }
    
    // Selective Color
    @autoreleasepool {
        VnAdjustmentLayerSelectiveColor* selectiveColor = [[VnAdjustmentLayerSelectiveColor alloc] init];
        [selectiveColor setRedsCyan:10 Magenta:17 Yellow:24 Black:0];
        [selectiveColor setYellowsCyan:0 Magenta:0 Yellow:2 Black:0];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:selectiveColor opacity:1.0f blendingMode:VnBlendingModeNormal];
    }
    
    // Channel Mixer
    @autoreleasepool {
        VnAdjustmentLayerChannelMixerFilter* mixerFilter = [[VnAdjustmentLayerChannelMixerFilter alloc] init];
        [mixerFilter setRedChannelRed:100 Green:0 Blue:0 Constant:0];
        [mixerFilter setGreenChannelRed:0 Green:100 Blue:0 Constant:0];
        [mixerFilter setBlueChannelRed:14 Green:14 Blue:72 Constant:0];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:mixerFilter opacity:0.30f blendingMode:VnBlendingModeNormal];
    }
    
    // Fill Layer
    @autoreleasepool {
        VnFilterSolidColor* solidColor = [[VnFilterSolidColor alloc] init];
        [solidColor setColorRed:93.0f/255.0f green:31.0f/255.0f blue:185.0f/255.0 alpha:1.0f];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:solidColor opacity:0.30f blendingMode:VnBlendingModeSoftLight];
    }
    
    // Fill Layer
    @autoreleasepool {
        VnFilterSolidColor* solidColor = [[VnFilterSolidColor alloc] init];
        [solidColor setColorRed:0.0f/255.0f green:13.0f/255.0f blue:56.0f/255.0 alpha:1.0f];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:solidColor opacity:1.0f blendingMode:VnBlendingModeExclusion];
    }
    
    // Curve
    @autoreleasepool {
        VnFilterToneCurve* curveFilter = [[VnFilterToneCurve alloc] initWithACV:@"grap2"];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:curveFilter opacity:0.85f blendingMode:VnBlendingModeNormal];
    }
    
    // Selective Color
    @autoreleasepool {
        VnAdjustmentLayerSelectiveColor* selectiveColor = [[VnAdjustmentLayerSelectiveColor alloc] init];
        [selectiveColor setRedsCyan:15 Magenta:14 Yellow:8 Black:0];
        [selectiveColor setMagentasCyan:-15 Magenta:20 Yellow:-11 Black:0];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:selectiveColor opacity:1.0f blendingMode:VnBlendingModeNormal];
    }
    
    // Levels
    @autoreleasepool {
        GPUImageLevelsFilter* levelsFilter = [[GPUImageLevelsFilter alloc] init];
        [levelsFilter setRedMin:s255(16.0f) gamma:0.62f max:s255(255.0f) minOut:s255(0.0f) maxOut:s255(255.0f)];
        [levelsFilter setGreenMin:s255(1.0f) gamma:1.24f max:s255(255.0f) minOut:s255(0.0f) maxOut:s255(255.0f)];
        [levelsFilter setBlueMin:s255(0.0f) gamma:1.05f max:s255(255.0f) minOut:s255(0.0f) maxOut:s255(255.0f)];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:levelsFilter opacity:1.0f blendingMode:VnBlendingModeNormal];
    }
    
    // Curve
    @autoreleasepool {
        VnFilterToneCurve* curveFilter = [[VnFilterToneCurve alloc] initWithACV:@"grap3"];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:curveFilter opacity:0.90f blendingMode:VnBlendingModeNormal];
    }
    
    // Curve
    @autoreleasepool {
        VnFilterToneCurve* curveFilter = [[VnFilterToneCurve alloc] initWithACV:@"grap4"];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:curveFilter opacity:0.65f blendingMode:VnBlendingModeNormal];
    }
    
    return [VnCurrentImage tmpImage];
}

@end
