//
//  VnEffectOverlayPureMilk.m
//  Pastel2
//
//  Created by SSC on 2014/06/18.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectOverlayPureMilk.h"

@implementation VnEffectOverlayPureMilk

- (id)init
{
    self = [super init];
    if(self){
        self.defaultOpacity = 0.50f;
        self.effectId = VnEffectIdOverlayPureMilk;
    }
    return self;
}

- (void)makeFilterGroup
{
    
    // Fill Layer
    VnFilterSolidColor* solidColor1 = [[VnFilterSolidColor alloc] init];
    [solidColor1 setColorRed:245.0f/255.0f green:237.0f/255.0f blue:234.0f/255.0 alpha:1.0f];
    solidColor1.blendingMode = VnBlendingModeScreen;
    solidColor1.topLayerOpacity = 0.50f;
    
    self.startFilter = self.endFilter = solidColor1;
}

@end
