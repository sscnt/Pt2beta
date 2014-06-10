//
//  GPUEffectBeachVintage.m
//  Gravy_1.0
//
//  Created by SSC on 2013/12/15.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "VnEffectBeachVintage.h"

@implementation VnEffectBeachVintage

- (id)init
{
    self = [super init];
    if(self){
        self.defaultOpacity = 1.0f;
        self.effectId = VnEffectIdBeachVintage;
    }
    return self;
}

- (void)makeFilterGroup
{
    VnFilterPassThrough* inputFilter = [[VnFilterPassThrough alloc] init];
    
    VnImageNormalBlendFilter* mergeFilter1 = [[VnImageNormalBlendFilter alloc] init];
    mergeFilter1.topLayerOpacity = 0.40f;
    mergeFilter1.blendingMode = VnBlendingModeOverlay;
    
    // Duplicate
    VnFilterDuplicate* duplicateFilter1 = [[VnFilterDuplicate alloc] init];
    duplicateFilter1.blendingMode = VnBlendingModeOverlay;
    duplicateFilter1.topLayerOpacity = 0.40f;
    
    // Fill Layer
    VnFilterSolidColor* solidColor1 = [[VnFilterSolidColor alloc] init];
    [solidColor1 setColorRed:219.0f/255.0f green:221.0f/255.0f blue:179.0f/255.0 alpha:1.0f];
    solidColor1.blendingMode = VnBlendingModeHardLight;
    solidColor1.topLayerOpacity = 0.20f;
    
    
    // Fill Layer
    VnFilterSolidColor* solidColor2 = [[VnFilterSolidColor alloc] init];
    [solidColor2 setColorRed:251.0f/255.0f green:255.0f/255.0f blue:221.0f/255.0 alpha:1.0f];
    solidColor2.topLayerOpacity = 0.69f;
    solidColor2.blendingMode = VnBlendingModeSoftLight;
    
    // Fill Layer
    VnFilterSolidColor* solidColor3 = [[VnFilterSolidColor alloc] init];
    [solidColor3 setColorRed:6.0f/255.0f green:0.0f/255.0f blue:255.0f/255.0 alpha:1.0f];
    solidColor3.blendingMode = VnBlendingModeExclusion;
    solidColor3.topLayerOpacity = 0.30f;
    
    
    // Fill Layer
    VnFilterSolidColor* solidColor4 = [[VnFilterSolidColor alloc] init];
    [solidColor4 setColorRed:255.0f/255.0f green:121.0f/255.0f blue:151.0f/255.0 alpha:1.0f];
    solidColor4.blendingMode = VnBlendingModeLinearDodge;
    solidColor4.topLayerOpacity = 0.15f;

    
    self.startFilter = inputFilter;
    [inputFilter addTarget:duplicateFilter1];
    [inputFilter addTarget:mergeFilter1 atTextureLocation:1];
    [duplicateFilter1 addTarget:solidColor1];
    [solidColor1 addTarget:solidColor2];
    [solidColor2 addTarget:solidColor3];
    [solidColor3 addTarget:solidColor4];
    [solidColor4 addTarget:mergeFilter1 atTextureLocation:0];
    self.endFilter = mergeFilter1;
}

@end
