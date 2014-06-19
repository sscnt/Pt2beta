//
//  VnEffectCaramel.m
//  Pastel2
//
//  Created by SSC on 2014/06/19.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectCaramel.h"

@implementation VnEffectCaramel

- (id)init
{
    self = [super init];
    if(self){
        self.effectId = VnEffectIdCaramel;
    }
    return self;
    
}

- (void)makeFilterGroup
{
    
    // Levels
    VnFilterLevels* levelsFilter1 = [[VnFilterLevels alloc] init];
    [levelsFilter1 setMin:s255(0.0f) gamma:1.10f max:s255(245.0f)];
    
    // Curve
    VnFilterToneCurve* curveFilter1 = [[VnFilterToneCurve alloc] initWithACV:@"cp001"];
    
    // Hue / Saturation
    VnAdjustmentLayerHueSaturation* hueSaturation = [[VnAdjustmentLayerHueSaturation alloc] init];
    hueSaturation.hue = 0.0f;
    hueSaturation.saturation = -20;
    hueSaturation.lightness = 0.0f;
    hueSaturation.colorize = NO;
    
    // Curve
    VnFilterToneCurve* curveFilter2 = [[VnFilterToneCurve alloc] initWithACV:@"cp002"];
    
    // Color Balance
    VnAdjustmentLayerColorBalance* colorBalance = [[VnAdjustmentLayerColorBalance alloc] init];
    GPUVector3 shadows;
    shadows.one = s255(0.0f);
    shadows.two = s255(0.0f);
    shadows.three = s255(0.0f);
    [colorBalance setShadows:shadows];
    GPUVector3 midtones;
    midtones.one = s255(-9.0f);
    midtones.two = s255(0.0f);
    midtones.three = s255(30.0f);
    [colorBalance setMidtones:midtones];
    GPUVector3 highlights;
    highlights.one = s255(0.0f);
    highlights.two = s255(0.0f);
    highlights.three = s255(0.0f);
    [colorBalance setHighlights:highlights];
    colorBalance.preserveLuminosity = YES;
    
    // Curve
    VnFilterToneCurve* curveFilter3 = [[VnFilterToneCurve alloc] initWithACV:@"cp003"];
    
    // Color Balance
    VnAdjustmentLayerColorBalance* colorBalance2 = [[VnAdjustmentLayerColorBalance alloc] init];
    GPUVector3 shadows2;
    shadows2.one = s255(0.0f);
    shadows2.two = s255(0.0f);
    shadows2.three = s255(0.0f);
    [colorBalance2 setShadows:shadows2];
    GPUVector3 midtones2;
    midtones2.one = s255(42.0f);
    midtones2.two = s255(0.0f);
    midtones2.three = s255(-73.0f);
    [colorBalance2 setMidtones:midtones2];
    GPUVector3 highlights2;
    highlights2.one = s255(0.0f);
    highlights2.two = s255(0.0f);
    highlights2.three = s255(0.0f);
    [colorBalance2 setHighlights:highlights2];
    colorBalance2.preserveLuminosity = YES;
    
    // Photo Filter
    VnAdjustmentLayerPhotoFilter* photoFilter1 = [[VnAdjustmentLayerPhotoFilter alloc] init];
    photoFilter1.color = (GPUVector3){s255(236.0f), s255(138.0f), 0.0f};
    photoFilter1.density = 0.05f;
    photoFilter1.preserveLuminosity = YES;
    
    // Fill Layer
    VnFilterSolidColor* solidColor1 = [[VnFilterSolidColor alloc] init];
    [solidColor1 setColorRed:51.0f/255.0f green:85.0f/255.0f blue:105.0f/255.0 alpha:1.0f];
    solidColor1.blendingMode = VnBlendingModeExclusion;
    solidColor1.topLayerOpacity = 0.60f;
        
    self.startFilter = levelsFilter1;
    [levelsFilter1 addTarget:curveFilter1];
    [curveFilter1 addTarget:hueSaturation];
    [hueSaturation addTarget:curveFilter2];
    [curveFilter2 addTarget:colorBalance];
    [colorBalance addTarget:curveFilter3];
    [curveFilter3 addTarget:colorBalance2];
    [colorBalance2 addTarget:solidColor1];
    self.endFilter = solidColor1;
    
}
@end
