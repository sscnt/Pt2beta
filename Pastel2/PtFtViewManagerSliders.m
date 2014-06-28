//
//  PtFtViewManagerSliders.m
//  Pastel2
//
//  Created by SSC on 2014/06/01.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "PtFtViewManagerSliders.h"
#import "PtViewControllerFilters.h"

@implementation PtFtViewManagerSliders

- (void)viewDidLoad
{
    //// Wrapper
    _sliderWrapper = [[PtFtViewSliderWrapper alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.width, [PtFtConfig overlayBarHeight] + [PtFtConfig artisticBarHeight] + [PtFtConfig colorBarHeight])];
    [_sliderWrapper setY:self.view.height - _sliderWrapper.height - [PtSharedApp bottomNavigationBarHeight]];
    _sliderWrapper.hidden = YES;
    [self.view addSubview:_sliderWrapper];
    
    //// Slider
    _colorSlider = [[PtAdViewSliderBar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.width - [PtFtConfig artisticLayerButtonSize].width - 10.0f, [PtFtConfig colorBarHeight] * 1.7)];
    _colorSlider.backgroundColor = [UIColor clearColor];
    _colorSlider.slider.zeroPointAtCenter = NO;
    _colorSlider.slider.value = 0.0f;
    _colorSlider.delegate = self;
    _colorSlider.slider.thumbBgColor = [PtFtConfig colorBarBgColor];
    _colorSlider.tag = 1;
    [_sliderWrapper addColorSliderBar:_colorSlider];
    
    _artisticSlider = [[PtAdViewSliderBar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.width - [PtFtConfig artisticLayerButtonSize].width - 10.0f, [PtFtConfig colorBarHeight] * 1.7)];
    _artisticSlider.backgroundColor = [UIColor clearColor];
    _artisticSlider.slider.zeroPointAtCenter = NO;
    _artisticSlider.slider.value = 0.0f;
    _artisticSlider.delegate = self;
    _artisticSlider.slider.thumbBgColor = [PtFtConfig artisticBarBgColor];
    _artisticSlider.tag = 1;
    [_sliderWrapper addArtisticSliderBar:_artisticSlider];
    
    _overlaySlider = [[PtAdViewSliderBar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.width - [PtFtConfig artisticLayerButtonSize].width - 10.0f, [PtFtConfig colorBarHeight] * 1.7)];
    _overlaySlider.backgroundColor = [UIColor clearColor];
    _overlaySlider.slider.zeroPointAtCenter = NO;
    _overlaySlider.slider.value = 0.0f;
    _overlaySlider.delegate = self;
    _overlaySlider.slider.thumbBgColor = [PtFtConfig overlayBarBgColor];
    _overlaySlider.tag = 1;
    [_sliderWrapper addOverlaySliderBar:_overlaySlider];
}

- (void)toggleSliders
{
    PtFtViewManagerFilters* fm = self.delegate.filtersManager;
    [_sliderWrapper removeAllButtons];
    if (_sliderWrapper.hidden) {
        if (fm.currentColorButton) {
            [self showCurrentSelectedColorFilter:fm.currentColorButton.effectId];
        }
        if (fm.currentArtisticButton) {
            [self showCurrentSelectedArtisticFilter:fm.currentArtisticButton.effectId];
        }
        if (fm.currentOverlayButton) {
            [self showCurrentSelectedOverlayFilter:fm.currentOverlayButton.effectId];
        }
    }else{
        
    }
    _sliderWrapper.hidden = !_sliderWrapper.hidden;
}

