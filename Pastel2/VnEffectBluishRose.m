//
//  VnEffectBluishRose.m
//  Pastel
//
//  Created by SSC on 2014/05/09.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectBluishRose.h"

@implementation VnEffectBluishRose

- (id)init
{
    self = [super init];
    if(self){
        self.defaultOpacity = 0.80f;
        self.faceOpacity = 0.80f;
        self.effectId = VnEffectIdBluishRose;
    }
    return self;
}

- (void)makeFilterGroup
{
    // Curve
    VnFilterPassThrough* curveInput = [[VnFilterPassThrough alloc] init];
    VnImageNormalBlendFilter* curveMerge = [[VnImageNormalBlendFilter alloc] init];
    VnFilterToneCurve* curveFilter1 = [[VnFilterToneCurve alloc] initWithACV:@"blrs"];
    curveMerge.topLayerOpacity = 0.25f;
    
    
    // Fill Layer
    VnFilterSolidColor* solidColor1 = [[VnFilterSolidColor alloc] init];
    [solidColor1 setColorRed:0.0f/255.0f green:8.0f/255.0f blue:28.0f/255.0 alpha:1.0f];
    solidColor1.blendingMode = VnBlendingModeExclusion;
    
    
    // Fill Layer
    VnAdjustmentLayerGradientColorFill* gradientColor1 = [[VnAdjustmentLayerGradientColorFill alloc] init];
    [gradientColor1 forceProcessingAtSize:self.imageSize];
    [gradientColor1 setStyle:GradientStyleRadial];
    [gradientColor1 setAngleDegree:0.0f];
    [gradientColor1 setScalePercent:150];
    [gradientColor1 setOffsetX:30.0f Y:-23.0f];
    [gradientColor1 addColorRed:158.0f Green:157.0f Blue:172.0f Opacity:100.0f Location:0 Midpoint:50];
    [gradientColor1 addColorRed:46.0f Green:45.0f Blue:67.0f Opacity:100.0f Location:4096 Midpoint:50];
    gradientColor1.topLayerOpacity = 0.30f;
    gradientColor1.blendingMode = VnBlendingModeSoftLight;
    gradientColor1.addingX = self.addingX;
    gradientColor1.addingY = self.addingY;
    gradientColor1.multiplierX = self.multiplierX;
    gradientColor1.multiplierY = self.multiplierY;
    
    
    // Fill Layer
    VnAdjustmentLayerGradientColorFill* gradientColor2 = [[VnAdjustmentLayerGradientColorFill alloc] init];
    [gradientColor2 forceProcessingAtSize:self.imageSize];
    [gradientColor2 setStyle:GradientStyleRadial];
    [gradientColor2 setAngleDegree:0.0f];
    [gradientColor2 setScalePercent:150];
    [gradientColor2 setOffsetX:-18.0f Y:-11.0f];
    [gradientColor2 addColorRed:255.0f Green:229.0f Blue:183.0f Opacity:100.0f Location:0 Midpoint:50];
    [gradientColor2 addColorRed:127.0f Green:124.0f Blue:59.0f Opacity:0.0f Location:4096 Midpoint:50];
    gradientColor2.topLayerOpacity = 0.38f;
    gradientColor2.blendingMode = VnBlendingModeOverlay;
    gradientColor2.addingX = self.addingX;
    gradientColor2.addingY = self.addingY;
    gradientColor2.multiplierX = self.multiplierX;
    gradientColor2.multiplierY = self.multiplierY;
    
    
    // Color Balance
    VnAdjustmentLayerColorBalance* colorBalance1 = [[VnAdjustmentLayerColorBalance alloc] init];
    GPUVector3 shadows1;
    shadows1.one = s255(0.0f);
    shadows1.two = s255(0.0f);
    shadows1.three = s255(0.0f);
    [colorBalance1 setShadows:shadows1];
    GPUVector3 midtones1;
    midtones1.one = s255(5.0f);
    midtones1.two = s255(-2.0f);
    midtones1.three = s255(-2.0f);
    [colorBalance1 setMidtones:midtones1];
    GPUVector3 highlights1;
    highlights1.one = s255(2.0f);
    highlights1.two = s255(-2.0f);
    highlights1.three = s255(-10.0f);
    [colorBalance1 setHighlights:highlights1];
    colorBalance1.preserveLuminosity = YES;
    
    // Selective Color
    VnAdjustmentLayerSelectiveColor* selectiveColor1 = [[VnAdjustmentLayerSelectiveColor alloc] init];
    [selectiveColor1 setRedsCyan:1 Magenta:10 Yellow:22 Black:0];
    [selectiveColor1 setYellowsCyan:-22 Magenta:-1 Yellow:-55 Black:0];
    [selectiveColor1 setMagentasCyan:3 Magenta:0 Yellow:2 Black:0];
    [selectiveColor1 setBlacksCyan:10 Magenta:4 Yellow:4 Black:0];
    
    
    // Levels
    VnFilterLevels* levelsFilter1 = [[VnFilterLevels alloc] init];
    [levelsFilter1 setRedMin:s255(3.0f) gamma:1.01 max:s255(255.0f) minOut:s255(0.0f) maxOut:s255(255.0f)];
    [levelsFilter1 setGreenMin:s255(0.0f) gamma:0.99 max:s255(255.0f) minOut:s255(0.0f) maxOut:s255(255.0f)];
    [levelsFilter1 setBlueMin:s255(6.0f) gamma:1.01f max:s255(236.0f) minOut:s255(18.0f) maxOut:s255(245.0f)];
    
    
    // Levels
    VnFilterLevels* levelsFilter2 = [[VnFilterLevels alloc] init];
    [levelsFilter2 setMin:s255(22.0) gamma:1.02f max:s255(249.0f) minOut:s255(14.0f) maxOut:s255(252.0f)];
    
    // Fill Layer
    VnFilterSolidColor* solidColor2 = [[VnFilterSolidColor alloc] init];
    [solidColor2 setColorRed:0.0f/255.0f green:31.0f/255.0f blue:63.0f/255.0 alpha:1.0f];
    solidColor2.topLayerOpacity = 0.15f;
    solidColor2.blendingMode = VnBlendingModeExclusion;
    
    self.startFilter = curveInput;
    [curveInput addTarget:curveMerge];
    [curveInput addTarget:curveFilter1];
    [curveFilter1 addTarget:curveMerge atTextureLocation:1];
    [curveMerge addTarget:solidColor1];
    [solidColor1 addTarget:gradientColor1];
    [gradientColor1 addTarget:gradientColor2];
    [gradientColor2 addTarget:colorBalance1];
    [colorBalance1 addTarget:selectiveColor1];
    [selectiveColor1 addTarget:levelsFilter1];
    [levelsFilter1 addTarget:levelsFilter2];
    [levelsFilter2 addTarget:solidColor2];
    self.endFilter = solidColor2;
}

@end
