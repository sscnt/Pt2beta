//
//  UISliderVIew.h
//  Vintage
//
//  Created by SSC on 2014/02/16.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LmCmViewSliderThumb.h"

@class LmCmViewSlider;

@protocol LmCmViewSliderDelegate
- (void)slider:(LmCmViewSlider*)slider DidValueChange:(CGFloat)value;
- (void)touchesBeganWithSlider:(LmCmViewSlider*)slider;
- (void)touchesMovedWithSlider:(LmCmViewSlider*)slider;
- (void)touchesEndedWithSlider:(LmCmViewSlider*)slider;
@end

@interface LmCmViewSlider : UIView <UIGestureRecognizerDelegate>
{
    LmCmViewSliderThumb* _thumbView;
    CGFloat _thumbStartPoint;
    CGFloat _thumbEndPoint;
    CGFloat _alpha;
    CGFloat _value;
    CGFloat _radius;
}

@property (nonatomic, assign) CGFloat value;
@property (nonatomic, weak) id<LmCmViewSliderDelegate> delegate;
@property (nonatomic, assign) CGFloat paddingHorizontal;
@property (nonatomic, assign) CGFloat paddingVertical;
@property (nonatomic, assign) BOOL locked;
@property (nonatomic, strong) UIColor* strokeColor;
@property (nonatomic, strong) UIColor* thumbColor;
@property (nonatomic, assign) BOOL vertical;

- (void)layout;
- (void)didDragThumb:(UIPanGestureRecognizer*)sender;
- (CGFloat)calcValueByThumbPosition:(CGFloat)x;
- (CGFloat)calcPoxitionByValue:(CGFloat)value;

@end
