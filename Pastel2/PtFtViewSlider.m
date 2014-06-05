//
//  UISliderVIew.m
//  Vintage
//
//  Created by SSC on 2014/02/16.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "PtFtViewSlider.h"

@implementation PtFtViewSlider

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _paddingHorizontal = 15.0f;
        _paddingVertical = 8.0f;
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height)];
        _titleLabel.alpha = 0.9f;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.numberOfLines = 0;
        NSArray *langs = [NSLocale preferredLanguages];
        NSString *currentLanguage = [langs objectAtIndex:0];
        if([currentLanguage compare:@"ja"] == NSOrderedSame) {
            _titleLabel.font = [UIFont fontWithName:@"mplus-1c-bold" size:15.0f];
        } else {
            _titleLabel.font = [UIFont fontWithName:@"Aller-Bold" size:16.0f];
        }
        [self addSubview:_titleLabel];
        
        _radius = floorf((frame.size.height - 2.0f - _paddingVertical * 2.0f) / 2.0f);
        _thumbView = [[PtFtViewSliderThumb alloc] initWithRadius:_radius];
        _thumbView.center = CGPointMake(frame.size.width / 2.0f, frame.size.height / 2.0f - 1.0f);
        UIPanGestureRecognizer* recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didDragThumb:)];
        recognizer.maximumNumberOfTouches = 1;
        recognizer.delegate = self;
        [self addGestureRecognizer:recognizer];
        [self addSubview:_thumbView];
        
        _thumbStartX = _radius - 1.0f + _paddingHorizontal;
        _thumbEndX = frame.size.width - _radius - 1.0f - _paddingHorizontal;
        
        _indicator = [[UIView alloc] initWithFrame:CGRectMake(_paddingHorizontal, frame.size.height / 2.0f - 2.0f, 0.0f, 4.0f)];
        [self addSubview:_indicator];
        
        self.value = 1.0f;
        [self bringSubviewToFront:_thumbView];
    }
    return self;
}

- (void)setStrokeColor:(UIColor *)strokeColor
{
    _strokeColor = strokeColor;
    _indicator.backgroundColor = strokeColor;
}

- (void)setThumbColor:(UIColor *)thumbColor
{
    _thumbColor = thumbColor;
    _thumbView.color = thumbColor;
}

- (void)setBgColor:(UIColor *)bgColor
{
    _bgColor = bgColor;
    _thumbView.strokeColor = bgColor;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    _titleLabel.text = title;
    [_titleLabel sizeToFit];
}

- (CGFloat)value
{
    return _value;
}

- (void)setValue:(CGFloat)value
{
    _value = value;
    CGFloat x = [self calcPoxitionByValue:value];
    _thumbView.center = CGPointMake(x, _thumbView.center.y);
    [_indicator setWidth:x - _radius];
}

- (void)setLocked:(BOOL)locked
{
    _locked = locked;
    _thumbView.locked = locked;
}

- (CGFloat)calcPoxitionByValue:(CGFloat)value
{
    return (_thumbEndX - _thumbStartX) * value + _thumbStartX;
}

- (CGFloat)calcValueByThumbPosition:(CGFloat)x
{
    CGFloat value = (x - _thumbStartX) / (_thumbEndX - _thumbStartX);
    return MAX(MIN(value, 1.0), 0.0f);
}

- (void)didDragThumb:(UIPanGestureRecognizer *)sender
{
    if(_locked){
        return;
    }
    PtFtViewSliderThumb* thumbView = _thumbView;
    CGPoint transitionPoint = [sender translationInView:thumbView];
    
    CGFloat x = thumbView.center.x + transitionPoint.x;
    if (x > _thumbEndX) {
        x = _thumbEndX;
    }else if (x < _thumbStartX){
        x = _thumbStartX;
    }
    
    [_indicator setWidth:x - _radius];
    
    CGPoint movedPoint = CGPointMake(x, thumbView.center.y);
    thumbView.center = movedPoint;
    
    _value = [self calcValueByThumbPosition:x];
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
    _titleLabel.alpha = _alpha;
    [self setNeedsDisplay];
}

#pragma mark delegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (void)drawRect:(CGRect)rect
{
    //// Rectangle Drawing
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(_paddingHorizontal, rect.size.height / 2.0f - 1.0f, rect.size.width - 2.0f - _paddingHorizontal * 2.0f, 2.0f)];
    [_strokeColor setFill];
    [rectanglePath fill];
}

@end
