//
//  VnViewSlider.m
//  Pastel
//
//  Created by SSC on 2014/05/11.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "LmCmViewZoomSlider.h"

@implementation LmCmViewZoomSlider

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor clearColor];
        self.alpha = 1.0f;
        
        //// Slider
        _paddingTop = 30.0f;
        float paddingBottom = 10.0f;
        CGFloat sliderHeight = frame.size.height - _paddingTop - paddingBottom;
        float padding = 8.0f;
        _sliderView = [[LmCmViewSlider alloc] initWithFrame:CGRectMake(padding, _paddingTop, frame.size.width - padding * 2.0f, sliderHeight)];
        _sliderView.vertical = YES;
        _sliderView.delegate = self;
        [self addSubview:_sliderView];
        
        //// Label
        _scaleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, frame.size.width, 20.0f)];
        _scaleLabel.backgroundColor = [UIColor clearColor];
        _scaleLabel.textColor = [UIColor whiteColor];
        _scaleLabel.numberOfLines = 0;
        _scaleLabel.textAlignment = NSTextAlignmentCenter;
        _scaleLabel.minimumScaleFactor = 0.50f;
        _scaleLabel.font = [UIFont fontWithName:@"ClearSans-Bold" size:14.0f];
        [self addSubview:_scaleLabel];
        [self setScaleToLabel:0.0f];
    }
    return self;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    // タッチされたビューを取得する
    UIView *hitView = [super hitTest:point withEvent:event];
    
    // タッチされたものがselfだったらイベントを発生させない
    if ( self == hitView )
    {
        return _sliderView;
    }
    
    // それ意外だったらイベント発生させる
    return hitView;
}

- (void)setLocked:(BOOL)locked
{
    _locked = locked;
    _sliderView.locked = locked;
}

- (CGFloat)value
{
    return _sliderView.value;
}

- (void)setValue:(CGFloat)value
{
    _sliderView.value = value;
    [self setScaleToLabel:value];
}

- (void)setSliderThumbColor:(UIColor *)sliderThumbColor
{
    _sliderThumbColor = sliderThumbColor;
    _sliderView.thumbColor = sliderThumbColor;
}

- (void)setSliderStrokeColor:(UIColor *)sliderStrokeColor
{
    _sliderStrokeColor = sliderStrokeColor;
    _sliderView.strokeColor = sliderStrokeColor;
}

//// scale must be 0 to 1
- (void)setScaleToLabel:(float)scale
{
    float base = scale * ([LmCmSharedCamera maxZoomScaleSupported] - 1.0f) + 1.0f;
    int ten = floor(base);
    int one = floor(base * 10.0f) - ten * 10;
    _scaleLabel.text = [NSString stringWithFormat:@"%d.%d", ten, one];
}

- (void)setActive:(BOOL)active
{
    _active = active;
    [self setNeedsDisplay];
}

#pragma mark delegate

- (void)slider:(LmCmViewSlider*)slider DidValueChange:(CGFloat)value
{
    [self.delegate slider:self DidValueChange:value];
}

- (void)touchesBeganWithSlider:(LmCmViewSlider*)slider
{
    [self.delegate touchesBeganWithSlider:self];
}

- (void)touchesMovedWithSlider:(LmCmViewSlider*)slider
{
    [self setScaleToLabel:slider.value];
}

- (void)touchesEndedWithSlider:(LmCmViewSlider*)slider
{
    [self.delegate touchesEndedWithSlider:self];
    [self setScaleToLabel:slider.value];
}

#pragma mark draw

- (void)drawRect:(CGRect)rect
{
    if (_active) {
        //// Color Declarations
        UIColor* color = [LmCmSharedCamera zoomSliderBgColor];
        
        //// Rounded Rectangle Drawing
        UIBezierPath* roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect: rect byRoundingCorners: UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii: CGSizeMake(3, 3)];
        [roundedRectanglePath closePath];
        [color setFill];
        [roundedRectanglePath fill];
        
        

    }
}

@end
