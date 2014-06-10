//
//  GPUEffectWeekend.m
//  Gravy_1.0
//
//  Created by SSC on 2013/11/28.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "VnEffectWeekend.h"

@implementation VnEffectWeekend

- (id)init
{
    self = [super init];
    if(self){
        self.defaultOpacity = 0.80f;
        self.faceOpacity = 0.60f;
        self.effectId = VnEffectIdWeekend;
    }
    return self;
}

- (void)makeFilterGroup
{
    
    // Hue / Saturation
    VnAdjustmentLayerHueSaturation* hueSaturation1 = [[VnAdjustmentLayerHueSaturation alloc] init];
    hueSaturation1.hue = 0.0f;
    hueSaturation1.saturation = 3.0f;
    hueSaturation1.lightness = -4.0;
    hueSaturation1.colorize = NO;
    
    
    // Levels
    VnFilterLevels* levelsFilter1 = [[VnFilterLevels alloc] init];
    [levelsFilter1 setMin:10.0f/255.0f gamma:1.10f max:250.0f/255.0f minOut:0.0f maxOut:255.0f/255.0f];
    
    
    // Fill Layer
    VnFilterSolidColor* solidColor1 = [[VnFilterSolidColor alloc] init];
    [solidColor1 setColorRed:15.0f/255.0f green:35.0f/255.0f blue:65.0f/255.0 alpha:1.0f];
    solidColor1.blendingMode = VnBlendingModeExclusion;
    
    
    // Levels
    VnFilterLevels* levelsFilter2 = [[VnFilterLevels alloc] init];
    [levelsFilter2 setMin:0.0f gamma:1.0f max:1.0f minOut:0.0f maxOut:1.0f];
    [levelsFilter2 setRedMin:20.0f/255.0f gamma:1.30f max:240.0f/255.0f minOut:0.0f maxOut:255.0f/255.0f];
    
    
    // Levels
    VnFilterLevels* levelsFilter3 = [[VnFilterLevels alloc] init];
    [levelsFilter3 setMin:20.0f/255.0f gamma:0.90f max:220.0f/255.0f minOut:0.0f maxOut:255.0f/255.0f];
    
    
    // Photo Filter
    VnAdjustmentLayerPhotoFilter* photoFilter1 = [[VnAdjustmentLayerPhotoFilter alloc] init];
    photoFilter1.color = (GPUVector3){s255(0.0f), s255(195.0f), s255(250.0f)};
    photoFilter1.density = 0.25f;
    photoFilter1.preserveLuminosity = YES;
    photoFilter1.topLayerOpacity = 0.50f;
    photoFilter1.blendingMode = VnBlendingModeSoftLight;
    
    /*
    // Color Balance
    VnAdjustmentLayerColorBalance* colorBalance1 = [[VnAdjustmentLayerColorBalance alloc] init];
    GPUVector3 shadows;
    shadows.one = 0.0f;
    shadows.two = 0.0f;
    shadows.three = 0.0f;
    [colorBalance1 setShadows:shadows];
    GPUVector3 midtones;
    midtones.one = 0.0f/255.0f;
    midtones.two = 30.0f/255.0f;
    midtones.three = 0.0f/255.0f;
    [colorBalance1 setMidtones:midtones];
    GPUVector3 highlights;
    highlights.one = 0.0f/255.0f;
    highlights.two = 0.0f/255.0f;
    highlights.three = 0.0f/255.0f;
    [colorBalance1 setHighlights:highlights];
    colorBalance1.preserveLuminosity = YES;
    colorBalance1.topLayerOpacity = 0.50f;
    colorBalance1.blendingMode = VnBlendingModeSoftLight;
     */
    
    // Fill Layer
    VnFilterSolidColor* solidColor2 = [[VnFilterSolidColor alloc] init];
    [solidColor2 setColorRed:10.0f/255.0f green:5.0f/255.0f blue:50.0f/255.0 alpha:1.0f];
    solidColor2.topLayerOpacity = 0.70f;
    solidColor2.blendingMode = VnBlendingModeExclusion;
    
    // Fill Layer
    VnAdjustmentLayerGradientColorFill* gradientColor1 = [[VnAdjustmentLayerGradientColorFill alloc] initWithEffectObj:self];
    [gradientColor1 setStyle:GradientStyleRadial];
    [gradientColor1 setAngleDegree:90];
    [gradientColor1 setScalePercent:150];
    [gradientColor1 setOffsetX:0.0f Y:0.0f];
    [gradientColor1 addColorRed:0.0f Green:0.0f Blue:0.0f Opacity:0.0f Location:0 Midpoint:50];
    [gradientColor1 addColorRed:0.0f Green:0.0f Blue:0.0f Opacity:100.0f Location:4096 Midpoint:50];
    gradientColor1.blendingMode = VnBlendingModeSoftLight;
    gradientColor1.topLayerOpacity = 0.30f;
    
    
    // Fill Layer
    VnFilterSolidColor* solidColor3 = [[VnFilterSolidColor alloc] init];
    [solidColor3 setColorRed:130.0f/255.0f green:130.0f/255.0f blue:130.0f/255.0 alpha:1.0f];
    solidColor3.topLayerOpacity = 0.15f;
    solidColor3.blendingMode = VnBlendingModeColorBurn;
    
    
    // Curve
    VnFilterPassThrough* curveInput = [[VnFilterPassThrough alloc] init];
    VnImageNormalBlendFilter* curveMerge = [[VnImageNormalBlendFilter alloc] init];
    VnFilterToneCurve* curveFilter = [[VnFilterToneCurve alloc] initWithACV:@"wnd"];
    curveMerge.topLayerOpacity = 0.35f;
    
    self.startFilter = hueSaturation1;
    [hueSaturation1 addTarget:levelsFilter1];
    [levelsFilter1 addTarget:solidColor1];
    [solidColor1 addTarget:levelsFilter2];
    [levelsFilter2 addTarget:levelsFilter3];
    [levelsFilter3 addTarget:photoFilter1];
    [photoFilter1 addTarget:solidColor2];
    [solidColor2 addTarget:gradientColor1];
    [gradientColor1 addTarget:solidColor3];
    [solidColor3 addTarget:curveInput];
    [curveInput addTarget:curveMerge];
    [curveInput addTarget:curveFilter];
    [curveFilter addTarget:curveMerge atTextureLocation:1];
    self.endFilter = curveMerge;
}

@end
