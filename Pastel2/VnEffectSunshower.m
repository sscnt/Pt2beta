//
//  VnEffectSunshower.m
//  Pastel2
//
//  Created by SSC on 2014/06/14.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectSunshower.h"

@implementation VnEffectSunshower

- (id)init
{
    self = [super init];
    if(self){
        self.effectId = VnEffectIdSunshower;
    }
    return self;
}

- (void)makeFilterGroup
{
    // Lighten
    VnFilterDuplicate* lightenFilter = [[VnFilterDuplicate alloc] init];
    lightenFilter.blendingMode = VnBlendingModeScreen;
    lightenFilter.topLayerOpacity = 0.25f;
    
    // Curve
    VnFilterToneCurve* curveFilter1 = [[VnFilterToneCurve alloc] initWithACV:@"aa001"];
    curveFilter1.topLayerOpacity = 0.70f;
    
    // Photo Filter
    VnAdjustmentLayerPhotoFilter* photoFilter1 = [[VnAdjustmentLayerPhotoFilter alloc] init];
    photoFilter1.color = (GPUVector3){s255(0.0f), s255(181.0f), s255(255.0f)};
    photoFilter1.density = 0.125f;
    photoFilter1.preserveLuminosity = YES;
    photoFilter1.topLayerOpacity = 0.04f;
    
    // Fill Layer
    VnFilterSolidColor* solidColor1 = [[VnFilterSolidColor alloc] init];
    [solidColor1 setColorRed:8.0f/255.0f green:114.0f/255.0f blue:127.0f/255.0 alpha:1.0f];
    solidColor1.topLayerOpacity = 0.18f;
    solidColor1.blendingMode = VnBlendingModeExclusion;
    
    // Levels
    VnFilterLevels* levelsFilter1 = [[VnFilterLevels alloc] init];
    [levelsFilter1 setMin:s255(14.0f) gamma:1.34f max:s255(249.0f) minOut:s255(34.0f) maxOut:1.0f];
    levelsFilter1.topLayerOpacity = 0.30f;
    
    // Color Balance
    VnAdjustmentLayerColorBalance* colorBalance1 = [[VnAdjustmentLayerColorBalance alloc] init];
    GPUVector3 shadows;
    shadows.one = s255(0.0f);
    shadows.two = s255(0.0f);
    shadows.three = s255(0.0f);
    [colorBalance1 setShadows:shadows];
    GPUVector3 midtones;
    midtones.one = s255(6.0f);
    midtones.two = s255(0.0f);
    midtones.three = s255(-8.0f);
    [colorBalance1 setMidtones:midtones];
    GPUVector3 highlights;
    highlights.one = s255(6.0f);
    highlights.two = s255(0.0f);
    highlights.three = s255(-9.0f);
    [colorBalance1 setHighlights:highlights];
    colorBalance1.preserveLuminosity = YES;
    colorBalance1.topLayerOpacity = 0.20f;
    
    // Levels
    VnFilterLevels* levelsFilter2 = [[VnFilterLevels alloc] init];
    [levelsFilter2 setMin:s255(0.0f) gamma:1.14f max:s255(255.0f) minOut:s255(6.0f) maxOut:s255(250.0f)];
    levelsFilter2.topLayerOpacity = 0.50f;
    levelsFilter2.blendingMode = VnBlendingModeSoftLight;
    
    // Levels
    VnFilterLevels* levelsFilter3 = [[VnFilterLevels alloc] init];
    [levelsFilter3 setMin:s255(20.0f) gamma:1.14f max:s255(240.0f) minOut:s255(70.0f) maxOut:s255(255.0f)];
    levelsFilter3.topLayerOpacity = 0.50f;
    
    self.startFilter = lightenFilter;
    [lightenFilter addTarget:curveFilter1];
    [curveFilter1 addTarget:photoFilter1];
    [photoFilter1 addTarget:solidColor1];
    [solidColor1 addTarget:levelsFilter1];
    [levelsFilter1 addTarget:colorBalance1];
    [colorBalance1 addTarget:levelsFilter2];
    [levelsFilter2 addTarget:levelsFilter3];
    self.endFilter = levelsFilter3;
}

@end
