//
//  VnEffectColorRosyVintage.m
//  Pastel
//
//  Created by SSC on 2014/05/03.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectColorRosyVintage.h"

@implementation VnEffectColorRosyVintage

- (id)init
{
    self = [super init];
    if(self){
        self.defaultOpacity = 0.65f;
        self.faceOpacity = 0.65f;
        self.effectId = VnEffectIdColorRosyVintage;
    }
    return self;
}

- (void)makeFilterGroup
{
    
    // Fill Layer
    VnFilterSolidColor* solidColor = [[VnFilterSolidColor alloc] init];
    [solidColor setColorRed:s255(2.0f) green:s255(132.0f) blue:s255(152.0f) alpha:1.0f];
    solidColor.blendingMode = VnBlendingModeExclusion;
    solidColor.topLayerOpacity = 0.15f;
    
    // Levels
    VnFilterLevels* levelsFilter = [[VnFilterLevels alloc] init];
    [levelsFilter setMin:s255(2.0f) gamma:1.00f max:s255(252.0f) minOut:s255(23.0f) maxOut:1.0f];
    [levelsFilter setRedMin:s255(0.0f) gamma:1.08f max:s255(255.0f) minOut:s255(9.0f) maxOut:s255(255.0f)];
    levelsFilter.blendingMode = VnBlendingModeScreen;
    levelsFilter.topLayerOpacity = 0.23f;
    
    // Color Balance
    VnAdjustmentLayerColorBalance* colorBalance = [[VnAdjustmentLayerColorBalance alloc] init];
    GPUVector3 shadows;
    shadows.one = s255(0.0f);
    shadows.two = s255(0.0f);
    shadows.three = s255(0.0f);
    [colorBalance setShadows:shadows];
    GPUVector3 midtones;
    midtones.one = s255(11.0f);
    midtones.two = s255(0.0f);
    midtones.three = s255(0.0f);
    [colorBalance setMidtones:midtones];
    GPUVector3 highlights;
    highlights.one = s255(13.0f);
    highlights.two = s255(-3.0f);
    highlights.three = s255(-1.0f);
    [colorBalance setHighlights:highlights];
    colorBalance.preserveLuminosity = YES;
    colorBalance.topLayerOpacity = 0.40f;
    
    // Gradient Map
    VnAdjustmentLayerGradientMap* gradientMap = [[VnAdjustmentLayerGradientMap alloc] init];
    [gradientMap addColorRed:5.0f Green:5.0f Blue:27.0f Opacity:100.0f Location:0 Midpoint:50];
    [gradientMap addColorRed:255.0f Green:253.0f Blue:253.0f Opacity:100.0f Location:4096 Midpoint:50];
    gradientMap.topLayerOpacity = 0.02f;
    
    self.startFilter = solidColor;
    [solidColor addTarget:levelsFilter];
    [levelsFilter addTarget:colorBalance];
    [colorBalance addTarget:gradientMap];
    self.endFilter = gradientMap;
}

@end
