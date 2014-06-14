//
//  VnEffectSweetFlower.m
//  Pastel
//
//  Created by SSC on 2014/05/08.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectSweetFlower.h"

@implementation VnEffectSweetFlower

- (id)init
{
    self = [super init];
    if(self){
        self.effectId = VnEffectIdSweetFlower;
    }
    return self;
}

- (void)makeFilterGroup
{
    // Selective Color
    VnAdjustmentLayerSelectiveColor* selectiveColor1 = [[VnAdjustmentLayerSelectiveColor alloc] init];
    [selectiveColor1 setRedsCyan:-22 Magenta:16 Yellow:33 Black:0];
    [selectiveColor1 setYellowsCyan:-45 Magenta:16 Yellow:32 Black:0];
    [selectiveColor1 setGreensCyan:4 Magenta:21 Yellow:-13 Black:0];
    [selectiveColor1 setCyansCyan:-2 Magenta:-2 Yellow:29 Black:0];
    [selectiveColor1 setBluesCyan:-27 Magenta:0 Yellow:22 Black:0];
    [selectiveColor1 setNeutralsCyan:-20 Magenta:4 Yellow:7 Black:1];
    
    // Curve
    VnFilterToneCurve* curveFilter1 = [[VnFilterToneCurve alloc] initWithACV:@"bt001"];
    
    // Selective Color
    VnAdjustmentLayerSelectiveColor* selectiveColor2 = [[VnAdjustmentLayerSelectiveColor alloc] init];
    [selectiveColor2 setRedsCyan:14 Magenta:1 Yellow:4 Black:0];
    [selectiveColor2 setYellowsCyan:2 Magenta:16 Yellow:32 Black:0];
    [selectiveColor2 setGreensCyan:4 Magenta:-10 Yellow:-11 Black:0];
    
    // Fill Layer
    VnFilterSolidColor* solidColor1 = [[VnFilterSolidColor alloc] init];
    [solidColor1 setColorRed:0.0f/255.0f green:11.0f/255.0f blue:50.0f/255.0 alpha:1.0f];
    solidColor1.topLayerOpacity = 0.30f;
    solidColor1.blendingMode = VnBlendingModeExclusion;
    
    // Fill Layer
    VnFilterSolidColor* solidColor2 = [[VnFilterSolidColor alloc] init];
    [solidColor2 setColorRed:29.0f/255.0f green:137.0f/255.0f blue:211.0f/255.0 alpha:1.0f];
    solidColor2.topLayerOpacity = 0.15f;
    solidColor2.blendingMode = VnBlendingModeExclusion;
    
    // Color Balance
    VnAdjustmentLayerColorBalance* colorBalance1 = [[VnAdjustmentLayerColorBalance alloc] init];
    GPUVector3 shadows;
    shadows.one = s255(0.0f);
    shadows.two = s255(0.0f);
    shadows.three = s255(0.0f);
    [colorBalance1 setShadows:shadows];
    GPUVector3 midtones;
    midtones.one = s255(-10.0f);
    midtones.two = s255(0.0f);
    midtones.three = s255(23.0f);
    [colorBalance1 setMidtones:midtones];
    GPUVector3 highlights;
    highlights.one = s255(0.0f);
    highlights.two = s255(0.0f);
    highlights.three = s255(0.0f);
    [colorBalance1 setHighlights:highlights];
    colorBalance1.preserveLuminosity = YES;
    colorBalance1.topLayerOpacity = 0.90f;
    
    // Curve
    VnFilterToneCurve* curveFilter2 = [[VnFilterToneCurve alloc] initWithACV:@"bt002"];
    
    self.startFilter = selectiveColor1;
    [selectiveColor1 addTarget:curveFilter1];
    [curveFilter1 addTarget:selectiveColor2];
    [selectiveColor2 addTarget:solidColor1];
    [solidColor1 addTarget:solidColor2];
    [solidColor2 addTarget:colorBalance1];
    [colorBalance1 addTarget:curveFilter2];
    self.endFilter = curveFilter2;
    
}

@end
