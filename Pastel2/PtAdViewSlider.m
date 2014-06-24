//
//  PtAdViewSlider.m
//  Pastel2
//
//  Created by SSC on 2014/06/22.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "PtAdViewSlider.h"

@implementation PtAdViewSlider


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
        
        UIPanGestureRecognizer* recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didDragThumb:)];
        recognizer.maximumNumberOfTouches = 1;
        recognizer.delegate = self;
        [self addGestureRecognizer:recognizer];
        self.zeroPointAtCenter = NO;
    }
    return self;
}

- (void)layout
{
    if (_vertical) {
        _paddingHorizontal = 0.0f;
        _paddingVertical = 0.0f;
        
        _radius = floorf(([self width] - 2.0f - _paddingHorizontal * 2.0f) / 2.0f);
        _thumbView = [[PtAdViewSliderThumb alloc] initWithRadius:_radius];
        _thumbView.center = CGPointMake([self width] / 2.0f, [self height] / 2.0f);
        
        _thumbStartPoint = _radius - 1.0f + _paddingVertical;
        _thumbEndPoint = [self height] - _radius - _paddingHorizontal;
        
    }else{
        _paddingHorizontal = 25.0f;
        _paddingVertical = 27.0f;
        
        _indicatorView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 0.0f, 3.0f)];
        _indicatorView.center = CGPointMake([self width] / 2.0f, [self height] / 2.0f);
        
        _radius = floorf(([self height] - 2.0f - _paddingVertical * 2.0f) / 2.0f);
        _thumbView = [[PtAdViewSliderThumb alloc] initWithRadius:_radius];
        _thumbView.center = CGPointMake([self width] / 2.0f, [self height] / 2.0f);
        
        
        _thumbStartPoint = _radius + _paddingHorizontal;
        _thumbEndPoint = [self width] - _radius - _paddingHorizontal;
    }
    [self addSubview:_indicatorView];
    [self addSubview:_thumbView];
    self.value = 1.0f;
    [self bringSubviewToFront:_thumbView];
}

- (void)setVertical:(BOOL)vertical
{
    _vertical = vertical;
    [self layout];
}

- (void)setStrokeColor:(UIColor *)strokeColor
{
    _strokeColor = strokeColor;
}

- (void)setThumbColor:(UIColor *)thumbColor
{
    _thumbColor = thumbColor;
    _thumbView.color = thumbColor;
}
- (void)setZeroPointAtCenter:(BOOL)zeroPointAtCenter
{
    _zeroPointAtCenter = zeroPointAtCenter;
    [self setNeedsDisplay];
    self.value = _value;
}

- (void)setIndicatorColor:(UIColor *)indicatorColor
{
    _indicatorColor = indicatorColor;
    _indicatorView.backgroundColor = indicatorColor;
}

- (void)setThumbBgColor:(UIColor *)thumbBgColor
{
    _thumbBgColor = thumbBgColor;
    _thumbView.bgColor = thumbBgColor;
}

- (CGFloat)value
{
    return _value;
}

- (void)setValue:(CGFloat)value
{
    _value = value;
    CGFloat point = [self calcPoxitionByValue:value];
    if (_vertical) {
        _thumbView.center = CGPointMake(_thumbView.center.x, point);
    }else{
        _thumbView.center = CGPointMake(point, _thumbView.center.y);
    }
    
    [self layoutIndicatorViewWithValue:value];
}

- (void)layoutIndicatorViewWithValue:(float)value
{
    if (_vertical) {
        
    }else{
        if (_zeroPointAtCenter) {
            float w = [self width] - _paddingHorizontal * 2.0f;
            w /= 2.0f;
            float ww = abs(w * value);
            if (value < 0.0f) {
                _indicatorView.frame = CGRectMake(w + _paddingHorizontal - ww, _indicatorView.frame.origin.y, ww, [_indicatorView height]);
            }else{
                _indicatorView.frame = CGRectMake(w + _paddingHorizontal, _indicatorView.frame.origin.y, ww, [_indicatorView height]);
            }
        }else{
            float w = [self width] - _paddingHorizontal * 2.0f;
            w *= value;
            _indicatorView.frame = CGRectMake(_paddingHorizontal, _indicatorView.frame.origin.y, w, [_indicatorView height]);
        }

    }
}

