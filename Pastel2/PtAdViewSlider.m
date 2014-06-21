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
        _paddingHorizontal = 0.0f;
        _paddingVertical = 0.0f;
        
        _radius = floorf(([self height] - 2.0f - _paddingVertical * 2.0f) / 2.0f);
        _thumbView = [[PtAdViewSliderThumb alloc] initWithRadius:_radius];
        _thumbView.center = CGPointMake([self width] / 2.0f, [self height] / 2.0f - 1.0f);
        
        _thumbStartPoint = _radius - 1.0f + _paddingHorizontal;
        _thumbEndPoint = [self width] - _radius - 1.0f - _paddingHorizontal;
    }
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
    return (_thumbEndPoint - _thumbStartPoint) * value + _thumbStartPoint;
}

- (CGFloat)calcValueByThumbPosition:(CGFloat)x
{
    if (_vertical) {
        CGFloat value = (_thumbEndPoint - x) / (_thumbEndPoint - _thumbStartPoint);
        return MAX(MIN(value, 1.0), 0.0f);
    }
    CGFloat value = (x - _thumbStartPoint) / (_thumbEndPoint - _thumbStartPoint);
    return MAX(MIN(value, 1.0), 0.0f);
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
        UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(_paddingHorizontal, rect.size.height / 2.0f - 1.0f, rect.size.width - 2.0f - _paddingHorizontal * 2.0f, 2.0f)];
        [_strokeColor setFill];
        [rectanglePath fill];
    }
}

@end
