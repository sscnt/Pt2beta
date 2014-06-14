//
//  VnEffectOverlayLightBrightHaze.m
//  Pastel
//
//  Created by SSC on 2014/05/06.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectOverlayLightBrightHaze.h"

@implementation VnEffectOverlayLightBrightHaze

- (id)init
{
    self = [super init];
    if(self){
        self.effectId = VnEffectIdOverlayLightBrightHaze;
    }
    return self;
}

- (void)makeFilterGroup
{
    
    
    // Curve
    VnFilterToneCurve* curveFilter = [[VnFilterToneCurve alloc] initWithACV:@"bn001"];
    
    
    // Levels
    VnFilterLevels* levelsFilter1 = [[VnFilterLevels alloc] init];
    [levelsFilter1 setMin:s255(40.0f) gamma:1.05f max:s255(250.0f) minOut:s255(0.0f) maxOut:s255(255.0f)];
    levelsFilter1.topLayerOpacity = 0.50f;
    
    
    // Photo Filter
    VnAdjustmentLayerPhotoFilter* photoFilter = [[VnAdjustmentLayerPhotoFilter alloc] init];
    photoFilter.color = (GPUVector3){s255(235.0f), s255(145.0f), 0.0f};
    photoFilter.density = 0.25f;
    photoFilter.preserveLuminosity = YES;
    photoFilter.topLayerOpacity = 0.15;
    
    
    
    // Levels
    VnFilterLevels* levelsFilter2 = [[VnFilterLevels alloc] init];
    [levelsFilter2 setMin:s255(3.0f) gamma:0.87f max:s255(253.0f) minOut:s255(80.0f) maxOut:s255(255.0f)];
    levelsFilter2.topLayerOpacity = 0.35f;
    
    
    // Fill Layer
    VnFilterSolidColor* solidColor = [[VnFilterSolidColor alloc] init];
    [solidColor setColorRed:s255(254.0f) green:s255(113.0f) blue:s255(133.0f) alpha:1.0f];
    solidColor.topLayerOpacity = 0.10f;
    
    
    // Levels
    ////
    GPUImageNormalBlendFilter* normalFilter = [[GPUImageNormalBlendFilter alloc] init];
    
    VnFilterLevels* levelsFilter3 = [[VnFilterLevels alloc] init];
    [levelsFilter3 setMin:s255(0.0f) gamma:1.00f max:s255(255.0f) minOut:s255(0.0f) maxOut:s255(255.0f)];
    [levelsFilter3 setBlueMin:0.0f gamma:1.00f max:s255(255.0f) minOut:s255(71.0f) maxOut:s255(255.0f)];
    
    
    VnFilterLevels* levelsFilter4 = [[VnFilterLevels alloc] init];
    [levelsFilter4 setMin:s255(40.0f) gamma:1.05f max:s255(250.0f) minOut:s255(0.0f) maxOut:s255(255.0f)];
    
    GPUImageOpacityFilter* opacityFilter = [[GPUImageOpacityFilter alloc] init];
    opacityFilter.opacity = 0.10f;
    ////
    
    VnFilterDuplicate* outputFilter = [[VnFilterDuplicate alloc] init];
    
    
    self.startFilter = curveFilter;
    [curveFilter addTarget:levelsFilter1];
    [levelsFilter1 addTarget:photoFilter];
    [photoFilter addTarget:levelsFilter2];
    [levelsFilter2 addTarget:solidColor];
    [solidColor addTarget:normalFilter];
    [solidColor addTarget:levelsFilter3];
    [levelsFilter3 addTarget:levelsFilter4];
    [levelsFilter4 addTarget:opacityFilter];
    [opacityFilter addTarget:normalFilter atTextureLocation:1];
    [normalFilter addTarget:outputFilter];
    self.endFilter = outputFilter;
}

@end
