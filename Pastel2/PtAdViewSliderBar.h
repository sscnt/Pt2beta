//
//  PtAdViewSliderBar.h
//  Pastel2
//
//  Created by SSC on 2014/06/22.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PtAdViewSlider.h"

@protocol PtAdViewSliderBarDelegate
- (void)sliderDidValueChange:(CGFloat)value;
@end

@interface PtAdViewSliderBar : UIView <PtAdViewSliderDelegate>

@property (nonatomic, strong) PtAdViewSlider* slider;
@property (nonatomic, assign) float value;
@property (nonatomic, weak) id<PtAdViewSliderBarDelegate> delegate;

@end