- (void)setLocked:(BOOL)locked
{
    _locked = locked;
    _thumbView.locked = locked;
}

- (CGFloat)calcPoxitionByValue:(CGFloat)value
{
    if (_vertical) {
        return _thumbEndPoint - (_thumbEndPoint - _thumbStartPoint) * value;
    }
    if (_zeroPointAtCenter) {
        value = (value + 1.0f) / 2.0f;
    }
    return (_thumbEndPoint - _thumbStartPoint) * value + _thumbStartPoint;
}

- (CGFloat)calcValueByThumbPosition:(CGFloat)x
{
    if (_vertical) {
        CGFloat value = (_thumbEndPoint - x) / (_thumbEndPoint - _thumbStartPoint);
        return MAX(MIN(value, 1.0), 0.0f);
    }
    CGFloat value = (x - _thumbStartPoint) / (_thumbEndPoint - _thumbStartPoint);
    value = MAX(MIN(value, 1.0), 0.0f);
    if (_zeroPointAtCenter) {
        return (value - 0.50f) * 2.0f;
    }
    return value;
}

- (void)didDragThumb:(UIPanGestureRecognizer *)sender
{
    if(_locked){
        return;
    }
    PtAdViewSliderThumb* thumbView = _thumbView;
    CGPoint transitionPoint = [sender translationInView:thumbView];
    
    if (_vertical) {
        CGFloat y = thumbView.center.y + transitionPoint.y;
        if (y > _thumbEndPoint) {
            y = _thumbEndPoint;
        }else if (y < _thumbStartPoint){
            y = _thumbStartPoint;
        }
        
        CGPoint movedPoint = CGPointMake(thumbView.center.x, y);
        thumbView.center = movedPoint;
        
        _value = [self calcValueByThumbPosition:y];
    }else{
        CGFloat x = thumbView.center.x + transitionPoint.x;
        if (x > _thumbEndPoint) {
            x = _thumbEndPoint;
        }else if (x < _thumbStartPoint){
            x = _thumbStartPoint;
        }
        
        CGPoint movedPoint = CGPointMake(x, thumbView.center.y);
        thumbView.center = movedPoint;
        
        _value = [self calcValueByThumbPosition:x];
    }
    
    [self layoutIndicatorViewWithValue:_value];
    
    [self.delegate slider:self DidValueChange:_value];
    
    [sender setTranslation:CGPointZero inView:thumbView];
    
    switch (sender.state) {
        case UIGestureRecognizerStatePossible:
            break;
        case UIGestureRecognizerStateBegan:
            [self.delegate touchesBeganWithSlider:self];
            break;
        case UIGestureRecognizerStateChanged:
            [self.delegate touchesMovedWithSlider:self];
            break;
        case UIGestureRecognizerStateEnded:
            [self.delegate touchesEndedWithSlider:self];
            break;
        case UIGestureRecognizerStateCancelled:
            [self.delegate touchesEndedWithSlider:self];
            break;
        case UIGestureRecognizerStateFailed:
            break;
    }
}

- (void)setAlpha:(CGFloat)alpha
{
    _alpha = alpha;
    [self setNeedsDisplay];
}

#pragma mark delegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (void)drawRect:(CGRect)rect
{
    if (_vertical) {
        //// Rectangle Drawing
        UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(rect.size.width / 2.0f - 1.0f, 0.0f, 2.0f, rect.size.height)];
        [_strokeColor setFill];
        [rectanglePath fill];
    }else{
        //// Rectangle Drawing
        UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(_paddingHorizontal, rect.size.height / 2.0f - 0.5, rect.size.width - 2.0f - _paddingHorizontal * 2.0f, 1.0f)];
        [_strokeColor setFill];
        [rectanglePath fill];
        
        if (_zeroPointAtCenter) {
            //// Rectangle Drawing
            rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(rect.size.width / 2.0 - 0.5, rect.size.height / 2.0f - 8.0f, 1.0f, 16.0f)];
            [_strokeColor setFill];
            [rectanglePath fill];
        }else{
            
        }
    }
}

@end
