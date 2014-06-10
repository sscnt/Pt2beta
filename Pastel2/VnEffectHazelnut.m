//
//  GPUEffectHazelnut.m
//  Gravy_1.0
//
//  Created by SSC on 2013/11/22.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "VnEffectHazelnut.h"

@implementation VnEffectHazelnut

- (id)init
{
    self = [super init];
    if(self){
        self.effectId = VnEffectIdHazelnut;
    }
    return self;
}


- (void)makeFilterGroup
{
    
    //// Input
    VnFilterPassThrough* curveInput = [[VnFilterPassThrough alloc] init];
    VnImageNormalBlendFilter* curveMerge = [[VnImageNormalBlendFilter alloc] init];

    // Curve
    VnFilterToneCurve* curveFilter1 = [[VnFilterToneCurve alloc] initWithACV:@"Hzl1"];
    curveMerge.topLayerOpacity = 0.50f;
    
    // Fill Layer
    VnFilterSolidColor* solidColor1 = [[VnFilterSolidColor alloc] init];
    [solidColor1 setColorRed:0.0f/255.0f green:8.0f/255.0f blue:28.0f/255.0 alpha:1.0f];
    solidColor1.topLayerOpacity = 0.80f;
    solidColor1.blendingMode = VnBlendingModeExclusion;
    
    
    // Gradient
    VnAdjustmentLayerGradientColorFill* gradientColor1 = [[VnAdjustmentLayerGradientColorFill alloc] initWithEffectObj:self];
    [gradientColor1 setStyle:GradientStyleLinear];
    [gradientColor1 setAngleDegree:-125];
    [gradientColor1 setScalePercent:100];
    [gradientColor1 setOffsetX:0.0f Y:0.0f];
    [gradientColor1 addColorRed:159.0f Green:132.0f Blue:75.0f Opacity:100.0f Location:0 Midpoint:50];
    [gradientColor1 addColorRed:128.0f Green:123.0f Blue:59.0f Opacity:0.0f Location:4096 Midpoint:50];
    gradientColor1.blendingMode = VnBlendingModeSoftLight;
    
    
    // Gradient
    VnAdjustmentLayerGradientColorFill* gradientColor2 = [[VnAdjustmentLayerGradientColorFill alloc] initWithEffectObj:self];
    [gradientColor2 setStyle:GradientStyleRadial];
    [gradientColor2 setAngleDegree:55];
    [gradientColor2 setScalePercent:150];
    [gradientColor2 setOffsetX:2.0f Y:-4.0f];
    [gradientColor2 addColorRed:255.0f Green:229.0f Blue:183.0f Opacity:100.0f Location:0 Midpoint:50];
    [gradientColor2 addColorRed:128.0f Green:123.0f Blue:59.0f Opacity:0.0f Location:4096 Midpoint:50];
    gradientColor2.topLayerOpacity = 0.38f;
    gradientColor2.blendingMode = VnBlendingModeOverlay;
    
    
    // Color Balance
    VnAdjustmentLayerColorBalance* colorBalance1 = [[VnAdjustmentLayerColorBalance alloc] init];
    GPUVector3 shadows1;
    shadows1.one = 0.0f;
    shadows1.two = 0.0f;
    shadows1.three = 0.0f;
    [colorBalance1 setShadows:shadows1];
    GPUVector3 midtones1;
    midtones1.one = 5.0f/255.0f;
    midtones1.two = -2.0f/255.0f;
    midtones1.three = -2.0f/255.0f;
    [colorBalance1 setMidtones:midtones1];
    GPUVector3 highlights1;
    highlights1.one = 2.0f/255.0f;
    highlights1.two = -2.0f/255.0f;
    highlights1.three = -10.0f/255.0f;
    [colorBalance1 setHighlights:highlights1];
    colorBalance1.preserveLuminosity = YES;
    
    // Fill Layer
    VnFilterSolidColor* solidColor2 = [[VnFilterSolidColor alloc] init];
    [solidColor2 setColorRed:0.0f/255.0f green:50.0f/255.0f blue:175.0f/255.0 alpha:1.0f];
    solidColor2.topLayerOpacity = 0.05f;
    solidColor2.blendingMode = VnBlendingModeColor;
    

    // Fill Layer
    VnFilterSolidColor* solidColor3 = [[VnFilterSolidColor alloc] init];
    [solidColor3 setColorRed:177.0f/255.0f green:176.0f/255.0f blue:3.0f/255.0 alpha:1.0f];
    solidColor3.topLayerOpacity = 0.10f;
    solidColor3.blendingMode = VnBlendingModeHue;
    
    
    // Curve
    VnFilterToneCurve* curveFilter2 = [[VnFilterToneCurve alloc] initWithACV:@"hzl2"];

    // Fill Layer
    VnFilterSolidColor* solidColor4 = [[VnFilterSolidColor alloc] init];
    [solidColor4 setColorRed:1.0f green:1.0f blue:1.0f alpha:1.0f];
    solidColor4.topLayerOpacity = 0.15f;
    solidColor4.blendingMode = VnBlendingModeHue;
    
    self.startFilter = curveInput;
    [curveInput addTarget:curveMerge];
    [curveInput addTarget:curveFilter1];
    [curveFilter1 addTarget:curveMerge atTextureLocation:1];
    [curveMerge addTarget:solidColor1];
    [solidColor1 addTarget:gradientColor1];
    [gradientColor1 addTarget:gradientColor2];
    [gradientColor2 addTarget:colorBalance1];
    [colorBalance1 addTarget:solidColor2];
    [solidColor2 addTarget:solidColor3];
    [solidColor3 addTarget:curveFilter2];
    [curveFilter2 addTarget:solidColor4];
    self.endFilter = solidColor4;
}

@end
