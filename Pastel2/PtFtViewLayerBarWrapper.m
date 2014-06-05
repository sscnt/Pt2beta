//
//  VnViewEditorLayerBarWrapper.m
//  Pastel
//
//  Created by SSC on 2014/05/11.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "PtFtViewLayerBarWrapper.h"

@implementation PtFtViewLayerBarWrapper

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _sliding = NO;
        self.userInteractionEnabled = YES;
        self.clipsToBounds = YES;
        
        _view = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height * 2.0f)];
        _view.userInteractionEnabled = YES;
        [self addSubview:_view];
    }
    return self;
}

- (void)setBar:(PtFtViewLayerBar *)bar
{
    _bar = bar;
    [_view addSubview:bar];
}

- (void)setLayerSlider:(PtFtViewSlider *)layerSlider
{
    _layerSlider = layerSlider;
    [_view addSubview:_layerSlider];
}

- (void)slideUp
{
    if (_sliding) {
        LOG(@"Sorry now sliding...");
        return;
    }
    _sliding = YES;
    _layerSlider.alpha = 0.0f;
    _bar.alpha = 1.0f;
    __block PtFtViewLayerBarWrapper* _self = self;
    [UIView animateWithDuration:0.2f
                     animations:^{
                         [_self.view setY:-_self.frame.size.height];
                         _layerSlider.alpha = 1.0f;
                         _bar.alpha = 0.0f;
                     }
                     completion:^(BOOL finished){
                         _self.sliding = NO;
                         [_self.delegate wrapperDidSlideUp];
                     }];
}

- (void)slideDown
{
    if (_sliding) {
        LOG(@"Sorry now sliding...");
        return;
    }
    _sliding = YES;
    _layerSlider.alpha = 1.0f;
    _bar.alpha = 0.0f;
    __block PtFtViewLayerBarWrapper* _self = self;
    [UIView animateWithDuration:0.2f
                     animations:^{
                         [_self.view setY:0];
                         _layerSlider.alpha = 0.0f;
                         _bar.alpha = 1.0f;
                     }
                     completion:^(BOOL finished){
                         _self.sliding = NO;
                         [_self.delegate wrapperDidSlideDown];
                     }];
}

@end
