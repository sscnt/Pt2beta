//
//  VnEffectVSCOPalewash.m
//  Pastel2
//
//  Created by SSC on 2014/06/15.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectVSCOBrown.h"

@implementation VnEffectVSCOBrown

- (id)init
{
    self = [super init];
    if(self){
        self.effectId = VnEffectIdVSCOBrown;
    }
    return self;
}

- (void)makeFilterGroup
{
    
    // Hue / Saturation
    VnAdjustmentLayerHueSaturation* hueSaturation = [[VnAdjustmentLayerHueSaturation alloc] init];
    hueSaturation.hue = 0.0f;
    hueSaturation.saturation = -20;
    hueSaturation.lightness = 0.0f;
    hueSaturation.colorize = NO;
    
    // Curve
    VnFilterToneCurve* curveFilter1 = [[VnFilterToneCurve alloc] initWithACV:@"cg001"];
    
    // Selective Color
    VnAdjustmentLayerSelectiveColor* selectiveColor1 = [[VnAdjustmentLayerSelectiveColor alloc] init];
    [selectiveColor1 setRedsCyan:14 Magenta:0 Yellow:39 Black:13];
    [selectiveColor1 setYellowsCyan:0 Magenta:-5 Yellow:20 Black:0];
    [selectiveColor1 setBluesCyan:0 Magenta:-20 Yellow:25 Black:15];
    [selectiveColor1 setMagentasCyan:18 Magenta:-9 Yellow:16 Black:-8];
    
    // Photo Filter
    VnAdjustmentLayerPhotoFilter* photoFilter1 = [[VnAdjustmentLayerPhotoFilter alloc] init];
    photoFilter1.color = (GPUVector3){s255(126.0f), s255(103.0f), s255(71.0f)};
    photoFilter1.density = 0.01;
    photoFilter1.preserveLuminosity = YES;
    photoFilter1.topLayerOpacity = 1.0f;
    
    // Curve
    VnFilterToneCurve* curveFilter2 = [[VnFilterToneCurve alloc] initWithACV:@"cg002"];
    
    // Fill Layer
    VnFilterSolidColor* solidColor1 = [[VnFilterSolidColor alloc] init];
    [solidColor1 setColorRed:108.0f/255.0f green:78.0f/255.0f blue:50.0f/255.0 alpha:1.0f];
    solidColor1.topLayerOpacity = 0.71f * 0.53f;;
    solidColor1.blendingMode = VnBlendingModeLighten;
    
    self.startFilter = hueSaturation;
    [hueSaturation addTarget:curveFilter1];
    [curveFilter1 addTarget:selectiveColor1];
    [selectiveColor1 addTarget:photoFilter1];
    [photoFilter1 addTarget:curveFilter2];
    [curveFilter2 addTarget:solidColor1];
    self.endFilter = solidColor1;

    
}
@end