- (void)showCurrentSelectedColorFilter:(VnEffectId)filterId
{
    if (filterId == VnEffectIdColorNone) {
        _sliderWrapper.colorHidden = YES;
        return;
    }
    _sliderWrapper.colorHidden = NO;
    PtFtObjectFilterItem* item;
    CGSize size = [PtFtConfig colorLayerButtonSize];
    
    NSMutableArray* items = [PtFtSharedFilterManager instance].colorFilters;
    for (int i = 0; i < items.count; i++) {
        item = (PtFtObjectFilterItem*)[items objectAtIndex:i];
        if (item && item.effectId == filterId) {
            PtFtViewLayerBarButton* button = [[PtFtViewLayerBarButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, size.width, size.height)];
            button.maskColor = [PtFtConfig colorBarBgColor];
            button.previewColor = item.previewColor;
            button.title = item.name;
            button.maskRadius = [PtFtConfig colorLayerButtonMaskRadius];
            button.titleColor = [UIColor whiteColor];
            button.selectionColor = item.selectionColor;
            button.group = item.effectGroup;
            button.effectId = item.effectId;
            button.userInteractionEnabled = NO;
            [_sliderWrapper addColorFilterButton:button];
            break;
        }
    }
}

- (void)showCurrentSelectedArtisticFilter:(VnEffectId)filterId
{
    if (filterId == VnEffectIdNone) {
        _sliderWrapper.artisticHidden = YES;
        return;
    }
    _sliderWrapper.artisticHidden = NO;
    PtFtObjectFilterItem* item;
    CGSize size = [PtFtConfig artisticLayerButtonSize];
    
    NSMutableArray* items = [PtFtSharedFilterManager instance].artisticFilters;
    for (int i = 0; i < items.count; i++) {
        item = (PtFtObjectFilterItem*)[items objectAtIndex:i];
        if (item && item.effectId == filterId) {
            PtFtViewLayerBarButton* button = [[PtFtViewLayerBarButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, size.width, size.height)];
            button.maskColor = [PtFtConfig artisticBarBgColor];
            button.previewColor = [PtFtConfig artisticBarBgColor];
            button.title = item.name;
            button.maskRadius = [PtFtConfig artisticLayerButtonMaskRadius];
            button.titleColor = [UIColor whiteColor];
            button.selectionColor = [UIColor whiteColor];
            button.group = item.effectGroup;
            button.effectId = item.effectId;
            button.previewImage = [UIImage imageWithCGImage:[self.delegate.filtersManager buttonByEffectId:filterId].previewImage.CGImage];
            button.userInteractionEnabled = NO;
            [_sliderWrapper addArtisticFilterButton:button];
            break;
        }
    }
}

- (void)showCurrentSelectedOverlayFilter:(VnEffectId)filterId
{
    if (filterId == VnEffectIdOverlayNone) {
        _sliderWrapper.overlayHidden = YES;
        return;
    }
    _sliderWrapper.overlayHidden = NO;
    PtFtObjectFilterItem* item;
    CGSize size = [PtFtConfig colorLayerButtonSize];
    
    NSMutableArray* items = [PtFtSharedFilterManager instance].overlayFilters;
    for (int i = 0; i < items.count; i++) {
        item = (PtFtObjectFilterItem*)[items objectAtIndex:i];
        if (item && item.effectId == filterId) {
            PtFtViewLayerBarButton* button = [[PtFtViewLayerBarButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, size.width, size.height)];
            button.maskColor = [PtFtConfig overlayBarBgColor];
            button.previewColor = item.previewColor;
            button.title = item.name;
            button.maskRadius = [PtFtConfig colorLayerButtonMaskRadius];
            button.titleColor = [UIColor whiteColor];
            button.selectionColor = item.selectionColor;
            button.group = item.effectGroup;
            button.effectId = item.effectId;
            button.userInteractionEnabled = NO;
            [_sliderWrapper addOverlayFilterButton:button];
            break;
        }
    }
}

#pragma mark delegate

- (void)sliderDidValueChange:(CGFloat)value
{
    _sliderWrapper.colorOpacity = _colorSlider.value;
    _sliderWrapper.artisticOpacity = _artisticSlider.value;
    _sliderWrapper.overlayOpacity = _overlaySlider.value;
}

- (void)sliderDidTouchUpInside
{
    
}

@end
