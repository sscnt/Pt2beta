//
//  VnEffectGrove.m
//  Pastel2
//
//  Created by SSC on 2014/06/17.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectGrove.h"

@implementation VnEffectGrove

- (id)init
{
    self = [super init];
    if(self){
        self.effectId = VnEffectIdGrove;
    }
    return self;
}

- (void)makeFilterGroup
{
    
    // Curve
    VnFilterToneCurve* curveFilter1 = [[VnFilterToneCurve alloc] initWithACV:@"cm001"];
    curveFilter1.topLayerOpacity = 0.80f;
    
    // Photo Filter
    VnAdjustmentLayerPhotoFilter* photoFilter = [[VnAdjustmentLayerPhotoFilter alloc] init];
    photoFilter.color = (GPUVector3){s255(235.0f), s255(127.0f), s255(11.0f)};
    photoFilter.density = 0.03f;
    photoFilter.preserveLuminosity = YES;
    
    // Levels
    VnFilterLevels* levelsFilter1 = [[VnFilterLevels alloc] init];
    [levelsFilter1 setMin:s255(0.0f) gamma:1.18f max:s255(241.0f) minOut:s255(0.0f) maxOut:s255(255.0f)];
    
    // Selective Color
    VnAdjustmentLayerSelectiveColor* selectiveColor1 = [[VnAdjustmentLayerSelectiveColor alloc] init];
    [selectiveColor1 setRedsCyan:42 Magenta:24 Yellow:23 Black:1];
    [selectiveColor1 setYellowsCyan:0 Magenta:75 Yellow:25 Black:0];
    [selectiveColor1 setGreensCyan:8 Magenta:0 Yellow:50 Black:100];
    [selectiveColor1 setCyansCyan:-24 Magenta:-20 Yellow:23 Black:47];
    [selectiveColor1 setCyansCyan:73 Magenta:-42 Yellow:-10 Black:-6];
    [selectiveColor1 setBlacksCyan:0 Magenta:0 Yellow:0 Black:10];
    
    // Exposure
    VnFilterExposure* exposureFilter = [[VnFilterExposure alloc] init];
    exposureFilter.gamma = 1.05f;
    
    // Fill Layer
    VnFilterSolidColor* solidColor1 = [[VnFilterSolidColor alloc] init];
    [solidColor1 setColorRed:90.0f/255.0f green:86.0f/255.0f blue:78.0f/255.0 alpha:1.0f];
    solidColor1.topLayerOpacity = 0.30f;
    solidColor1.blendingMode = VnBlendingModeLighten;
    
    self.startFilter = curveFilter1;
    [curveFilter1 addTarget:photoFilter];
    [photoFilter addTarget:levelsFilter1];
    [levelsFilter1 addTarget:selectiveColor1];
    [selectiveColor1 addTarget:exposureFilter];
    [exposureFilter addTarget:solidColor1];
    self.endFilter = solidColor1;
    
}

@end
