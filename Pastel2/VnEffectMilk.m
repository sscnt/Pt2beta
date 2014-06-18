//
//  VnEffectMilk.m
//  Pastel2
//
//  Created by SSC on 2014/06/18.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectMilk.h"

@implementation VnEffectMilk

- (id)init
{
    self = [super init];
    if(self){
        self.effectId = VnEffectIdMilk;
    }
    return self;
}

- (void)makeFilterGroup
{
    // Lighten
    VnFilterDuplicate* duplicateFilter = [[VnFilterDuplicate alloc] init];
    duplicateFilter.blendingMode = VnBlendingModeScreen;
    duplicateFilter.topLayerOpacity = 0.10f;
    
    // Levels
    VnFilterLevels* levelsFilter1 = [[VnFilterLevels alloc] init];
    [levelsFilter1 setMin:s255(55.0f) gamma:1.12f max:s255(217.0f)];
    levelsFilter1.blendingMode = VnBlendingModeOverlay;
    levelsFilter1.topLayerOpacity = 0.40f;
    
    // Levels
    VnFilterLevels* levelsFilter2 = [[VnFilterLevels alloc] init];
    [levelsFilter2 setMin:s255(0.0f) gamma:1.0f max:s255(255.0f)];
    [levelsFilter2 setBlueMin:s255(14.0f) gamma:1.0f max:s255(224.0f) minOut:s255(35.0f) maxOut:s255(200.0f)];
    levelsFilter2.topLayerOpacity = 0.40f;
    
    // Fill Layer
    VnFilterSolidColor* solidColor1 = [[VnFilterSolidColor alloc] init];
    [solidColor1 setColorRed:245.0f/255.0f green:237.0f/255.0f blue:234.0f/255.0 alpha:1.0f];
    solidColor1.blendingMode = VnBlendingModeScreen;
    solidColor1.topLayerOpacity = 0.15f;
    
    // Levels
    VnFilterLevels* levelsFilter3 = [[VnFilterLevels alloc] init];
    [levelsFilter3 setMin:s255(0.0f) gamma:1.0f max:s255(255.0f) minOut:s255(72.0f) maxOut:1.0f];
    levelsFilter3.topLayerOpacity = 0.30f;
    
    // Levels
    VnFilterLevels* levelsFilter4 = [[VnFilterLevels alloc] init];
    [levelsFilter4 setMin:s255(0.0f) gamma:1.0f max:s255(255.0f)];
    [levelsFilter4 setBlueMin:0.0f gamma:1.0f max:1.0f minOut:s255(50.0f) maxOut:1.0f];
    levelsFilter4.topLayerOpacity = 0.15f;
    
    // Levels
    VnFilterLevels* levelsFilter5 = [[VnFilterLevels alloc] init];
    [levelsFilter5 setMin:s255(0.0f) gamma:1.0f max:s255(255.0f)];
    [levelsFilter5 setRedMin:0.0f gamma:1.0f max:1.0f minOut:s255(35.0f) maxOut:1.0f];
    
    // Levels
    VnFilterLevels* levelsFilter6 = [[VnFilterLevels alloc] init];
    [levelsFilter6 setMin:s255(0.0f) gamma:1.0f max:s255(255.0f) minOut:s255(35.0f) maxOut:1.0f];
    
    VnImageNormalBlendFilter* levelsMerge = [[VnImageNormalBlendFilter alloc] init];
    levelsMerge.topLayerOpacity = 0.10f;
    VnFilterPassThrough* levelsInput = [[VnFilterPassThrough alloc] init];
    
    
    self.startFilter = duplicateFilter;
    [duplicateFilter addTarget:levelsFilter1];
    [levelsFilter1 addTarget:levelsFilter2];
    [levelsFilter2 addTarget:solidColor1];
    [solidColor1 addTarget:levelsFilter3];
    [levelsFilter3 addTarget:levelsFilter4];
    [levelsFilter4 addTarget:levelsInput];
    [levelsInput addTarget:levelsFilter5];
    [levelsInput addTarget:levelsMerge];
    [levelsFilter5 addTarget:levelsFilter6];
    [levelsFilter6 addTarget:levelsMerge atTextureLocation:1];
    self.endFilter = levelsMerge;
}

@end
