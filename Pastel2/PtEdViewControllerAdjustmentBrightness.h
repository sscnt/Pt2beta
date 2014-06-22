//
//  PtEdViewControllerAdjustmentBrightness.h
//  Pastel2
//
//  Created by SSC on 2014/06/21.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "PtEdViewControllerAdjustment.h"
#import "PtAdViewSliderBar.h"
#import "PtAdViewPercentage.h"

@interface PtEdViewControllerAdjustmentBrightness : PtEdViewControllerAdjustment <PtAdViewSliderBarDelegate, PtAdSharedQueueManagerDelegate>

@property (nonatomic, strong) PtAdViewSliderBar* sliderBar;
@property (nonatomic, strong) PtAdViewPercentage* percentageBar;

- (void)registerQueue;

@end
