//
//  PtFtViewManagerFilters.m
//  Pastel2
//
//  Created by SSC on 2014/06/01.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "PtFtViewManagerFilters.h"
#import "PtViewControllerFilters.h"

@implementation PtFtViewManagerFilters

- (void)viewDidLoad
{
    
    //// Wrapper
    _barWrapper = [[PtFtViewBarWrapper alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.width, [PtFtConfig overlayBarHeight] + [PtFtConfig artisticBarHeight] + [PtFtConfig colorBarHeight])];
    [_barWrapper setY:self.view.height - _barWrapper.height - [PtSharedApp bottomNavigationBarHeight]];
    [self.view addSubview:_barWrapper];
    
    /// Bar
    _overlayBar = [[PtFtViewLayerBar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.width, [PtFtConfig overlayBarHeight])];
    _overlayBar.backgroundColor = [PtFtConfig overlayBarBgColor];
    [_barWrapper addOverlayBar:_overlayBar];
    _artisticBar = [[PtFtViewLayerBar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.width, [PtFtConfig artisticBarHeight])];
    _artisticBar.backgroundColor = [PtFtConfig artisticBarBgColor];
    [_barWrapper addArtisticBar:_artisticBar];
    _colorBar = [[PtFtViewLayerBar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.width, [PtFtConfig colorBarHeight])];
    _colorBar.backgroundColor = [PtFtConfig colorBarBgColor];
    [_barWrapper addColorBar:_colorBar];
    
    [self layoutButtons];
    
    [self selectLayerButtonWithEffectId:VnEffectIdNone];
    [self selectLayerButtonWithEffectId:VnEffectIdOverlayNone];
    [self selectLayerButtonWithEffectId:VnEffectIdColorNone];
    
}

#pragma mark button layout

- (void)layoutButtons
{
    [self layoutColorButtons];
    [self layoutOverlayButtons];
    [self layoutArtisticButtons];
}

- (void)layoutOverlayButtons
{
    
    PtFtObjectFilterItem* item;
    CGSize size = [PtFtConfig colorLayerButtonSize];
    
    _overlayButtonsDictionary = [NSMutableDictionary dictionary];
    NSMutableArray* items = [PtFtSharedFilterManager instance].overlayFilters;
    for (int i = 0; i < items.count; i++) {
        item = (PtFtObjectFilterItem*)[items objectAtIndex:i];
        if (item) {
            PtFtButtonLayerBar* button = [[PtFtButtonLayerBar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, size.width, size.height)];
            button.maskColor = _overlayBar.backgroundColor;
            button.previewColor = item.previewColor;
            button.title = item.name;
            button.maskRadius = [PtFtConfig colorLayerButtonMaskRadius];
            button.delegate = self;
            button.titleColor = [UIColor whiteColor];
            button.selectionColor = item.selectionColor;
            button.group = item.effectGroup;
            button.effectId = item.effectId;
            [_overlayBar appendLayerButton:button];
            [_overlayButtonsDictionary setObject:button forKey:[NSString stringWithFormat:@"%d", (int)item.effectId]];
        }
    }

}

- (void)layoutColorButtons
{
    
    PtFtObjectFilterItem* item;
    CGSize size = [PtFtConfig colorLayerButtonSize];
    
    _colorButtonsDictionary = [NSMutableDictionary dictionary];
    NSMutableArray* items = [PtFtSharedFilterManager instance].colorFilters;
    for (int i = 0; i < items.count; i++) {
        item = (PtFtObjectFilterItem*)[items objectAtIndex:i];
        if (item) {
            PtFtButtonLayerBar* button = [[PtFtButtonLayerBar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, size.width, size.height)];
            button.maskColor = _colorBar.backgroundColor;
            button.previewColor = item.previewColor;
            button.title = item.name;
            button.maskRadius = [PtFtConfig colorLayerButtonMaskRadius];
            button.delegate = self;
            button.titleColor = [UIColor whiteColor];
            button.selectionColor = item.selectionColor;
            button.group = item.effectGroup;
            button.effectId = item.effectId;
            [_colorBar appendLayerButton:button];
            [_colorButtonsDictionary setObject:button forKey:[NSString stringWithFormat:@"%d", (int)item.effectId]];
        }
    }
    
}

