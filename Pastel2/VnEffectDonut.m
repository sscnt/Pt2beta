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
    
    // Fill Layer
    VnFilterSolidColor* solidColor1 = [[VnFilterSolidColor alloc] init];
    [solidColor1 setColorRed:109.0f/255.0f green:131.0f/255.0f blue:249.0f/255.0 alpha:1.0f];
    solidColor1.topLayerOpacity = 0.75f;
    solidColor1.blendingMode = VnBlendingModeSoftLight;
    
    
    // Color Balance
    VnAdjustmentLayerColorBalance* colorBalance1 = [[VnAdjustmentLayerColorBalance alloc] init];
    GPUVector3 shadows1;
    shadows1.one = s255(0.0f);
    shadows1.two = s255(0.0f);
    shadows1.three = s255(0.0f);
    [colorBalance1 setShadows:shadows1];
    GPUVector3 midtones1;
    midtones1.one = s255(7.0f);
    midtones1.two = s255(-27.0f);
    midtones1.three = s255(-24.0f);
    [colorBalance1 setMidtones:midtones1];
    GPUVector3 highlights1;
    highlights1.one = s255(9.0f);
    highlights1.two = s255(7.0f);
    highlights1.three = s255(-11.0f);
    [colorBalance1 setHighlights:highlights1];
    colorBalance1.preserveLuminosity = YES;
    
    
    
    // Fill Layer
    VnFilterSolidColor* solidColor2 = [[VnFilterSolidColor alloc] init];
    [solidColor2 setColorRed:155.0f/255.0f green:159.0f/255.0f blue:113.0f/255.0 alpha:1.0f];
    solidColor2.topLayerOpacity = 0.20f;
    solidColor2.blendingMode = VnBlendingModeOverlay;
    
    
    // Curve
    VnFilterToneCurve* curveFilter1 = [[VnFilterToneCurve alloc] initWithACV:@"bz001"];
    curveFilter1.topLayerOpacity = 0.80f;
    
    // Fill Layer
    VnAdjustmentLayerGradientColorFill* gradientColor1 = [[VnAdjustmentLayerGradientColorFill alloc] initWithEffectObj:self];
    [gradientColor1 setStyle:GradientStyleRadial];
    [gradientColor1 setAngleDegree:0.0f];
    [gradientColor1 setScalePercent:200];
    [gradientColor1 setOffsetX:0.0f Y:0.0f];
    [gradientColor1 addColorRed:229.0f Green:193.0f Blue:75.0f Opacity:0.0f Location:0 Midpoint:50];
    [gradientColor1 addColorRed:114.0f Green:122.0f Blue:235.0f Opacity:100.0f Location:4096 Midpoint:50];
    gradientColor1.topLayerOpacity = 0.50f;
    gradientColor1.blendingMode = VnBlendingModeSoftLight;
    
    
    // Color Balance
    VnAdjustmentLayerColorBalance* colorBalance2 = [[VnAdjustmentLayerColorBalance alloc] init];
    GPUVector3 shadows2;
    shadows2.one = s255(0.0f);
    shadows2.two = s255(0.0f);
    shadows2.three = s255(-2.0f);
    [colorBalance2 setShadows:shadows2];
    GPUVector3 midtones2;
    midtones2.one = s255(-2.0f);
    midtones2.two = s255(1.0f);
    midtones2.three = s255(2.0f);
    [colorBalance2 setMidtones:midtones2];
    GPUVector3 highlights2;
    highlights2.one = s255(8.0f);
    highlights2.two = s255(4.0f);
    highlights2.three = s255(10.0f);
    [colorBalance2 setHighlights:highlights2];
    colorBalance2.preserveLuminosity = YES;    
    
    // Fill Layer
    VnFilterSolidColor* solidColor3 = [[VnFilterSolidColor alloc] init];
    [solidColor3 setColorRed:0.0f/255.0f green:0.0f/255.0f blue:40.0f/255.0 alpha:1.0f];
    solidColor3.topLayerOpacity = 0.30f;
    solidColor3.blendingMode = VnBlendingModeExclusion;
    
    
    // Color Balance
    VnAdjustmentLayerColorBalance* colorBalance3 = [[VnAdjustmentLayerColorBalance alloc] init];
    GPUVector3 shadows3;
    shadows3.one = s255(0.0f);
    shadows3.two = s255(0.0f);
    shadows3.three = s255(0.0f);
    [colorBalance3 setShadows:shadows3];
    GPUVector3 midtones3;
    midtones3.one = s255(25.0f);
    midtones3.two = s255(-3.0f);
    midtones3.three = s255(0.0f);
    [colorBalance3 setMidtones:midtones3];
    GPUVector3 highlights3;
    highlights3.one = s255(0.0f);
    highlights3.two = s255(-1.0f);
    highlights3.three = s255(1.0f);
    [colorBalance3 setHighlights:highlights3];
    colorBalance3.preserveLuminosity = YES;
    
    self.startFilter = solidColor1;
    [solidColor1 addTarget:colorBalance1];
    [colorBalance1 addTarget:solidColor2];
    [solidColor2 addTarget:curveFilter1];
    [curveFilter1 addTarget:gradientColor1];
    [gradientColor1 addTarget:colorBalance2];
    [colorBalance2 addTarget:solidColor3];
    [solidColor3 addTarget:colorBalance3];
    self.endFilter = colorBalance3;
}

@end
