//
//  VnEffectVintageSummer.m
//  Pastel2
//
//  Created by SSC on 2014/06/12.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectVintageSummer.h"

@implementation VnEffectVintageSummer

- (id)init
{
    self = [super init];
    if(self){
        self.effectId = VnEffectIdVvintageSummer;
    }
    return self;
}

- (void)makeFilterGroup
{
    // Fill Layer
    VnAdjustmentLayerGradientColorFill* gradientColor1 = [[VnAdjustmentLayerGradientColorFill alloc] initWithEffectObj:self];
    [gradientColor1 setStyle:GradientStyleRadial];
    [gradientColor1 setAngleDegree:90];
    [gradientColor1 setScalePercent:150];
    [gradientColor1 setOffsetX:0.0f Y:0.0f];
    [gradientColor1 addColorRed:255.0f Green:255.0f Blue:255.0f Opacity:0.0f Location:0 Midpoint:50];
    [gradientColor1 addColorRed:0.0f Green:0.0f Blue:0.0f Opacity:100.0f Location:4096 Midpoint:50];
    gradientColor1.topLayerOpacity = 0.40f;
    gradientColor1.blendingMode = VnBlendingModeOverlay;
    
    // Fill Layer
    VnAdjustmentLayerGradientColorFill* gradientColor2 = [[VnAdjustmentLayerGradientColorFill alloc] initWithEffectObj:self];
    [gradientColor2 setStyle:GradientStyleRadial];
    [gradientColor2 setAngleDegree:90];
    [gradientColor2 setScalePercent:150];
    [gradientColor2 setOffsetX:0.0f Y:0.0f];
    [gradientColor2 addColorRed:255.0f Green:255.0f Blue:255.0f Opacity:100.0f Location:0 Midpoint:50];
    [gradientColor2 addColorRed:255.0f Green:255.0f Blue:255.0f Opacity:0.0f Location:4096 Midpoint:50];
    gradientColor2.topLayerOpacity = 0.40f;
    gradientColor2.blendingMode = VnBlendingModeOverlay;
    
    // Hue / Saturation
    VnAdjustmentLayerHueSaturation* hueSaturation = [[VnAdjustmentLayerHueSaturation alloc] init];
    hueSaturation.hue = 0.0f;
    hueSaturation.saturation = 10.0f;
    hueSaturation.lightness = 0.0f;
    hueSaturation.colorize = NO;
    hueSaturation.topLayerOpacity = 0.50f;
    
    // Hue / Saturation
    VnAdjustmentLayerHueSaturation* hueSaturation2 = [[VnAdjustmentLayerHueSaturation alloc] init];
    hueSaturation2.hue = 35.0f;
    hueSaturation2.saturation = 25.0f;
    hueSaturation2.lightness = 0.0f;
    hueSaturation2.colorize = YES;
    hueSaturation2.topLayerOpacity = 0.30f;
    
    // Curve
    VnFilterToneCurve* curveFilter = [[VnFilterToneCurve alloc] initWithACV:@"bw001"];
    
    // Hue / Saturation
    VnAdjustmentLayerHueSaturation* hueSaturation3 = [[VnAdjustmentLayerHueSaturation alloc] init];
    hueSaturation3.hue = 40.0f;
    hueSaturation3.saturation = 40.0f;
    hueSaturation3.lightness = 0.0f;
    hueSaturation3.colorize = YES;
    hueSaturation3.topLayerOpacity = 0.30f;
    
    // Fill Layer
    VnFilterSolidColor* solidColor1 = [[VnFilterSolidColor alloc] init];
    [solidColor1 setColorRed:245.0f/255.0f green:25.0f/255.0f blue:98.0f/255.0 alpha:1.0f];
    solidColor1.topLayerOpacity = 0.08f;
    solidColor1.blendingMode = VnBlendingModeScreen;
    
    // Levels
    VnFilterLevels* levelsFilter1 = [[VnFilterLevels alloc] init];
    [levelsFilter1 setRedMin:s255(0.0f) gamma:1.0f max:s255(241.0f) minOut:s255(0.0f) maxOut:s255(254.0f)];
    [levelsFilter1 setGreenMin:s255(0.0f) gamma:1.0f max:s255(242.0f) minOut:s255(0.0f) maxOut:s255(235.0f)];
    [levelsFilter1 setBlueMin:s255(0.0f) gamma:1.0f max:s255(253.0f) minOut:s255(0.0f) maxOut:s255(200.0f)];
    levelsFilter1.topLayerOpacity = 0.0f;
    levelsFilter1.blendingMode = VnBlendingModeNormal;
    
    self.startFilter = gradientColor1;
    [gradientColor1 addTarget:gradientColor2];
    [gradientColor2 addTarget:hueSaturation];
    [hueSaturation addTarget:hueSaturation2];
    [hueSaturation2 addTarget:curveFilter];
    [curveFilter addTarget:hueSaturation3];
    [hueSaturation3 addTarget:solidColor1];
    [solidColor1 addTarget:levelsFilter1];
    self.endFilter = levelsFilter1;
}

@end
