//
//  VnEffectVintageWine.m
//  Pastel2
//
//  Created by SSC on 2014/06/12.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectVintageWine.h"

@implementation VnEffectVintageWine

- (id)init
{
    self = [super init];
    if(self){
        self.effectId = VnEffectIdVintageWine;
    }
    return self;
}

- (void)makeFilterGroup
{
    //// Lighten
    VnFilterDuplicate* lightenFilter = [[VnFilterDuplicate alloc] init];
    lightenFilter.topLayerOpacity = 0.25f;
    lightenFilter.blendingMode = VnBlendingModeScreen;
    
    // Fill Layer
    VnAdjustmentLayerGradientColorFill* gradientColor1 = [[VnAdjustmentLayerGradientColorFill alloc] initWithEffectObj:self];
    [gradientColor1 setStyle:GradientStyleRadial];
    [gradientColor1 setAngleDegree:90];
    [gradientColor1 setScalePercent:150];
    [gradientColor1 setOffsetX:0.0f Y:0.0f];
    [gradientColor1 addColorRed:255.0f Green:255.0f Blue:255.0f Opacity:0.0f Location:0 Midpoint:50];
    [gradientColor1 addColorRed:58.0f Green:2.0f Blue:2.0f Opacity:100.0f Location:4096 Midpoint:50];
    gradientColor1.topLayerOpacity = 0.40f;
    gradientColor1.blendingMode = VnBlendingModeOverlay;
    
    // Curve
    VnFilterToneCurve* curveFilter = [[VnFilterToneCurve alloc] initWithACV:@"ca001"];
    
    // Hue / Saturation
    VnAdjustmentLayerHueSaturation* hueSaturation2 = [[VnAdjustmentLayerHueSaturation alloc] init];
    hueSaturation2.hue = 43.0f;
    hueSaturation2.saturation = 25.0f;
    hueSaturation2.lightness = 0.0f;
    hueSaturation2.colorize = YES;
    hueSaturation2.topLayerOpacity = 0.50f;
    
    // Color Balance
    VnAdjustmentLayerColorBalance* colorBalance1 = [[VnAdjustmentLayerColorBalance alloc] init];
    GPUVector3 shadows;
    shadows.one = s255(-7.0f);
    shadows.two = s255(0.0f);
    shadows.three = s255(-6.0f);
    [colorBalance1 setShadows:shadows];
    GPUVector3 midtones;
    midtones.one = s255(2.0f);
    midtones.two = s255(0.0f);
    midtones.three = s255(-5.0f);
    [colorBalance1 setMidtones:midtones];
    GPUVector3 highlights;
    highlights.one = s255(5.0f);
    highlights.two = s255(0.0f);
    highlights.three = s255(8.0f);
    [colorBalance1 setHighlights:highlights];
    colorBalance1.preserveLuminosity = YES;
    
    // Fill Layer
    VnFilterSolidColor* solidColor2 = [[VnFilterSolidColor alloc] init];
    [solidColor2 setColorRed:97.0f/255.0f green:76.0f/255.0f blue:109.0f/255.0 alpha:1.0f];
    solidColor2.topLayerOpacity = 0.25f;
    solidColor2.blendingMode = VnBlendingModeSoftLight;
    
    self.startFilter = lightenFilter;
    [lightenFilter addTarget:gradientColor1];
    [gradientColor1 addTarget:curveFilter];
    [curveFilter addTarget:hueSaturation2];
    [hueSaturation2 addTarget:colorBalance1];
    [colorBalance1 addTarget:solidColor2];
    self.endFilter = solidColor2;
}

@end
