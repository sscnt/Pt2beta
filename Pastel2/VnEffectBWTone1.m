//
//  VnEffectBWTone1.m
//  Pastel2
//
//  Created by SSC on 2014/06/14.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectBWTone1.h"

@implementation VnEffectBWTone1

- (id)init
{
    self = [super init];
    if(self){
        self.effectId = VnEffectIdBWTone1;
    }
    return self;
}

- (void)makeFilterGroup
{
    
    // Color Balance
    VnAdjustmentLayerColorBalance* colorBalance1 = [[VnAdjustmentLayerColorBalance alloc] init];
    GPUVector3 shadows1;
    shadows1.one = s255(-53);
    shadows1.two = s255(46);
    shadows1.three = s255(40);
    [colorBalance1 setShadows:shadows1];
    GPUVector3 midtones1;
    midtones1.one = s255(47);
    midtones1.two = s255(17);
    midtones1.three = s255(0);
    [colorBalance1 setMidtones:midtones1];
    GPUVector3 highlights1;
    highlights1.one = s255(29);
    highlights1.two = s255(-40);
    highlights1.three = s255(-62);
    [colorBalance1 setHighlights:highlights1];
    colorBalance1.preserveLuminosity = YES;
    
    // Hue / Saturation
    VnAdjustmentLayerHueSaturation* hueSaturation = [[VnAdjustmentLayerHueSaturation alloc] init];
    hueSaturation.hue = 0.0f;
    hueSaturation.saturation = -100.0f;
    hueSaturation.lightness = 0.0f;
    hueSaturation.colorize = NO;
    
    // Merge
    VnFilterPassThrough* blendInput = [[VnFilterPassThrough alloc] init];
    VnImageNormalBlendFilter* blendFilter = [[VnImageNormalBlendFilter alloc] init];
    blendFilter.topLayerOpacity = 0.60f;
    
    // Fill Layer
    VnFilterSolidColor* solidColor1 = [[VnFilterSolidColor alloc] init];
    [solidColor1 setColorRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0 alpha:1.0f];
    solidColor1.blendingMode = VnBlendingModeColor;
    
    self.startFilter = colorBalance1;
    [colorBalance1 addTarget:blendInput];
    [blendInput addTarget:hueSaturation];
    [hueSaturation addTarget:blendFilter];
    [blendInput addTarget:blendFilter atTextureLocation:1];
    [blendFilter addTarget:solidColor1];
    self.endFilter = solidColor1		;
}

@end
