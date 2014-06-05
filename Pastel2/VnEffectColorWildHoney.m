//
//  VnEffectColorWildHoney.m
//  Pastel
//
//  Created by SSC on 2014/05/03.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectColorWildHoney.h"

@implementation VnEffectColorWildHoney

- (id)init
{
    self = [super init];
    if(self){
        self.defaultOpacity = 0.70f;
        self.faceOpacity = 0.70f;
        self.effectId = VnEffectIdColorWildHoney;
    }
    return self;
}

- (void)makeFilterGroup
{
    // Levels
    VnFilterLevels* levelsFilter1 = [[VnFilterLevels alloc] init];
    [levelsFilter1 setRedMin:s255(0.0f) gamma:1.14f max:s255(255.0f) minOut:s255(8.0f) maxOut:s255(255.0f)];
    [levelsFilter1 setGreenMin:s255(10.0f) gamma:0.95f max:s255(255.0f) minOut:s255(10.0f) maxOut:s255(252.0f)];
    [levelsFilter1 setBlueMin:s255(15.0f) gamma:1.10f max:s255(255.0f) minOut:s255(65.0f) maxOut:s255(190.0f)];
    
    
    // Levels
    VnFilterLevels* levelsFilter2 = [[VnFilterLevels alloc] init];
    [levelsFilter2 setMin:s255(10.0f) gamma:1.2f max:s255(254.0f) minOut:s255(30.0f) maxOut:s255(254.0f)];
    
    // Gradient Map
    VnAdjustmentLayerGradientMap* gradientMap = [[VnAdjustmentLayerGradientMap alloc] init];
    [gradientMap addColorRed:49.0f Green:15.0f Blue:10.0f Opacity:100.0f Location:0 Midpoint:50];
    [gradientMap addColorRed:249.0f Green:228.0f Blue:198.0f Opacity:100.0f Location:4096 Midpoint:50];
    gradientMap.blendingMode = VnBlendingModeSoftLight;
    gradientMap.topLayerOpacity = 0.05f;
    
    self.startFilter = levelsFilter1;
    [levelsFilter1 addTarget:levelsFilter2];
    [levelsFilter2 addTarget:gradientMap];
    self.endFilter = gradientMap;
}

@end
