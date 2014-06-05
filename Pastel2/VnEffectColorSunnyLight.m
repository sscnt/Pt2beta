//
//  VnEffectColorSunnyLight.m
//  Pastel
//
//  Created by SSC on 2014/05/03.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectColorSunnyLight.h"

@implementation VnEffectColorSunnyLight

- (id)init
{
    self = [super init];
    if(self){
        self.effectId = VnEffectIdColorSunnyLight;
        self.faceOpacity = 0.50f;
        self.defaultOpacity = 0.50f;
    }
    return self;
}

- (void)makeFilterGroup
{
    // Color Balance
    VnAdjustmentLayerColorBalance* colorBalance = [[VnAdjustmentLayerColorBalance alloc] init];
    GPUVector3 shadows;
    shadows.one = s255(0.0f);
    shadows.two = s255(0.0f);
    shadows.three = s255(0.0f);
    [colorBalance setShadows:shadows];
    GPUVector3 midtones;
    midtones.one = s255(5.0f);
    midtones.two = s255(0.0f);
    midtones.three = s255(-9.0f);
    [colorBalance setMidtones:midtones];
    GPUVector3 highlights;
    highlights.one = s255(10.0f);
    highlights.two = s255(0.0f);
    highlights.three = s255(-18.0f);
    [colorBalance setHighlights:highlights];
    colorBalance.preserveLuminosity = YES;
    
    self.startFilter = colorBalance;
    self.endFilter = colorBalance;

}

@end
