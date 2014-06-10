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

- (void)makeFilterGroup
{
    
    // Selective Color
    VnAdjustmentLayerSelectiveColor* selectiveColor1 = [[VnAdjustmentLayerSelectiveColor alloc] init];
    [selectiveColor1 setRedsCyan:59 Magenta:16 Yellow:-39 Black:0];
    [selectiveColor1 setYellowsCyan:23 Magenta:29 Yellow:29 Black:0];
    [selectiveColor1 setWhitesCyan:-21 Magenta:0 Yellow:12 Black:0];
    [selectiveColor1 setNeutralsCyan:10 Magenta:8 Yellow:-6 Black:0];
    [selectiveColor1 setBlacksCyan:5 Magenta:0 Yellow:-1 Black:5];
    
    
    // Curve
    VnFilterPassThrough* curveInput1 = [[VnFilterPassThrough alloc] init];
    VnImageNormalBlendFilter* curveMerge1 = [[VnImageNormalBlendFilter alloc] init];
    VnFilterToneCurve* curveFilter1 = [[VnFilterToneCurve alloc] initWithACV:@"plbr1"];
    curveMerge1.topLayerOpacity = 0.20f;
    
    // Fill Layer
    VnFilterSolidColor* solidColor1 = [[VnFilterSolidColor alloc] init];
    [solidColor1 setColorRed:0.0f/255.0f green:8.0f/255.0f blue:28.0f/255.0 alpha:1.0f];
    solidColor1.blendingMode = VnBlendingModeExclusion;
    
    // Fill Layer
    VnAdjustmentLayerGradientColorFill* gradientColor1 = [[VnAdjustmentLayerGradientColorFill alloc] initWithEffectObj:self];
    [gradientColor1 setStyle:GradientStyleRadial];
    [gradientColor1 setAngleDegree:0.0f];
    [gradientColor1 setScalePercent:150];
    [gradientColor1 setOffsetX:-18.0f Y:-11.0f];
    [gradientColor1 addColorRed:255.0f Green:229.0f Blue:183.0f Opacity:100.0f Location:0 Midpoint:50];
    [gradientColor1 addColorRed:127.0f Green:124.0f Blue:59.0f Opacity:0.0f Location:4096 Midpoint:50];
    gradientColor1.topLayerOpacity = 0.20f;
    gradientColor1.blendingMode = VnBlendingModeOverlay;
    
    
    // Color Balance
    VnAdjustmentLayerColorBalance* colorBalance1 = [[VnAdjustmentLayerColorBalance alloc] init];
    GPUVector3 shadows;
    shadows.one = s255(0.0f);
    shadows.two = s255(0.0f);
    shadows.three = s255(0.0f);
    [colorBalance1 setShadows:shadows];
    GPUVector3 midtones;
    midtones.one = s255(5.0f);
    midtones.two = s255(-2.0f);
    midtones.three = s255(-2.0f);
    [colorBalance1 setMidtones:midtones];
    GPUVector3 highlights;
    highlights.one = s255(2.0f);
    highlights.two = s255(-2.0f);
    highlights.three = s255(-10.0f);
    [colorBalance1 setHighlights:highlights];
    colorBalance1.preserveLuminosity = YES;
    
    
    // Selective Color
    VnAdjustmentLayerSelectiveColor* selectiveColor2 = [[VnAdjustmentLayerSelectiveColor alloc] init];
    [selectiveColor2 setRedsCyan:2 Magenta:0 Yellow:12 Black:0];
    [selectiveColor2 setMagentasCyan:20 Magenta:-12 Yellow:21 Black:0];
    
    // Fill Layer
    VnFilterSolidColor* solidColor2 = [[VnFilterSolidColor alloc] init];
    [solidColor2 setColorRed:97.0f/255.0f green:76.0f/255.0f blue:109.0f/255.0 alpha:1.0f];
    solidColor2.topLayerOpacity = 0.15f;
    solidColor2.blendingMode = VnBlendingModeHue;
    
    
    // Curve
    VnFilterToneCurve* curveFilter2 = [[VnFilterToneCurve alloc] initWithACV:@"plbr2"];
    
    self.startFilter = selectiveColor1;
    [selectiveColor1 addTarget:curveInput1];
    [curveInput1 addTarget:curveMerge1];
    [curveInput1 addTarget:curveFilter1];
    [curveFilter1 addTarget:curveMerge1 atTextureLocation:1];
    [curveMerge1 addTarget:solidColor1];
    [solidColor1 addTarget:gradientColor1];
    [gradientColor1 addTarget:colorBalance1];
    [colorBalance1 addTarget:selectiveColor2];
    [selectiveColor2 addTarget:solidColor2];
    [solidColor2 addTarget:curveFilter2];
    self.endFilter = curveFilter2;
}

@end
