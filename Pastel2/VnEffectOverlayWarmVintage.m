//
//  VnEffectOverlayWarmVintage.m
//  Pastel
//
//  Created by SSC on 2014/05/06.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectOverlayWarmVintage.h"

@implementation VnEffectOverlayWarmVintage

- (id)init
{
    self = [super init];
    if(self){
        self.effectId = VnEffectIdOverlayWarmVintage;
    }
    return self;
}

- (void)makeFilterGroup
{
    
    // Fill Layer
    VnFilterSolidColor* solidColor = [[VnFilterSolidColor alloc] init];
    [solidColor setColorRed:s255(4.0f) green:s255(46.0f) blue:s255(132.0f) alpha:1.0f];
    solidColor.topLayerOpacity = 0.35f;
    solidColor.blendingMode = VnBlendingModeExclusion;
    
    // Levels
    GPUImageNormalBlendFilter* normalFilter = [[GPUImageNormalBlendFilter alloc] init];
    
    VnFilterLevels* levelsFilter1 = [[VnFilterLevels alloc] init];
    [levelsFilter1 setMin:s255(0.0f) gamma:1.00f max:s255(255.0f) minOut:s255(0.0f) maxOut:s255(255.0f)];
    [levelsFilter1 setBlueMin:0.0f gamma:1.08f max:s255(255.0f) minOut:s255(9.0f) maxOut:s255(255.0f)];
    
    VnFilterLevels* levelsFilter2 = [[VnFilterLevels alloc] init];
    [levelsFilter2 setMin:s255(2.0f) gamma:1.00f max:s255(252.0f) minOut:s255(23.0f) maxOut:s255(255.0f)];
    
    GPUImageOpacityFilter* opacityFilter = [[GPUImageOpacityFilter alloc] init];
    opacityFilter.opacity = 0.18f;
    
    // Color Balance
    VnAdjustmentLayerColorBalance* colorBalance = [[VnAdjustmentLayerColorBalance alloc] init];
    GPUVector3 shadows;
    shadows.one = s255(0.0f);
    shadows.two = s255(0.0f);
    shadows.three = s255(0.0f);
    [colorBalance setShadows:shadows];
    GPUVector3 midtones;
    midtones.one = s255(0.0f);
    midtones.two = s255(0.0f);
    midtones.three = s255(-8.0f);
    [colorBalance setMidtones:midtones];
    GPUVector3 highlights;
    highlights.one = s255(4.0f);
    highlights.two = s255(0.0f);
    highlights.three = s255(-16.0f);
    [colorBalance setHighlights:highlights];
    colorBalance.preserveLuminosity = YES;
    colorBalance.topLayerOpacity = 0.35f;
    
    self.startFilter = solidColor;
    [solidColor addTarget:normalFilter];
    [solidColor addTarget:levelsFilter1];
    [levelsFilter1 addTarget:levelsFilter2];
    [levelsFilter2 addTarget:normalFilter];
    [normalFilter addTarget:colorBalance];
    self.endFilter = colorBalance;
}

@end
