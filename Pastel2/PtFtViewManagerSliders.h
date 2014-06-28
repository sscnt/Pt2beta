//
//  PtFtViewManagerSliders.h
//  Pastel2
//
//  Created by SSC on 2014/06/01.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PtFtViewSliderWrapper.h"

@class PtViewControllerFilters;

@interface PtFtViewManagerSliders : NSObject

@property (nonatomic, weak) UIView* view;
@property (nonatomic, weak) PtViewControllerFilters* delegate;
@property (nonatomic, strong) PtFtViewSliderWrapper* sliderWrapper;

@property (nonatomic, assign) float overlayOpacity;
@property (nonatomic, assign) float colorOpacity;
@property (nonatomic, assign) float artisticOpacity;

- (void)viewDidLoad;
- (void)toggleSliders;

- (void)showCurrentSelectedOverlayFilter:(VnEffectId)filterId;
- (void)showCurrentSelectedArtisticFilter:(VnEffectId)filterId;
- (void)showCurrentSelectedColorFilter:(VnEffectId)filterId;

@end
