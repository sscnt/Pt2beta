//
//  VnEffectColorPotion9.m
//  Pastel
//
//  Created by SSC on 2014/05/03.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectColorPotion9.h"

@implementation VnEffectColorPotion9

- (id)init
{
    self = [super init];
    if(self){
        self.defaultOpacity = 0.90f;
        self.faceOpacity = 0.90f;
        self.effectId = VnEffectIdColorPotion9;
    }
    return self;
}

- (void)makeFilterGroup
{
    // Curve
    VnFilterToneCurve* curveFilter1 = [[VnFilterToneCurve alloc] initWithACV:@"ak001"];
    
    // Color Balance
    
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
    highlights.one = s255(5.0f);
    highlights.two = s255(-5.0f);
    highlights.three = s255(-11.0f);
    [colorBalance1 setHighlights:highlights];
    colorBalance1.preserveLuminosity = YES;
    colorBalance1.topLayerOpacity = 0.70f;
    
    
    // Fill Layer
    VnFilterSolidColor* solidColor = [[VnFilterSolidColor alloc] init];
    [solidColor setColorRed:s255(125.0f) green:s255(109.0f) blue:s255(87.0f) alpha:1.0f];
    solidColor.topLayerOpacity = 0.30f;
    solidColor.blendingMode = VnBlendingModeLighten;
    
    self.startFilter = curveFilter1;
    [curveFilter1 addTarget:colorBalance1];
    [colorBalance1 addTarget:solidColor];
    self.endFilter = solidColor;
}

@end
