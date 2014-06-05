//
//  LmViewManagerCameraZoom.m
//  Lumina
//
//  Created by SSC on 2014/05/23.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "LmCmViewManagerZoom.h"
#import "LmCmViewController.h"

@implementation LmCmViewManagerZoom

- (void)viewDidLoad
{
    _currentScale = [LmCmSharedCamera instance].zoom;
    
    LmCmViewController* _self = self.delegate;
    
    //// Zoom recognizer
    UIGestureRecognizer *recognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinchFrom:)];
    recognizer.delegate = self;
    [_self.cameraPreviewOverlay addGestureRecognizer:recognizer];
    
    //// Zoom slider
    float sliderWidth = 30.0f;
    _zoomSlider = [[LmCmViewZoomSlider alloc] initWithFrame:CGRectMake([UIScreen width] - sliderWidth, 0.0f, sliderWidth, 260.0f)];
    _zoomSlider.sliderStrokeColor = [UIColor whiteColor];
    _zoomSlider.sliderThumbColor = [UIColor whiteColor];
    _zoomSlider.center = CGPointMake(_zoomSlider.center.x, [_self.cameraPreviewOverlay height] / 2.0f);
    _zoomSlider.value = 0.0f;
    _zoomSlider.delegate = self;
    _zoomSlider.hidden = ![LmCmSharedCamera instance].showZoomSlider;
    [_self.cameraPreviewOverlay addSubview:_zoomSlider];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    // gestureをセットしたview以外がタッチされた場合はgestureを無視
    if (touch.view != gestureRecognizer.view)
    {
        return false;
    }
    return true;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if ([gestureRecognizer isKindOfClass:[UIPinchGestureRecognizer class]]) {
        // 適用されているスケールを覚えておく
        _beginScale = _currentScale;
    }
    return YES;
}

- (void)setShowZoomSlider:(BOOL)showZoomSlider
{
    _showZoomSlider = showZoomSlider;
    _zoomSlider.hidden = !showZoomSlider;
}

- (void)handlePinchFrom:(UIPinchGestureRecognizer *)recognizer
{
    LmCmViewController* _self = self.delegate;
    
    // 新しく適用するスケールを計算する (適用されているスケール x 新しくピンチしたスケール)
    _currentScale = _beginScale * recognizer.scale;
    if (_currentScale < 1.0f) {
        _currentScale = 1.0f;
    }else if(_currentScale > [LmCmSharedCamera maxZoomScaleSupported]){
        _currentScale = [LmCmSharedCamera maxZoomScaleSupported];
    }
    [self transformLayerWithZoomScale:_currentScale];
    [self applyZoomScaleToSlider:_currentScale];
}

//// zoom must be 1.0 - max
- (void)transformLayerWithZoomScale:(float)zoom
{
    LmCmViewController* _self = self.delegate;
    
    // スケールをビューに適用する
    [_self.cameraPreview.layer setAffineTransform:CGAffineTransformMakeScale(zoom, zoom)];
    [LmCmSharedCamera setZoom:zoom];
}

- (void)applyZoomScaleToSlider:(float)scale
{
    _zoomSlider.value = (scale - 1.0f) / ([LmCmSharedCamera maxZoomScaleSupported] - 1.0f);
}

#pragma mark delegate

- (void)touchesBeganWithSlider:(LmCmViewZoomSlider *)slider
{
    
}

- (void)touchesEndedWithSlider:(LmCmViewZoomSlider *)slider
{
    
}

- (void)slider:(LmCmViewZoomSlider *)slider DidValueChange:(CGFloat)value
{
    [self transformLayerWithZoomScale:(value * ([LmCmSharedCamera maxZoomScaleSupported] - 1.0f) + 1.0f)];
}

@end
