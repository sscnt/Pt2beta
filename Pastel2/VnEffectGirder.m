//
//  GPUEffectGirder.m
//  Gravy_1.0
//
//  Created by SSC on 2014/01/12.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectGirder.h"

@implementation VnEffectGirder

- (id)init
{
    self = [super init];
    if(self){
        self.defaultOpacity = 0.90f;
        self.faceOpacity = 0.70f;
        self.effectId = VnEffectIdGirder;
    }
    return self;
}

- (void)makeFilterGroup
{
    // Curve
    VnFilterToneCurve* curveFilter1 = [[VnFilterToneCurve alloc] initWithACV:@"gi1"];
    
    
    // Hue / Saturation
    VnAdjustmentLayerHueSaturation* hueSaturation = [[VnAdjustmentLayerHueSaturation alloc] init];
    hueSaturation.hue = 0.0f;
    hueSaturation.saturation = -15.0f;
    hueSaturation.lightness = 0.0f;
    hueSaturation.colorize =  NO;
    
    // Curve
    VnFilterToneCurve* curveFilter2 = [[VnFilterToneCurve alloc] initWithACV:@"gi2"];
    
    // Photo Filter
    VnAdjustmentLayerPhotoFilter* photoFilter1 = [[VnAdjustmentLayerPhotoFilter alloc] init];
    [photoFilter1 setColorRed:s255(255.0f) Green:s255(213.0f) Blue:s255(0.0f)];
    photoFilter1.density = 0.10f;
    photoFilter1.topLayerOpacity = 0.25f;
    
    
    // Curve
    VnFilterToneCurve* curveFilter3 = [[VnFilterToneCurve alloc] initWithACV:@"gi3"];
        
    // Color Balance
    VnAdjustmentLayerColorBalance* colorBalance1 = [[VnAdjustmentLayerColorBalance alloc] init];
    GPUVector3 shadows1;
    shadows1.one = 0.0f;
    shadows1.two = 0.0f;
    shadows1.three = 0.0f;
    [colorBalance1 setShadows:shadows1];
    GPUVector3 midtones1;
    midtones1.one = -10.0f/255.0f;
    midtones1.two = 0.0f/255.0f;
    midtones1.three = 30.0f/255.0f;
    [colorBalance1 setMidtones:midtones1];
    GPUVector3 highlights1;
    highlights1.one = 0.0f/255.0f;
    highlights1.two = 0.0f/255.0f;
    highlights1.three = 0.0f/255.0f;
    [colorBalance1 setHighlights:highlights1];
    colorBalance1.preserveLuminosity = YES;
    
    
    // Color Balance
    VnAdjustmentLayerColorBalance* colorBalance2 = [[VnAdjustmentLayerColorBalance alloc] init];
    GPUVector3 shadows2;
    shadows2.one = 0.0f;
    shadows2.two = 0.0f;
    shadows2.three = 0.0f;
    [colorBalance2 setShadows:shadows2];
    GPUVector3 midtones2;
    midtones2.one = 45.0f/255.0f;
    midtones2.two = 0.0f/255.0f;
    midtones2.three = -60.0f/255.0f;
    [colorBalance2 setMidtones:midtones2];
    GPUVector3 highlights2;
    highlights2.one = 0.0f/255.0f;
    highlights2.two = 0.0f/255.0f;
    highlights2.three = 0.0f/255.0f;
    [colorBalance2 setHighlights:highlights2];
    colorBalance2.preserveLuminosity = YES;
    
    // Curve
    VnFilterToneCurve* curveFilter4 = [[VnFilterToneCurve alloc] initWithACV:@"gi4"];
    
    // Levels
    VnFilterLevels* levelsFilter1 = [[VnFilterLevels alloc] init];
    [levelsFilter1 setMin:5.0f/255.0f gamma:1.05f max:255.0f/255.0f minOut:5.0/255.0f maxOut:1.0f];
    
    // Gradient Map
    VnAdjustmentLayerGradientMap* gradientMap1 = [[VnAdjustmentLayerGradientMap alloc] init];
    [gradientMap1 addColorRed:107.0f Green:107.0f Blue:107.0f Opacity:100.0f Location:0 Midpoint:50];
    [gradientMap1 addColorRed:14.0f Green:37.0f Blue:68.0f Opacity:100.0f Location:4096 Midpoint:50];
    gradientMap1.topLayerOpacity = 0.25f;
    gradientMap1.blendingMode = VnBlendingModeExclusion;
    
    
    // Fill Layer
    VnFilterSolidColor* solidColor1 = [[VnFilterSolidColor alloc] init];
    [solidColor1 setColorRed:40.0f/255.0f green:40.0f/255.0f blue:40.0f/255.0 alpha:1.0f];
    solidColor1.blendingMode = VnBlendingModeLighten;
    
    
    self.startFilter = curveFilter1;
    [curveFilter1 addTarget:hueSaturation];
    [hueSaturation addTarget:curveFilter2];
    [curveFilter2 addTarget:photoFilter1];
    [photoFilter1 addTarget:curveFilter3];
    [curveFilter3 addTarget:colorBalance1];
    [colorBalance1 addTarget:colorBalance2];
    [colorBalance2 addTarget:curveFilter4];
    [curveFilter4 addTarget:levelsFilter1];
    [levelsFilter1 addTarget:gradientMap1];
    [gradientMap1 addTarget:solidColor1];
    self.endFilter = solidColor1;
}




@end
