//
//  PtAdViewControllerVignette.m
//  Pastel2
//
//  Created by SSC on 2014/06/24.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "PtAdViewControllerVignette.h"

@interface PtAdViewControllerVignette ()

@end

@implementation PtAdViewControllerVignette


- (void)viewDidLoad
{
    [super viewDidLoad];
    vignetteType = PtAdProcessQueueAdjustmentTypeVignetteAllAround;
    self.view.userInteractionEnabled = NO;
    self.navigationBar.title = NSLocalizedString(@"Vignette", nil);
    
    self.sliderBar.slider.zeroPointAtCenter = NO;
    
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
    queue.adjustmentType = vignetteType;
    queue.strength = self.sliderBar.slider.value;
    [[PtAdSharedQueueManager instance] addQueue:queue];
}

- (void)registerQueue
{
    
    PtAdObjectProcessQueue* queue = [[PtAdObjectProcessQueue alloc] init];
    queue.image = self.originalPreviewImage;
    queue.type = PtAdProcessQueueTypePreview;
    queue.adjustmentType = vignetteType;
    queue.strength = self.sliderBar.slider.value;
    queue.multiplierY = 1.0f;
    queue.multiplierX = 1.0f;
    queue.addingY = 0.0f;
    queue.addingX = 0.0f;
    queue.radiusMultiplier = self.originalPreviewImage.size.width / [PtSharedApp instance].originalImageSize.width;
    [[PtAdSharedQueueManager instance] addQueue:queue];
}

- (void)didResizeImage
{
    [super didResizeImage];
    //[self registerQueue];
    self.sliderBar.slider.value = 0.50f;
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
