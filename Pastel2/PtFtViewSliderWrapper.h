//
//  PtFtViewSliderWrapper.h
//  Pastel2
//
//  Created by SSC on 2014/06/28.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PtFtViewLayerBarButton.h"
#import "PtAdViewSliderBar.h"
#import "VnViewLabel.h"

@interface PtFtViewSliderWrapper : UIView
{
    VnViewLabel* _colorLabel;
    VnViewLabel* _artisticLabel;
    VnViewLabel* _overlayLabel;
}

@property (nonatomic, assign) float colorOpacity;
@property (nonatomic, assign) float artisticOpacity;
@property (nonatomic, assign) float overlayOpacity;
@property (nonatomic, assign) BOOL colorHidden;
@property (nonatomic, assign) BOOL artisticHidden;
@property (nonatomic, assign) BOOL overlayHidden;
@property (nonatomic, strong) PtFtViewLayerBarButton* colorButton;
@property (nonatomic, strong) PtFtViewLayerBarButton* artisticButton;
@property (nonatomic, strong) PtFtViewLayerBarButton* overlayButton;
@property (nonatomic, weak) PtAdViewSliderBar* colorSlider;
@property (nonatomic, weak) PtAdViewSliderBar* artisticSlider;
@property (nonatomic, weak) PtAdViewSliderBar* overlaySlider;

- (void)removeAllButtons;
- (void)addColorFilterButton:(PtFtViewLayerBarButton*)button;
- (void)addArtisticFilterButton:(PtFtViewLayerBarButton*)button;
- (void)addOverlayFilterButton:(PtFtViewLayerBarButton*)button;
- (void)addColorSliderBar:(PtAdViewSliderBar*)slider;
- (void)addArtisticSliderBar:(PtAdViewSliderBar*)slider;
- (void)addOverlaySliderBar:(PtAdViewSliderBar*)slider;

@end
