//
//  PtAdViewControllerExposure.m
//  Pastel2
//
//  Created by SSC on 2014/06/23.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "PtAdViewControllerExposure.h"

@interface PtAdViewControllerExposure ()

@end

@implementation PtAdViewControllerExposure


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.userInteractionEnabled = NO;
    self.navigationBar.title = NSLocalizedString(@"Exposure", nil);
    
    [self.progressView setProgress:0.10f];
    [self resizeImage];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)applyCurrentFiltersToOriginalImage
{
    PtAdObjectProcessQueue* queue = [[PtAdObjectProcessQueue alloc] init];
    queue.type = PtAdProcessQueueTypeOriginal;
    queue.adjustmentType = PtAdProcessQueueAdjustmentTypeExposure;
    queue.strength = self.sliderBar.slider.value;
    [[PtAdSharedQueueManager instance] addQueue:queue];
}

- (void)registerQueue
{
    
    PtAdObjectProcessQueue* queue = [[PtAdObjectProcessQueue alloc] init];
    queue.image = self.originalPreviewImage;
    queue.type = PtAdProcessQueueTypePreview;
    queue.adjustmentType = PtAdProcessQueueAdjustmentTypeExposure;
    queue.strength = self.sliderBar.slider.value;
    queue.radiusMultiplier = self.originalPreviewImage.size.width / [PtSharedApp instance].originalImageSize.width;
    [[PtAdSharedQueueManager instance] addQueue:queue];
}


#pragma mark slider

- (void)sliderDidValueChange:(CGFloat)value
{
    self.percentageBar.percentage = value * 100.0f;
    if ([PtAdSharedQueueManager instance].processing == NO) {
        [self registerQueue];
    }
}

@end
