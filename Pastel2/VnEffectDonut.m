//
//  Donut.m
//  Pastel
//
//  Created by SSC on 2014/05/09.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectDonut.h"

@implementation VnEffectDonut

- (id)init
{
    self = [super init];
    if(self){
        self.effectId = VnEffectIdDonut;
    }
    return self;
}

- (void)makeFilterGroup
{
    
    [VnCurrentImage saveTmpImage:self.imageToProcess];
    
    // Fill Layer
    @autoreleasepool {
        VnFilterSolidColor* solidColor = [[VnFilterSolidColor alloc] init];
        [solidColor setColorRed:109.0f/255.0f green:131.0f/255.0f blue:249.0f/255.0 alpha:1.0f];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:solidColor opacity:0.75f blendingMode:VnBlendingModeSoftLight];
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
        [solidColor setColorRed:155.0f/255.0f green:159.0f/255.0f blue:113.0f/255.0 alpha:1.0f];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:solidColor opacity:0.20f blendingMode:VnBlendingModeOverlay];
    }
    
    // Curve
    @autoreleasepool {
        VnFilterToneCurve* curveFilter = [[VnFilterToneCurve alloc] initWithACV:@"dnt"];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:curveFilter opacity:0.80f blendingMode:VnBlendingModeNormal];
    }
    
    // Fill Layer
    @autoreleasepool {
        VnAdjustmentLayerGradientColorFill* gradientColor = [[VnAdjustmentLayerGradientColorFill alloc] init];
        [gradientColor forceProcessingAtSize:self.imageSize];
        [gradientColor setStyle:GradientStyleRadial];
        [gradientColor setAngleDegree:0.0f];
        [gradientColor setScalePercent:150];
        [gradientColor setOffsetX:0.0f Y:0.0f];
        [gradientColor addColorRed:229.0f Green:193.0f Blue:75.0f Opacity:0.0f Location:0 Midpoint:50];
        [gradientColor addColorRed:114.0f Green:122.0f Blue:235.0f Opacity:100.0f Location:4096 Midpoint:50];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:gradientColor opacity:0.50f blendingMode:VnBlendingModeSoftLight];
    }
    
    // Color Balance
    @autoreleasepool {
        VnAdjustmentLayerColorBalance* colorBalance = [[VnAdjustmentLayerColorBalance alloc] init];
        GPUVector3 shadows;
        shadows.one = s255(0.0f);
        shadows.two = s255(0.0f);
        shadows.three = s255(-2.0f);
        [colorBalance setShadows:shadows];
        GPUVector3 midtones;
        midtones.one = s255(-2.0f);
        midtones.two = s255(1.0f);
        midtones.three = s255(2.0f);
        [colorBalance setMidtones:midtones];
        GPUVector3 highlights;
        highlights.one = s255(8.0f);
        highlights.two = s255(4.0f);
        highlights.three = s255(10.0f);
        [colorBalance setHighlights:highlights];
        colorBalance.preserveLuminosity = YES;
        
        [self mergeAndSaveTmpImageWithOverlayFilter:colorBalance opacity:1.0f blendingMode:VnBlendingModeNormal];
    }
    
    // Fill Layer
    @autoreleasepool {
        VnFilterSolidColor* solidColor = [[VnFilterSolidColor alloc] init];
        [solidColor setColorRed:0.0f/255.0f green:0.0f/255.0f blue:40.0f/255.0 alpha:1.0f];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:solidColor opacity:0.30f blendingMode:VnBlendingModeExclusion];
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
        midtones.one = s255(25.0f);
        midtones.two = s255(-3.0f);
        midtones.three = s255(0.0f);
        [colorBalance setMidtones:midtones];
        GPUVector3 highlights;
        highlights.one = s255(0.0f);
        highlights.two = s255(-1.0f);
        highlights.three = s255(1.0f);
        [colorBalance setHighlights:highlights];
        colorBalance.preserveLuminosity = YES;
        
        [self mergeAndSaveTmpImageWithOverlayFilter:colorBalance opacity:1.0f blendingMode:VnBlendingModeNormal];
    }
    
    return [VnCurrentImage tmpImage];
}

@end
