//
//  VnEffectPurpleBerry.m
//  Pastel
//
//  Created by SSC on 2014/05/09.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectPurpleBerry.h"

@implementation VnEffectPurpleBerry

- (id)init
{
    self = [super init];
    if(self){
        self.effectId = VnEffectIdPurpleBerry;
    }
    return self;
}

- (UIImage*)process
{
    
    [VnCurrentImage saveTmpImage:self.imageToProcess];
    
    // Selective Color
    @autoreleasepool {
        VnAdjustmentLayerSelectiveColor* selectiveColor = [[VnAdjustmentLayerSelectiveColor alloc] init];
        [selectiveColor setRedsCyan:59 Magenta:16 Yellow:-39 Black:0];
        [selectiveColor setYellowsCyan:23 Magenta:29 Yellow:29 Black:0];
        [selectiveColor setWhitesCyan:-21 Magenta:0 Yellow:12 Black:0];
        [selectiveColor setNeutralsCyan:10 Magenta:8 Yellow:-6 Black:0];
        [selectiveColor setBlacksCyan:5 Magenta:0 Yellow:-1 Black:5];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:selectiveColor opacity:1.0f blendingMode:VnBlendingModeNormal];
    }
    
    // Curve
    @autoreleasepool {
        VnFilterToneCurve* curveFilter = [[VnFilterToneCurve alloc] initWithACV:@"plbr1"];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:curveFilter opacity:0.20f blendingMode:VnBlendingModeNormal];
    }
    
    // Fill Layer
    @autoreleasepool {
        VnFilterSolidColor* solidColor = [[VnFilterSolidColor alloc] init];
        [solidColor setColorRed:0.0f/255.0f green:8.0f/255.0f blue:28.0f/255.0 alpha:1.0f];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:solidColor opacity:1.0f blendingMode:VnBlendingModeExclusion];
    }
    
    // Fill Layer
    @autoreleasepool {
        VnAdjustmentLayerGradientColorFill* gradientColor = [[VnAdjustmentLayerGradientColorFill alloc] init];
        [gradientColor forceProcessingAtSize:self.imageSize];
        [gradientColor setStyle:GradientStyleRadial];
        [gradientColor setAngleDegree:0.0f];
        [gradientColor setScalePercent:150];
        [gradientColor setOffsetX:-18.0f Y:-11.0f];
        [gradientColor addColorRed:255.0f Green:229.0f Blue:183.0f Opacity:100.0f Location:0 Midpoint:50];
        [gradientColor addColorRed:127.0f Green:124.0f Blue:59.0f Opacity:0.0f Location:4096 Midpoint:50];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:gradientColor opacity:0.20f blendingMode:VnBlendingModeOverlay];
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
        midtones.one = s255(5.0f);
        midtones.two = s255(-2.0f);
        midtones.three = s255(-2.0f);
        [colorBalance setMidtones:midtones];
        GPUVector3 highlights;
        highlights.one = s255(2.0f);
        highlights.two = s255(-2.0f);
        highlights.three = s255(-10.0f);
        [colorBalance setHighlights:highlights];
        colorBalance.preserveLuminosity = YES;
        
        [self mergeAndSaveTmpImageWithOverlayFilter:colorBalance opacity:1.0f blendingMode:VnBlendingModeNormal];
    }
    
    // Selective Color
    @autoreleasepool {
        VnAdjustmentLayerSelectiveColor* selectiveColor = [[VnAdjustmentLayerSelectiveColor alloc] init];
        [selectiveColor setRedsCyan:2 Magenta:0 Yellow:12 Black:0];
        [selectiveColor setMagentasCyan:20 Magenta:-12 Yellow:21 Black:0];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:selectiveColor opacity:1.0f blendingMode:VnBlendingModeNormal];
    }
    
    // Fill Layer
    @autoreleasepool {
        VnFilterSolidColor* solidColor = [[VnFilterSolidColor alloc] init];
        [solidColor setColorRed:97.0f/255.0f green:76.0f/255.0f blue:109.0f/255.0 alpha:1.0f];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:solidColor opacity:0.15f blendingMode:VnBlendingModeHue];
    }
    
    // Curve
    @autoreleasepool {
        VnFilterToneCurve* curveFilter = [[VnFilterToneCurve alloc] initWithACV:@"plbr2"];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:curveFilter opacity:0.20f blendingMode:VnBlendingModeNormal];
    }

    
    return [VnCurrentImage tmpImage];
}

@end
