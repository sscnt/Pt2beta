//
//  VnEffectFruitPop.m
//  Pastel
//
//  Created by SSC on 2014/05/08.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectFruitPop.h"

@implementation VnEffectFruitPop

- (id)init
{
    self = [super init];
    if(self){
        self.effectId = VnEffectIdFruitPop;
    }
    return self;
}

- (void)makeFilterGroup
{
    
    // Fill Layer
    VnFilterSolidColor* solidColor1 = [[VnFilterSolidColor alloc] init];
    [solidColor1 setColorRed:109.0f/255.0f green:131.0f/255.0f blue:249.0f/255.0 alpha:1.0f];
    solidColor1.topLayerOpacity = 0.65f;
    solidColor1.blendingMode = VnBlendingModeSoftLight;
    
    
    // Fill Layer
    VnFilterSolidColor* solidColor2 = [[VnFilterSolidColor alloc] init];
    [solidColor2 setColorRed:215.0f/255.0f green:225.0f/255.0f blue:203.0f/255.0 alpha:1.0f];
    solidColor2.topLayerOpacity = 0.06f;
    solidColor2.blendingMode = VnBlendingModeHue;
    
    
    
    // Color Balance
    VnAdjustmentLayerColorBalance* colorBalance1 = [[VnAdjustmentLayerColorBalance alloc] init];
    GPUVector3 shadows1;
    shadows1.one = s255(0.0f);
    shadows1.two = s255(0.0f);
    shadows1.three = s255(0.0f);
    [colorBalance1 setShadows:shadows1];
    GPUVector3 midtones1;
    midtones1.one = s255(5.0f);
    midtones1.two = s255(-27.0f);
    midtones1.three = s255(-24.0f);
    [colorBalance1 setMidtones:midtones1];
    GPUVector3 highlights1;
    highlights1.one = s255(9.0f);
    highlights1.two = s255(7.0f);
    highlights1.three = s255(-11.0f);
    [colorBalance1 setHighlights:highlights1];
    colorBalance1.preserveLuminosity = YES;

    // Fill Layer
    VnFilterSolidColor* solidColor3 = [[VnFilterSolidColor alloc] init];
    [solidColor3 setColorRed:143.0f/255.0f green:139.0f/255.0f blue:69.0f/255.0 alpha:1.0f];
    solidColor3.topLayerOpacity = 0.64f;
    solidColor3.blendingMode = VnBlendingModeSoftLight;
    
    
    // Fill Layer
    VnFilterSolidColor* solidColor4 = [[VnFilterSolidColor alloc] init];
    [solidColor4 setColorRed:155.0f/255.0f green:156.0f/255.0f blue:113.0f/255.0 alpha:1.0f];
    solidColor4.topLayerOpacity = 0.20f;
    solidColor4.blendingMode = VnBlendingModeOverlay;
    
    
    // Curve
    VnFilterToneCurve* curveFilter = [[VnFilterToneCurve alloc] initWithACV:@"frpp"];
    
    self.startFilter = solidColor1;
    [solidColor1 addTarget:solidColor2];
    [solidColor2 addTarget:colorBalance1];
    [colorBalance1 addTarget:solidColor3];
    [solidColor3 addTarget:solidColor4];
    [solidColor4 addTarget:curveFilter];
    self.endFilter = curveFilter;
    
}

@end
