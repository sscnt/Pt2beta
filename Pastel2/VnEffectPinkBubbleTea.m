//
//  GPUEffectPinkBubbleTea.m
//  Gravy_1.0
//
//  Created by SSC on 2013/12/15.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "VnEffectPinkBubbleTea.h"

@implementation VnEffectPinkBubbleTea

- (id)init
{
    self = [super init];
    if(self){
        self.defaultOpacity = 0.80f;
        self.faceOpacity = 0.65f;
        self.effectId = VnEffectIdPinkBubbleTea;
    }
    return self;
}

- (void)makeFilterGroup
{
    // Fill Layer
    VnFilterSolidColor* solidColor1 = [[VnFilterSolidColor alloc] init];
    [solidColor1 setColorRed:177.0f/255.0f green:81.0f/255.0f blue:161.0f/255.0 alpha:1.0f];
    solidColor1.topLayerOpacity = 0.25;
    solidColor1.blendingMode = VnBlendingModeLighten;
    
    // Curve
    VnFilterToneCurve* curveFilter = [[VnFilterToneCurve alloc] initWithACV:@"bo001"];
    
    // Fill Layer
    VnFilterSolidColor* solidColor2 = [[VnFilterSolidColor alloc] init];
    [solidColor2 setColorRed:251.0f/255.0f green:223.0f/255.0f blue:109.0f/255.0 alpha:1.0f];
    solidColor2.topLayerOpacity = 0.32f;
    solidColor2.blendingMode = VnBlendingModeMultiply;
    
    self.startFilter = solidColor1;
    [solidColor1 addTarget:curveFilter];
    [curveFilter addTarget:solidColor2];
    self.endFilter = solidColor2;
    
}

@end
