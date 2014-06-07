//
//  VnEffectFruitPop.m
//  Pastel
//
//  Created by SSC on 2014/05/08.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectFruitPop.h"

@implementation VnEffectFruitPop

- (id)init
{
    self = [super init];
    if(self){
        self.effectId = VnEffectIdFruitPop;
    }
    return self;
}

- (UIImage*)process
{
    
    [VnCurrentImage saveTmpImage:self.imageToProcess];
    
    // Fill Layer
    @autoreleasepool {
        VnFilterSolidColor* solidColor = [[VnFilterSolidColor alloc] init];
        [solidColor setColorRed:109.0f/255.0f green:131.0f/255.0f blue:249.0f/255.0 alpha:1.0f];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:solidColor opacity:0.85f blendingMode:VnBlendingModeSoftLight];
    }
    
    // Fill Layer
    @autoreleasepool {
        VnFilterSolidColor* solidColor = [[VnFilterSolidColor alloc] init];
        [solidColor setColorRed:215.0f/255.0f green:225.0f/255.0f blue:203.0f/255.0 alpha:1.0f];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:solidColor opacity:0.06f blendingMode:VnBlendingModeHue];
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
        midtones.one = s255(7.0f);
        midtones.two = s255(-27.0f);
        midtones.three = s255(-24.0f);
        [colorBalance setMidtones:midtones];
        GPUVector3 highlights;
        highlights.one = s255(9.0f);
        highlights.two = s255(7.0f);
        highlights.three = s255(-11.0f);
        [colorBalance setHighlights:highlights];
        colorBalance.preserveLuminosity = YES;
        
        [self mergeAndSaveTmpImageWithOverlayFilter:colorBalance opacity:1.0f blendingMode:VnBlendingModeNormal];
    }
    
    // Fill Layer
    @autoreleasepool {
        VnFilterSolidColor* solidColor = [[VnFilterSolidColor alloc] init];
        [solidColor setColorRed:143.0f/255.0f green:139.0f/255.0f blue:69.0f/255.0 alpha:1.0f];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:solidColor opacity:0.64f blendingMode:VnBlendingModeSoftLight];
    }
    
    // Fill Layer
    @autoreleasepool {
        VnFilterSolidColor* solidColor = [[VnFilterSolidColor alloc] init];
        [solidColor setColorRed:155.0f/255.0f green:156.0f/255.0f blue:113.0f/255.0 alpha:1.0f];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:solidColor opacity:0.20f blendingMode:VnBlendingModeOverlay];
    }
    
    // Curve
    @autoreleasepool {
        VnFilterToneCurve* curveFilter = [[VnFilterToneCurve alloc] initWithACV:@"frpp"];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:curveFilter opacity:1.0f blendingMode:VnBlendingModeNormal];
    }
    
    return [VnCurrentImage tmpImage];
}

@end
