//
//  PtAdViewSlider.h
//  Pastel2
//
//  Created by SSC on 2014/06/22.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PtAdViewSliderThumb.h"

@class PtAdViewSlider;

@protocol PtAdViewSliderDelegate
- (void)slider:(PtAdViewSlider*)slider DidValueChange:(CGFloat)value;
- (void)touchesBeganWithSlider:(PtAdViewSlider*)slider;
- (void)touchesMovedWithSlider:(PtAdViewSlider*)slider;
- (void)touchesEndedWithSlider:(PtAdViewSlider*)slider;
@end

@interface PtAdViewSlider : UIView <UIGestureRecognizerDelegate>
{
    PtAdViewSliderThumb* _thumbView;
    CGFloat _thumbStartPoint;
    CGFloat _thumbEndPoint;
    CGFloat _alpha;
    CGFloat _value;
    CGFloat _radius;
}

@property (nonatomic, assign) CGFloat value;
@property (nonatomic, weak) id<PtAdViewSliderDelegate> delegate;
@property (nonatomic, assign) CGFloat paddingHorizontal;
@property (nonatomic, assign) CGFloat paddingVertical;
@property (nonatomic, assign) BOOL locked;
@property (nonatomic, strong) UIColor* strokeColor;
@property (nonatomic, strong) UIColor* thumbColor;
@property (nonatomic, assign) BOOL vertical;
@property (nonatomic, assign) BOOL zeroPointAtCenter;

- (void)layout;
- (void)didDragThumb:(UIPanGestureRecognizer*)sender;
- (CGFloat)calcValueByThumbPosition:(CGFloat)x;
- (CGFloat)calcPoxitionByValue:(CGFloat)value;


@end
