//
//  VnEffectSweetFlower.m
//  Pastel
//
//  Created by SSC on 2014/05/08.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectSweetFlower.h"

@implementation VnEffectSweetFlower

- (id)init
{
    self = [super init];
    if(self){
        self.effectId = VnEffectIdSweetFlower;
    }
    return self;
}

- (UIImage*)process
{
    
    [VnCurrentImage saveTmpImage:self.imageToProcess];
    
    // Selective Color
    @autoreleasepool {
        VnAdjustmentLayerSelectiveColor* selectiveColor = [[VnAdjustmentLayerSelectiveColor alloc] init];
        [selectiveColor setRedsCyan:-22 Magenta:16 Yellow:33 Black:0];
        [selectiveColor setYellowsCyan:-45 Magenta:16 Yellow:32 Black:0];
        [selectiveColor setGreensCyan:4 Magenta:21 Yellow:-13 Black:0];
        [selectiveColor setCyansCyan:-2 Magenta:-2 Yellow:29 Black:0];
        [selectiveColor setBluesCyan:-27 Magenta:0 Yellow:22 Black:0];
        [selectiveColor setNeutralsCyan:-20 Magenta:4 Yellow:7 Black:1];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:selectiveColor opacity:1.0f blendingMode:VnBlendingModeNormal];
    }
    
    // Curve
    @autoreleasepool {
        VnFilterToneCurve* curveFilter = [[VnFilterToneCurve alloc] initWithACV:@"swfl"];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:curveFilter opacity:1.0f blendingMode:VnBlendingModeNormal];
    }
    
    // Selective Color
    @autoreleasepool {
        VnAdjustmentLayerSelectiveColor* selectiveColor = [[VnAdjustmentLayerSelectiveColor alloc] init];
        [selectiveColor setRedsCyan:14 Magenta:1 Yellow:4 Black:0];
        [selectiveColor setYellowsCyan:2 Magenta:16 Yellow:32 Black:0];
        [selectiveColor setGreensCyan:4 Magenta:-10 Yellow:-11 Black:0];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:selectiveColor opacity:1.0f blendingMode:VnBlendingModeNormal];
    }
    
    // Fill Layer
    @autoreleasepool {
        VnFilterSolidColor* solidColor = [[VnFilterSolidColor alloc] init];
        [solidColor setColorRed:0.0f/255.0f green:11.0f/255.0f blue:50.0f/255.0 alpha:1.0f];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:solidColor opacity:0.30f blendingMode:VnBlendingModeExclusion];
    }
    
    // Fill Layer
    @autoreleasepool {
        VnFilterSolidColor* solidColor = [[VnFilterSolidColor alloc] init];
        [solidColor setColorRed:29.0f/255.0f green:137.0f/255.0f blue:211.0f/255.0 alpha:1.0f];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:solidColor opacity:0.15f blendingMode:VnBlendingModeExclusion];
    }
    
    // Color Balance
    @autoreleasepool {
        VnAdjustmentLayerColorBalance* colorBalance = [[VnAdjustmentLayerColorBalance alloc] init];
        GPUVector3 shadows;
        shadows.one = s255(0.0f);
        shadows.two = s255(0.0f);
        shadows.three = s255(0.0f);
        [colorBalance setShadows:shadows];
        GPUVector3 midtones;
        midtones.one = s255(-10.0f);
        midtones.two = s255(0.0f);
        midtones.three = s255(23.0f);
        [colorBalance setMidtones:midtones];
        GPUVector3 highlights;
        highlights.one = s255(0.0f);
        highlights.two = s255(0.0f);
        highlights.three = s255(0.0f);
        [colorBalance setHighlights:highlights];
        colorBalance.preserveLuminosity = YES;
        
        [self mergeAndSaveTmpImageWithOverlayFilter:colorBalance opacity:0.90f blendingMode:VnBlendingModeNormal];
    }
    
    // Curve
    @autoreleasepool {
        VnFilterToneCurve* curveFilter = [[VnFilterToneCurve alloc] initWithACV:@"swfl2"];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:curveFilter opacity:1.0f blendingMode:VnBlendingModeNormal];
    }


    
    return [VnCurrentImage tmpImage];
}

@end
