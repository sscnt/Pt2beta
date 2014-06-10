//
//  VnEffectCarnival.m
//  Pastel
//
//  Created by SSC on 2014/05/10.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectCarnival.h"

@implementation VnEffectCarnival

- (id)init
{
    self = [super init];
    if(self){
        self.effectId = VnEffectIdCarnival;
    }
    return self;
}

- (void)makeFilterGroup
{
    // Levels
    VnFilterLevels* levelsFilter1 = [[VnFilterLevels alloc] init];
    [levelsFilter1 setMin:s255(0.0f) gamma:0.92f max:s255(255.0f) minOut:s255(0.0f) maxOut:s255(255.0f)];
    levelsFilter1.topLayerOpacity = 0.20f;
    levelsFilter1.blendingMode = VnBlendingModeScreen;
    
    // Levels
    VnFilterLevels* levelsFilter2 = [[VnFilterLevels alloc] init];
    [levelsFilter2 setMin:s255(0.0f) gamma:1.65f max:s255(255.0f) minOut:s255(0.0f) maxOut:s255(255.0f)];
    levelsFilter2.topLayerOpacity = 0.75;
    levelsFilter2.blendingMode = VnBlendingModeSoftLight;
    
    // Photo Filter
    VnAdjustmentLayerPhotoFilter* photoFilter1 = [[VnAdjustmentLayerPhotoFilter alloc] init];
    photoFilter1.color = (GPUVector3){s255(236.0f), s255(138.0f), 0.0f};
    photoFilter1.density = 0.25f;
    photoFilter1.preserveLuminosity = YES;
    photoFilter1.topLayerOpacity = 0.25f;
    
    // Fill Layer
    VnFilterSolidColor* solidColor1 = [[VnFilterSolidColor alloc] init];
    [solidColor1 setColorRed:2.0f/255.0f green:150.0f/255.0f blue:145.0f/255.0 alpha:1.0f];
    solidColor1.topLayerOpacity = 0.04f;
    solidColor1.blendingMode = VnBlendingModeExclusion;
    
    VnImageNormalBlendFilter* levelsMerge = [[VnImageNormalBlendFilter alloc] init];
    levelsMerge.topLayerOpacity = 0.50f;
    
    // Levels
    VnFilterLevels* levelsFilter3 = [[VnFilterLevels alloc] init];
    [levelsFilter3 setRedMin:s255(0.0f) gamma:1.00f max:s255(244.0f) minOut:s255(6.0f) maxOut:s255(255.0f)];
    [levelsFilter3 setGreenMin:s255(0.0f) gamma:1.00f max:s255(248.0f) minOut:s255(0.0f) maxOut:s255(240.0f)];
    [levelsFilter3 setBlueMin:s255(9.0f) gamma:1.02f max:s255(253.0f) minOut:s255(9.0f) maxOut:s255(210.0f)];
    
    VnFilterLevels* levelsFilter4 = [[VnFilterLevels alloc] init];
    [levelsFilter4 setMin:s255(0.0f) gamma:1.40f max:s255(254.0f) minOut:s255(3.0f) maxOut:s255(255.0f)];
    
    self.startFilter = levelsFilter1;
    [levelsFilter1 addTarget:levelsFilter2];
    [levelsFilter2 addTarget:photoFilter1];
    [photoFilter1 addTarget:solidColor1];
    [solidColor1 addTarget:levelsMerge];
    [solidColor1 addTarget:levelsFilter3];
    [levelsFilter3 addTarget:levelsFilter4];
    [levelsFilter4 addTarget:levelsMerge atTextureLocation:1];
    self.endFilter = levelsMerge;
    
}

@end