- (void)layoutArtisticButtons
{
    
    PtFtObjectFilterItem* item;
    CGSize size = [PtFtConfig artisticLayerButtonSize];
    
    _artisticButtonsDictionary = [NSMutableDictionary dictionary];
    NSMutableArray* items = [PtFtSharedFilterManager instance].artisticFilters;
    for (int i = 0; i < items.count; i++) {
        item = (PtFtObjectFilterItem*)[items objectAtIndex:i];
        if (item) {
            PtFtButtonLayerBar* button = [[PtFtButtonLayerBar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, size.width, size.height)];
            button.maskColor = _artisticBar.backgroundColor;
            button.previewColor = _artisticBar.backgroundColor;
            button.title = item.name;
            button.maskRadius = [PtFtConfig artisticLayerButtonMaskRadius];
            button.delegate = self;
            button.titleColor = [UIColor whiteColor];
            button.selectionColor = [UIColor whiteColor];
            button.group = item.effectGroup;
            button.effectId = item.effectId;
            [_artisticBar appendLayerButton:button];
            [_artisticButtonsDictionary setObject:button forKey:[NSString stringWithFormat:@"%d", (int)item.effectId]];
        }
    }

}

#pragma mark button

- (void)didLayerBarButtonTouchUpInside:(PtFtButtonLayerBar *)button
{
    [self selectLayerButtonWithButton:button];
    [self.delegate filterButtonDidTouchUpInside:button];
}

- (void)setPresetImage:(UIImage *)image ToEffect:(VnEffectId)effectId
{
    PtFtButtonLayerBar* button = [self buttonByEffectId:effectId];
    if (button) {
        button.previewImage = image;
    }
}

- (PtFtButtonLayerBar*)buttonByEffectId:(VnEffectId)effectId
{
    PtFtButtonLayerBar* button;
    button = [_colorButtonsDictionary objectForKey:[NSString stringWithFormat:@"%d", (int)effectId]];
    if (button) {
        return button;
    }
    button = [_artisticButtonsDictionary objectForKey:[NSString stringWithFormat:@"%d", (int)effectId]];
    if (button) {
        return button;
    }
    button = [_overlayButtonsDictionary objectForKey:[NSString stringWithFormat:@"%d", (int)effectId]];
    if (button) {
        return button;
    }
    return nil;
}

- (void)selectLayerButtonWithButton:(PtFtButtonLayerBar*)button
{
    if (button == nil) {
        return;
    }
    switch (button.group) {
        case VnEffectGroupColor:
        {
            if (_currentColorButton) {
                _currentColorButton.selected = NO;
            }
            button.selected = YES;
            _currentColorButton = button;
        }
            break;
        case VnEffectGroupEffects:
        {
            if (_currentArtisticButton) {
                _currentArtisticButton.selected = NO;
            }
            button.selected = YES;
            _currentArtisticButton = button;
        }
            break;
        case VnEffectGroupOverlays:
        {
            if (_currentOverlayButton) {
                _currentOverlayButton.selected = NO;
            }
            button.selected = YES;
            _currentOverlayButton = button;
            
        }
            break;
        default:
            break;
    }
}

- (void)selectLayerButtonWithEffectId:(VnEffectId)effectId
{
    PtFtButtonLayerBar* button = [self buttonByEffectId:effectId];
    if (button) {
        [self selectLayerButtonWithButton:button];
    }
}

#pragma mark delegate

- (void)deallocArtisticButtonImages
{
    [_artisticBar deallocAllButtons];
}


@end
