//
//  VnEffectDorian.m
//  Pastel2
//
//  Created by SSC on 2014/06/17.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectDorian.h"

@implementation VnEffectDorian

- (id)init
{
    self = [super init];
    if(self){
        self.effectId = VnEffectIdDorian;
    }
    return self;
}

- (void)makeFilterGroup
{
    // Curve
    VnFilterToneCurve* curveFilter1 = [[VnFilterToneCurve alloc] initWithACV:@"ck001"];
    
    // Fill Layer
    VnFilterSolidColor* solidColor1 = [[VnFilterSolidColor alloc] init];
    [solidColor1 setColorRed:153.0f/255.0f green:156.0f/255.0f blue:120.0f/255.0 alpha:1.0f];
    solidColor1.topLayerOpacity = 0.10f;
    
    // Photo Filter
    VnAdjustmentLayerPhotoFilter* photoFilter = [[VnAdjustmentLayerPhotoFilter alloc] init];
    photoFilter.color = (GPUVector3){s255(210.0f), s255(126.0f), s255(34.0f)};
    photoFilter.density = 0.03f;
    photoFilter.preserveLuminosity = YES;
    
    // Levels
    VnFilterLevels* levelsFilter1 = [[VnFilterLevels alloc] init];
    [levelsFilter1 setMin:s255(0.0f) gamma:0.91f max:s255(215.0f) minOut:s255(0.0f) maxOut:s255(255.0f)];
    
    // Selective Color
    VnAdjustmentLayerSelectiveColor* selectiveColor1 = [[VnAdjustmentLayerSelectiveColor alloc] init];
    [selectiveColor1 setRedsCyan:51 Magenta:24 Yellow:23 Black:1];
    [selectiveColor1 setYellowsCyan:0 Magenta:75 Yellow:25 Black:0];
    [selectiveColor1 setGreensCyan:8 Magenta:0 Yellow:50 Black:100];
    [selectiveColor1 setCyansCyan:-24 Magenta:-20 Yellow:23 Black:47];
    [selectiveColor1 setBluesCyan:73 Magenta:-42 Yellow:-10 Black:-6];
    [selectiveColor1 setBlacksCyan:0 Magenta:0 Yellow:0 Black:10];
    
    self.startFilter = curveFilter1;
    [curveFilter1 addTarget:solidColor1];
    [solidColor1 addTarget:photoFilter];
    [photoFilter addTarget:levelsFilter1];
    [levelsFilter1 addTarget:selectiveColor1];
    self.endFilter = selectiveColor1;
    
    
}

@end
