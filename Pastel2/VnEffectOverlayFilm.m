//
//  VnEffectOverlayFilm.m
//  Pastel2
//
//  Created by SSC on 2014/06/17.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectOverlayFilm.h"

@implementation VnEffectOverlayFilm

- (id)init
{
    self = [super init];
    if(self){
        self.defaultOpacity = 0.70f;
        self.effectId = VnEffectIdOverlayFilm;
    }
    return self;
}

- (void)makeFilterGroup
{
    // Fill Layer
    VnFilterSolidColor* solidColor = [[VnFilterSolidColor alloc] init];
    [solidColor setColorRed:s255(78.0f) green:s255(78.0f) blue:s255(78.0f) alpha:1.0f];
    solidColor.blendingMode = VnBlendingModeLighten;
    
    self.startFilter = self.endFilter = solidColor;
}

@end
