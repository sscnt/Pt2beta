//
//  VnViewEditorToolBarButton.m
//  Vintage 2.0
//
//  Created by SSC on 2014/04/21.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "PtFtButtonLayerBar.h"

@implementation PtFtButtonLayerBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addTarget:self action:@selector(didTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        
        float labelHeight = 15.0f;
        
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(1.0f, 1.0f, frame.size.width - 2.0f, frame.size.height - labelHeight - 2.0f)];
        _imageView.userInteractionEnabled = NO;
        [self addSubview:_imageView];
        
        _maskView = [[PtFtViewLayerBarButtonMask alloc] initWithFrame:CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height - labelHeight)];
        _maskView.userInteractionEnabled = NO;
        [self addSubview:_maskView];
        
        float padding = 2.0f;
        if ([UIDevice isIOS6]) {
            if ([UIDevice isCurrentLanguageJapanese]) {
                padding = 0.0f;
            }
        }else{
            
        }
        
        _locked = NO;
        _titleLabel = [[VnViewLabel alloc] initWithFrame:CGRectMake(0.0f, frame.size.height - labelHeight - padding, frame.size.width, labelHeight)];
        _titleLabel.fontSize = 10.0f;
        [self addSubview:_titleLabel];
    }
    return self;
}

- (void)setPreviewColor:(UIColor *)previewColor
{
    _previewColor = previewColor;
    _imageView.backgroundColor = previewColor;
}

- (UIImage *)previewImage
{
    return _imageView.image;
}

- (void)setPreviewImage:(UIImage *)previewImage
{
    _imageView.image = previewImage;
}

- (void)deallocImage
{
    if (_imageView.image) {
        _imageView.image = nil;
        [_imageView removeFromSuperview];
    }
}

- (void)setLocked:(BOOL)locked
{
    _locked = locked;
    if (_locked) {
        _imageView.hidden = YES;
    }else{
        _imageView.hidden = NO;
    }
    [self setNeedsDisplay];
}

- (void)setMaskColor:(UIColor *)maskColor
{
    _maskColor = maskColor;
    _maskView.maskColor = maskColor;
}

- (void)setTitleColor:(UIColor *)titleColor
{
    _titleColor = titleColor;
    _titleLabel.textColor = titleColor;
}

- (void)setSelectionColor:(UIColor *)selectionColor
{
    _selectionColor = selectionColor;
    _maskView.selectionColor = selectionColor;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    _titleLabel.text = title;
}

- (void)setMaskRadius:(float)maskRadius
{
    _maskRadius = maskRadius;
    _maskView.radius = maskRadius;
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    _maskView.selected = selected;
    [_maskView setNeedsDisplay];
}

- (void)didTouchUpInside:(PtFtButtonLayerBar *)sender
{
    [self.delegate didLayerBarButtonTouchUpInside:self];
}

- (void)drawRect:(CGRect)rect
{
    if (_locked) {
        //// Color Declarations
        UIColor* color = [UIColor colorWithRed: 0 green: 0.69 blue: 0.929 alpha: 1];
        
        //// Rectangle Drawing
        UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height - 15.0f)];
        [color setFill];
        [rectanglePath fill];
        
        //// Bezier Drawing
        UIBezierPath* bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint: CGPointMake(38.95, 23.17)];
        [bezierPath addCurveToPoint: CGPointMake(38.96, 23.72) controlPoint1: CGPointMake(38.96, 23.35) controlPoint2: CGPointMake(38.96, 23.54)];
        [bezierPath addCurveToPoint: CGPointMake(27.29, 35.75) controlPoint1: CGPointMake(38.96, 29.31) controlPoint2: CGPointMake(34.84, 35.75)];
        [bezierPath addCurveToPoint: CGPointMake(21, 33.85) controlPoint1: CGPointMake(24.97, 35.75) controlPoint2: CGPointMake(22.82, 35.05)];
        [bezierPath addCurveToPoint: CGPointMake(21.98, 33.91) controlPoint1: CGPointMake(21.32, 33.89) controlPoint2: CGPointMake(21.65, 33.91)];
        [bezierPath addCurveToPoint: CGPointMake(27.08, 32.1) controlPoint1: CGPointMake(23.9, 33.91) controlPoint2: CGPointMake(25.67, 33.24)];
        [bezierPath addCurveToPoint: CGPointMake(23.24, 29.16) controlPoint1: CGPointMake(25.28, 32.07) controlPoint2: CGPointMake(23.76, 30.84)];
        [bezierPath addCurveToPoint: CGPointMake(24.02, 29.24) controlPoint1: CGPointMake(23.49, 29.21) controlPoint2: CGPointMake(23.75, 29.24)];
        [bezierPath addCurveToPoint: CGPointMake(25.1, 29.09) controlPoint1: CGPointMake(24.39, 29.24) controlPoint2: CGPointMake(24.75, 29.19)];
        [bezierPath addCurveToPoint: CGPointMake(21.8, 24.94) controlPoint1: CGPointMake(23.22, 28.7) controlPoint2: CGPointMake(21.8, 26.99)];
        [bezierPath addCurveToPoint: CGPointMake(21.8, 24.89) controlPoint1: CGPointMake(21.8, 24.93) controlPoint2: CGPointMake(21.8, 24.91)];
        [bezierPath addCurveToPoint: CGPointMake(23.66, 25.42) controlPoint1: CGPointMake(22.36, 25.21) controlPoint2: CGPointMake(22.99, 25.4)];
        [bezierPath addCurveToPoint: CGPointMake(21.84, 21.9) controlPoint1: CGPointMake(22.56, 24.66) controlPoint2: CGPointMake(21.84, 23.37)];
        [bezierPath addCurveToPoint: CGPointMake(22.39, 19.77) controlPoint1: CGPointMake(21.84, 21.13) controlPoint2: CGPointMake(22.04, 20.4)];
        [bezierPath addCurveToPoint: CGPointMake(30.85, 24.19) controlPoint1: CGPointMake(24.42, 22.33) controlPoint2: CGPointMake(27.44, 24.02)];
        [bezierPath addCurveToPoint: CGPointMake(30.74, 23.23) controlPoint1: CGPointMake(30.78, 23.89) controlPoint2: CGPointMake(30.74, 23.56)];
        [bezierPath addCurveToPoint: CGPointMake(34.85, 19) controlPoint1: CGPointMake(30.74, 20.89) controlPoint2: CGPointMake(32.58, 19)];
        [bezierPath addCurveToPoint: CGPointMake(37.84, 20.33) controlPoint1: CGPointMake(36.03, 19) controlPoint2: CGPointMake(37.1, 19.51)];
        [bezierPath addCurveToPoint: CGPointMake(40.45, 19.31) controlPoint1: CGPointMake(38.78, 20.14) controlPoint2: CGPointMake(39.66, 19.79)];
        [bezierPath addCurveToPoint: CGPointMake(38.64, 21.65) controlPoint1: CGPointMake(40.14, 20.3) controlPoint2: CGPointMake(39.49, 21.13)];
        [bezierPath addCurveToPoint: CGPointMake(41, 20.98) controlPoint1: CGPointMake(39.47, 21.55) controlPoint2: CGPointMake(40.27, 21.32)];
        [bezierPath addCurveToPoint: CGPointMake(38.95, 23.17) controlPoint1: CGPointMake(40.45, 21.83) controlPoint2: CGPointMake(39.76, 22.58)];
        [bezierPath closePath];
        bezierPath.miterLimit = 4;
        
        [[UIColor whiteColor] setFill];
        [bezierPath fill];

        
    }
}

@end
