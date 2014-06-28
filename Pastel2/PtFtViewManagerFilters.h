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
#import "PtFtViewToolBar.h"
#import "PtFtViewToolBarButton.h"

@class PtViewControllerFilters;

@interface PtFtViewManagerFilters : NSObject <PtFtViewLayerBarButtonDelegate>

@property (nonatomic, weak) UIView* view;
@property (nonatomic, weak) PtViewControllerFilters* delegate;
@property (nonatomic, strong) PtFtViewBarWrapper* barWrapper;
@property (nonatomic, strong) PtFtViewLayerBar* overlayBar;
@property (nonatomic, strong) PtFtViewLayerBar* artisticBar;
@property (nonatomic, strong) PtFtViewLayerBar* colorBar;
@property (nonatomic, strong) PtFtViewToolBar* toolBar;
@property (nonatomic, strong) PtFtViewToolBarButton* shuffleButton;
@property (nonatomic, strong) PtFtViewToolBarButton* sliderButton;

@property (nonatomic, strong) NSMutableDictionary* overlayButtonsDictionary;
@property (nonatomic, strong) NSMutableDictionary* artisticButtonsDictionary;
@property (nonatomic, strong) NSMutableDictionary* colorButtonsDictionary;

@property (nonatomic, weak) PtFtViewLayerBarButton* currentColorButton;
@property (nonatomic, weak) PtFtViewLayerBarButton* currentArtisticButton;
@property (nonatomic, weak) PtFtViewLayerBarButton* currentOverlayButton;

- (void)viewDidLoad;
- (void)layoutButtons;
- (void)layoutOverlayButtons;
- (void)layoutColorButtons;
- (void)layoutArtisticButtons;
- (void)layoutToolButtons;

- (void)setPresetImage:(UIImage*)image ToEffect:(VnEffectId)effectId;
- (PtFtViewLayerBarButton*)buttonByEffectId:(VnEffectId)effectId;
- (void)selectLayerButtonWithButton:(PtFtViewLayerBarButton*)button;
- (void)selectLayerButtonWithEffectId:(VnEffectId)effectId;

- (void)sliderButtonDidTouchUpInside:(PtFtViewToolBarButton*)button;
- (void)shuffleButtonDidTouchUpInside:(PtFtViewToolBarButton*)button;

- (void)didLayerBarButtonTouchUpInside:(PtFtViewLayerBarButton*)button;
- (void)deallocArtisticButtonImages;

@end
