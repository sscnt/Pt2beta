//
//  PtFtViewManagerFilters.h
//  Pastel2
//
//  Created by SSC on 2014/06/01.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PtFtViewBarWrapper.h"
#import "PtFtViewLayerBar.h"

@class PtViewControllerFilters;

@interface PtFtViewManagerFilters : NSObject <PtFtButtonLayerBarDelegate>

@property (nonatomic, weak) UIView* view;
@property (nonatomic, weak) PtViewControllerFilters* delegate;
@property (nonatomic, strong) PtFtViewBarWrapper* barWrapper;
@property (nonatomic, strong) PtFtViewLayerBar* overlayBar;
@property (nonatomic, strong) PtFtViewLayerBar* artisticBar;
@property (nonatomic, strong) PtFtViewLayerBar* colorBar;

@property (nonatomic, strong) NSMutableDictionary* overlayButtonsDictionary;
@property (nonatomic, strong) NSMutableDictionary* artisticButtonsDictionary;
@property (nonatomic, strong) NSMutableDictionary* colorButtonsDictionary;

@property (nonatomic, weak) PtFtButtonLayerBar* currentColorButton;
@property (nonatomic, weak) PtFtButtonLayerBar* currentArtisticButton;
@property (nonatomic, weak) PtFtButtonLayerBar* currentOverlayButton;

- (void)viewDidLoad;
- (void)layoutButtons;
- (void)layoutOverlayButtons;
- (void)layoutColorButtons;
- (void)layoutArtisticButtons;

- (void)setPresetImage:(UIImage*)image ToEffect:(VnEffectId)effectId;
- (PtFtButtonLayerBar*)buttonByEffectId:(VnEffectId)effectId;
- (void)selectLayerButtonWithButton:(PtFtButtonLayerBar*)button;
- (void)selectLayerButtonWithEffectId:(VnEffectId)effectId;

- (void)didLayerBarButtonTouchUpInside:(PtFtButtonLayerBar*)button;
- (void)deallocArtisticButtonImages;

@end
