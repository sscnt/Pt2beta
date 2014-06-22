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
    self.navigationBar.title = NSLocalizedString(@"Brightness", nil);
    
    _sliderBar = [[PtAdViewSliderBar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [self.view width], [PtAdConfig sliderBarHeight])];
    [_sliderBar setY:[self.view height] - [PtSharedApp bottomNavigationBarHeight] - [_sliderBar height]];
    _sliderBar.slider.zeroPointAtCenter = YES;
    _sliderBar.slider.value = 0.0f;
    [self.view addSubview:_sliderBar];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
