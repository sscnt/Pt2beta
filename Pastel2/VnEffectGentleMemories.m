//
//  GPUEffectGentleMemories.m
//  Gravy_1.0
//
//  Created by SSC on 2013/12/03.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "VnEffectGentleMemories.h"

@implementation VnEffectGentleMemories

- (id)init
{
    self = [super init];
    if(self){
        self.effectId = VnEffectIdGentleMemories;
    }
    return self;
}

- (void)makeFilterGroup
{
    
    // Fill Layer
    VnFilterSolidColor* solidColor1 = [[VnFilterSolidColor alloc] init];
    [solidColor1 setColorRed:20.0f/255.0f green:32.0f/255.0f blue:60.0f/255.0 alpha:1.0f];
    solidColor1.topLayerOpacity = 0.70f;
    solidColor1.blendingMode = VnBlendingModeExclusion;
    
    
    // Fill Layer
    VnFilterSolidColor* solidColor2 = [[VnFilterSolidColor alloc] init];
    [solidColor2 setColorRed:4.0f/255.0f green:25.0f/255.0f blue:23.0f/255.0 alpha:1.0f];
    solidColor2.topLayerOpacity = 0.70f;
    solidColor2.blendingMode = VnBlendingModeExclusion;
    
    
    // Levels
    VnFilterLevels* levelsFilter1 = [[VnFilterLevels alloc] init];
    [levelsFilter1 setRedMin:33.0f/255.0f gamma:1.47f max:249.0f/255.0f minOut:0.0f maxOut:1.0f];
    [levelsFilter1 setGreenMin:34.0f/255.0f gamma:1.18f max:253.0f/255.0f minOut:0.0f maxOut:1.0f];
    [levelsFilter1 setBlueMin:29.0f/255.0f gamma:1.28f max:249.0f/255.0f minOut:41.0f/255.0f maxOut:228.0f/255.0f];
    levelsFilter1.topLayerOpacity = 0.70f;
    
    
    // Levels
    VnFilterLevels* levelsFilter2 = [[VnFilterLevels alloc] init];
    [levelsFilter2 setMin:52.0f/255.0f gamma:1.20f max:234.0f/255.0f minOut:26.0f/255.0f maxOut:251.0f/255.0f];
    levelsFilter2.topLayerOpacity = 0.70f;
    
    
    // Selective Color
    VnAdjustmentLayerSelectiveColor* selectiveColor = [[VnAdjustmentLayerSelectiveColor alloc] init];
    [selectiveColor setRedsCyan:-15 Magenta:5 Yellow:-10 Black:0];
    [selectiveColor setYellowsCyan:-14 Magenta:10 Yellow:16 Black:0];
    [selectiveColor setGreensCyan:-5 Magenta:0 Yellow:0 Black:0];
    [selectiveColor setCyansCyan:-29 Magenta:3 Yellow:-1 Black:0];
    [selectiveColor setBluesCyan:-27 Magenta:0 Yellow:22 Black:0];
    [selectiveColor setMagentasCyan:-1 Magenta:0 Yellow:0 Black:0];
    [selectiveColor setNeutralsCyan:4 Magenta:-5 Yellow:8 Black:1];
    selectiveColor.topLayerOpacity = 0.70f;
    
    
    
    // Fill Layer
    VnFilterSolidColor* solidColor3 = [[VnFilterSolidColor alloc] init];
    [solidColor3 setColorRed:236.0f/255.0f green:110.0f/255.0f blue:222.0f/255.0 alpha:1.0f];
    solidColor3.topLayerOpacity = 0.05f;
    solidColor3.blendingMode = VnBlendingModeScreen;
    
    // Fill Layer
    VnFilterSolidColor* solidColor4 = [[VnFilterSolidColor alloc] init];
    [solidColor4 setColorRed:236.0f/255.0f green:110.0f/255.0f blue:222.0f/255.0 alpha:1.0f];
    solidColor4.topLayerOpacity = 0.02f;
    solidColor4.blendingMode = VnBlendingModeSoftLight;
    
    // Curve
    VnFilterPassThrough* curveInput = [[VnFilterPassThrough alloc] init];
    VnImageNormalBlendFilter* curveMerge = [[VnImageNormalBlendFilter alloc] init];
    VnFilterToneCurve* curveFilter1 = [[VnFilterToneCurve alloc] initWithACV:@"gm1"];
    curveMerge.topLayerOpacity = 0.70f;
    
    
    
    // Fill Layer
    VnFilterSolidColor* solidColor5 = [[VnFilterSolidColor alloc] init];
    [solidColor5 setColorRed:255.0f/255.0f green:244.0f/255.0f blue:200.0f/255.0 alpha:1.0f];
    solidColor5.topLayerOpacity = 0.10f;
    solidColor5.blendingMode = VnBlendingModeScreen;
    
    
    // Fill Layer
    VnAdjustmentLayerGradientColorFill* gradientColor1 = [[VnAdjustmentLayerGradientColorFill alloc] init];
    [gradientColor1 forceProcessingAtSize:self.imageSize];
    [gradientColor1 setStyle:GradientStyleLinear];
    [gradientColor1 setAngleDegree:-63.0f];
    [gradientColor1 setScalePercent:150];
    [gradientColor1 setOffsetX:0.0f Y:0.0f];
    [gradientColor1 addColorRed:255.0f Green:255.0f Blue:255.0f Opacity:100.0f Location:0 Midpoint:50];
    [gradientColor1 addColorRed:255.0f Green:255.0f Blue:255.0f Opacity:0.0f Location:4096 Midpoint:50];
    gradientColor1.topLayerOpacity = 0.35f;
    gradientColor1.blendingMode = VnBlendingModeScreen;
    gradientColor1.addingX = self.addingX;
    gradientColor1.addingY = self.addingY;
    gradientColor1.multiplierX = self.multiplierX;
    gradientColor1.multiplierY = self.multiplierY;
    
    
    // Color Balance
    VnAdjustmentLayerColorBalance* colorBalance1 = [[VnAdjustmentLayerColorBalance alloc] init];
    GPUVector3 shadows1;
    shadows1.one = 3.0f/255.0f;
    shadows1.two = 3.0f/255.0f;
    shadows1.three = 3.0f/255.0f;
    [colorBalance1 setShadows:shadows1];
    GPUVector3 midtones1;
    midtones1.one = 1.0f/255.0f;
    midtones1.two = 7.0f/255.0f;
    midtones1.three = 5.0f/255.0f;
    [colorBalance1 setMidtones:midtones1];
    GPUVector3 highlights1;
    highlights1.one = -2.0f/255.0f;
    highlights1.two = 0.0f;
    highlights1.three = 8.0f/255.0f;
    [colorBalance1 setHighlights:highlights1];
    colorBalance1.preserveLuminosity = YES;
    colorBalance1.topLayerOpacity = 0.10f;
    colorBalance1.blendingMode = VnBlendingModeScreen;
    
    // Color Balance
    VnAdjustmentLayerColorBalance* colorBalance2 = [[VnAdjustmentLayerColorBalance alloc] init];
    GPUVector3 shadows2;
    shadows2.one = 3.0f/255.0f;
    shadows2.two = 3.0f/255.0f;
    shadows2.three = 3.0f/255.0f;
    [colorBalance2 setShadows:shadows2];
    GPUVector3 midtones2;
    midtones2.one = 1.0f/255.0f;
    midtones2.two = 7.0f/255.0f;
    midtones2.three = 5.0f/255.0f;
    [colorBalance2 setMidtones:midtones2];
    GPUVector3 highlights2;
    highlights2.one = -2.0f/255.0f;
    highlights2.two = 0.0f;
    highlights2.three = 8.0f/255.0f;
    [colorBalance2 setHighlights:highlights2];
    colorBalance2.preserveLuminosity = YES;
    colorBalance2.topLayerOpacity = 0.10f;
    
    // Curve
    VnFilterToneCurve* curveFilter2 = [[VnFilterToneCurve alloc] initWithACV:@"gm2"];
    
    // Color Balance
    VnAdjustmentLayerColorBalance* colorBalance3 = [[VnAdjustmentLayerColorBalance alloc] init];
    GPUVector3 shadows3;
    shadows3.one = 10.0f/255.0f;
    shadows3.two = 0.0f;
    shadows3.three = 0.0f;
    [colorBalance3 setShadows:shadows3];
    GPUVector3 midtones3;
    midtones3.one = 25.0f/255.0f;
    midtones3.two = 0.0f/255.0f;
    midtones3.three = -15.0f/255.0f;
    [colorBalance3 setMidtones:midtones3];
    GPUVector3 highlights3;
    highlights3.one = 1.0f/255.0f;
    highlights3.two = 0.0f/255.0f;
    highlights3.three = 1.0f/255.0f;
    [colorBalance3 setHighlights:highlights3];
    colorBalance3.preserveLuminosity = YES;
    
    // Curve
    VnFilterToneCurve* curveFilter3 = [[VnFilterToneCurve alloc] initWithACV:@"gm3"];
    
    // Curve
    VnFilterToneCurve* curveFilter4 = [[VnFilterToneCurve alloc] initWithACV:@"gm4"];
    
    
    self.startFilter = solidColor1;
    [solidColor1 addTarget:solidColor2];
    [solidColor2 addTarget:levelsFilter1];
    [levelsFilter1 addTarget:levelsFilter2];
    [levelsFilter2 addTarget:selectiveColor];
    [selectiveColor addTarget:solidColor3];
    [solidColor3 addTarget:solidColor4];
    [solidColor4 addTarget:curveInput];
    [curveInput addTarget:curveMerge];
    [curveInput addTarget:curveFilter1];
    [curveFilter1 addTarget:curveMerge atTextureLocation:1];
    [curveMerge addTarget:solidColor5];
    [solidColor5 addTarget:gradientColor1];
    [gradientColor1 addTarget:colorBalance1];
    [colorBalance1 addTarget:colorBalance2];
    [colorBalance2 addTarget:curveFilter2];
    [curveFilter2 addTarget:colorBalance3];
    [colorBalance3 addTarget:curveFilter3];
    [curveFilter3 addTarget:curveFilter4];
    self.endFilter = curveFilter4;
}

@end
