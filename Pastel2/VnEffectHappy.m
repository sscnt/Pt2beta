//
//  VnEffectHappy.m
//  Pastel2
//
//  Created by SSC on 2014/06/11.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectHappy.h"

@implementation VnEffectHappy

- (id)init
{
    self = [super init];
    if(self){
        self.defaultOpacity = 1.0f;
        self.effectId = VnEffectIdHappy;
    }
    return self;
}

- (void)makeFilterGroup
{
    // Fill Layer
    VnFilterSolidColor* solidColor1 = [[VnFilterSolidColor alloc] init];
    [solidColor1 setColorRed:192.0f/255.0f green:192.0f/255.0f blue:192.0f/255.0 alpha:1.0f];
    solidColor1.topLayerOpacity = 0.82f;
    solidColor1.blendingMode = VnBlendingModeOverlay;
    
    // Fill Layer
    VnFilterSolidColor* solidColor2 = [[VnFilterSolidColor alloc] init];
    [solidColor2 setColorRed:106.0f/255.0f green:0.0f/255.0f blue:187.0f/255.0 alpha:1.0f];
    solidColor2.topLayerOpacity = 0.13f;
    solidColor2.blendingMode = VnBlendingModeExclusion;
    
    // Fill Layer
    VnFilterSolidColor* solidColor3 = [[VnFilterSolidColor alloc] init];
    [solidColor3 setColorRed:0.0f/255.0f green:144.0f/255.0f blue:255.0f/255.0 alpha:1.0f];
    solidColor3.topLayerOpacity = 0.19f;
    solidColor3.blendingMode = VnBlendingModeExclusion;
    
    // Curve
    VnFilterToneCurve* curveFilter = [[VnFilterToneCurve alloc] initWithACV:@"hp1"];
    
    // Fill Layer
    VnFilterSolidColor* solidColor4 = [[VnFilterSolidColor alloc] init];
    [solidColor4 setColorRed:255.0f/255.0f green:196.0f/255.0f blue:127.0f/255.0 alpha:1.0f];
    solidColor4.topLayerOpacity = 0.27f;
    solidColor4.blendingMode = VnBlendingModeOverlay;
    
    self.startFilter = solidColor1;
    [solidColor1 addTarget:solidColor2];
    [solidColor2 addTarget:solidColor3];
    [solidColor3 addTarget:curveFilter];
    [curveFilter addTarget:solidColor4];
    self.endFilter = solidColor4;
}

@end
