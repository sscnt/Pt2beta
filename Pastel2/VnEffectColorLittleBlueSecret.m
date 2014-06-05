//
//  VnEffectColorLittleBlueSecret.m
//  Pastel
//
//  Created by SSC on 2014/05/03.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectColorLittleBlueSecret.h"

@implementation VnEffectColorLittleBlueSecret

- (id)init
{
    self = [super init];
    if(self){
        self.effectId = VnEffectIdColorLittleBlueSecret;
    }
    return self;
}

- (void)makeFilterGroup
{
    //// Curve
    VnFilterToneCurve* curveFilter1 = [[VnFilterToneCurve alloc] initWithACV:@"clbs"];
    curveFilter1.blendingMode = VnBlendingModeNormal;
    curveFilter1.topLayerOpacity = 0.60f;
    
    //// Solid Color
    VnFilterSolidColor* solidColor1 = [[VnFilterSolidColor alloc] init];
    [solidColor1 setColorRed:s255(2.0f) green:s255(21.0f) blue:s255(117.0f) alpha:1.0f];
    solidColor1.topLayerOpacity = 0.10f;
    solidColor1.blendingMode = VnBlendingModeLighten;
    
    //// Color Balance
    VnAdjustmentLayerColorBalance* colorBalance1 = [[VnAdjustmentLayerColorBalance alloc] init];
    GPUVector3 shadows;
    shadows.one = s255(0.0f);
    shadows.two = s255(0.0f);
    shadows.three = s255(0.0f);
    [colorBalance1 setShadows:shadows];
    GPUVector3 midtones;
    midtones.one = s255(0.0f);
    midtones.two = s255(0.0f);
    midtones.three = s255(0.0f);
    [colorBalance1 setMidtones:midtones];
    GPUVector3 highlights;
    highlights.one = s255(9.0f);
    highlights.two = s255(0.0f);
    highlights.three = s255(-12.0f);
    [colorBalance1 setHighlights:highlights];
    colorBalance1.preserveLuminosity = YES;
    colorBalance1.topLayerOpacity = 0.10f;
    colorBalance1.blendingMode = VnBlendingModeNormal;
    
    self.startFilter = curveFilter1;
    [curveFilter1 addTarget:solidColor1];
    [solidColor1 addTarget:colorBalance1];
    self.endFilter = colorBalance1;    
}

@end
