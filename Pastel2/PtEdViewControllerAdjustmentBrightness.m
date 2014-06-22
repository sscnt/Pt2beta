//
//  PtEdViewControllerAdjustmentBrightness.m
//  Pastel2
//
//  Created by SSC on 2014/06/21.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "PtEdViewControllerAdjustmentBrightness.h"

@interface PtEdViewControllerAdjustmentBrightness ()

@end

@implementation PtEdViewControllerAdjustmentBrightness

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.userInteractionEnabled = NO;
    self.navigationBar.title = NSLocalizedString(@"Brightness", nil);
    
    _sliderBar = [[PtAdViewSliderBar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [self.view width], [PtAdConfig sliderBarHeight])];
    [_sliderBar setY:[self.view height] - [PtSharedApp bottomNavigationBarHeight] - [_sliderBar height]];
    _sliderBar.slider.zeroPointAtCenter = YES;
    _sliderBar.slider.value = 0.0f;
    _sliderBar.delegate = self;
    [self.view addSubview:_sliderBar];
    
    _percentageBar = [[PtAdViewPercentage alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [self.view width], [PtAdConfig percentageBarHeight])];
    [_percentageBar setY:_sliderBar.frame.origin.y - [_percentageBar height]];
    _percentageBar.percentage = 0.0f;
    [self.view addSubview:_percentageBar];
    
    [self.progressView setProgress:0.10f];
    [self resizeImage];
}

- (void)didResizeImage
{
    [PtAdSharedQueueManager instance].delegate = self;
    self.progressView.hidden = YES;
    self.previewImageView.image = self.originalPreviewImage;
    self.view.userInteractionEnabled = YES;
}


#pragma mark slider

- (void)sliderDidValueChange:(CGFloat)value
{
    _percentageBar.percentage = value * 100.0f;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
