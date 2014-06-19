//
//  VnEffectBlackWhiteFilm.m
//  Pastel2
//
//  Created by SSC on 2014/06/19.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectBlackWhiteFilm.h"

@implementation VnEffectBlackWhiteFilm

- (id)init
{
    self = [super init];
    if(self){
        self.effectId = VnEffectIdTimeless;
    }
    return self;
}

- (void)makeFilterGroup
{
    // Lighten
    VnFilterDuplicate* lightenFilter = [[VnFilterDuplicate alloc] init];
    lightenFilter.blendingMode = VnBlendingModeScreen;
    lightenFilter.topLayerOpacity = 0.50f;
    
    // Gradient Map
    VnAdjustmentLayerGradientMap* gradientMap1 = [[VnAdjustmentLayerGradientMap alloc] init];
    [gradientMap1 addColorRed:46.0f Green:44.0f Blue:40.0f Opacity:100.0f Location:0 Midpoint:50];
    [gradientMap1 addColorRed:227.0f Green:227.0f Blue:226.0f Opacity:100.0f Location:4096 Midpoint:50];
    
    // Levels
    VnFilterLevels* levelsFilter1 = [[VnFilterLevels alloc] init];
    [levelsFilter1 setMin:s255(47.0f) gamma:1.10f max:s255(209.0f)];
    levelsFilter1.topLayerOpacity = 0.60f;
    
    // Levels
    VnFilterLevels* levelsFilter2 = [[VnFilterLevels alloc] init];
    [levelsFilter2 setRedMin:0.0f gamma:1.00f max:1.0f minOut:s255(15.0f) maxOut:1.0f];
    [levelsFilter2 setGreenMin:0.0f gamma:1.0f max:1.0f minOut:0.0f maxOut:s255(249.0)];
    [levelsFilter2 setBlueMin:0.0f gamma:1.0f max:1.0f minOut:0.0f maxOut:s255(220.0f)];
    
    // Channel Mixer
    VnAdjustmentLayerChannelMixerFilter* mixerFilter1 = [[VnAdjustmentLayerChannelMixerFilter alloc] init];
    mixerFilter1.monochrome = YES;
    [mixerFilter1 setGreyChannelRed:40 Green:40 Blue:20 Constant:0];
    
    self.startFilter = lightenFilter;
    [lightenFilter addTarget:gradientMap1];
    [gradientMap1 addTarget:levelsFilter1];
    [levelsFilter1 addTarget:levelsFilter2];
    [levelsFilter2 addTarget:mixerFilter1];
    self.endFilter = mixerFilter1;

}

@end
