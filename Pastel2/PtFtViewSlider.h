//
//  UISliderVIew.h
//  Vintage
//
//  Created by SSC on 2014/02/16.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PtFtViewSliderThumb.h"

@class PtFtViewSlider;

@protocol PtFtViewSliderDelegate
- (void)slider:(PtFtViewSlider*)slider DidValueChange:(CGFloat)value;
- (void)touchesBeganWithSlider:(PtFtViewSlider*)slider;
- (void)touchesMovedWithSlider:(PtFtViewSlider*)slider;
- (void)touchesEndedWithSlider:(PtFtViewSlider*)slider;
@end

@interface PtFtViewSlider : UIView <UIGestureRecognizerDelegate>
{
    UILabel* _titleLabel;
    PtFtViewSliderThumb* _thumbView;
    CGFloat _thumbStartX;
    CGFloat _thumbEndX;
    CGFloat _alpha;
    CGFloat _value;
    CGFloat _radius;
}

@property (nonatomic, strong) NSString* title;
@property (nonatomic, assign) CGFloat value;
@property (nonatomic, weak) id<PtFtViewSliderDelegate> delegate;
@property (nonatomic, assign) CGFloat paddingHorizontal;
@property (nonatomic, assign) CGFloat paddingVertical;
@property (nonatomic, assign) BOOL locked;
@property (nonatomic, strong) UIColor* strokeColor;
@property (nonatomic, strong) UIColor* bgColor;
@property (nonatomic, strong) UIColor* thumbColor;
@property (nonatomic, strong) UIView* indicator;

- (void)didDragThumb:(UIPanGestureRecognizer*)sender;
- (CGFloat)calcValueByThumbPosition:(CGFloat)x;
- (CGFloat)calcPoxitionByValue:(CGFloat)value;

@end
