//
//  PtViewControllerSettings.m
//  Pastel2
//
//  Created by SSC on 2014/05/30.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "PtViewControllerSettings.h"
#import "LmCmViewController.h"

@interface PtViewControllerSettings ()

@end

@implementation PtViewControllerSettings

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [PtStConfig bgColor];
        
        //// Navigation Bar
        _navigationBar = [[PtCoViewNavigationBar alloc] initWithFrame:CGRectMake(0.0f, self.view.height - [PtSharedApp bottomNavigationBarHeight], self.view.width, [PtSharedApp bottomNavigationBarHeight])];
        _navigationBar.title = NSLocalizedString(@"Settings", nil);
        [self.view addSubview:_navigationBar];
        
        //// Navigation Button
        _cancelButton = [[PtCoViewNavigationButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [PtSharedApp bottomNavigationBarHeight], [PtSharedApp bottomNavigationBarHeight])];
        _cancelButton.type = PtCoViewNavigationButtonTypeCancel;
        [_cancelButton addTarget:self action:@selector(navigationCancelDidTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [_navigationBar addDoneButton:_cancelButton];
        
        //// Switches
        PtStViewSwitch* sw;
        PtSharedApp* app = [PtSharedApp instance];
        
        sw = [[PtStViewSwitch alloc] initWithFrame:CGRectMake(100.0f, 100.0f, 70.0f, 30.0f)];
        sw.on = app.useFullResolutionImage;
        [sw addTarget:self selector:@selector(switchFullResolutionDidToggle:)];
        [self.view addSubview:sw];
        
        sw = [[PtStViewSwitch alloc] initWithFrame:CGRectMake(100.0f, 200.0f, 70.0f, 30.0f)];
        sw.on = app.leftHandedUI;
        [sw addTarget:self selector:@selector(switchLeftHandedDidToggle:)];
        [self.view addSubview:sw];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)switchLeftHandedDidToggle:(PtStViewSwitch *)switdh
{
    [PtSharedApp instance].leftHandedUI = switdh.on;
}

- (void)switchFullResolutionDidToggle:(PtStViewSwitch *)switdh
{
    
}

#pragma mark navigation

- (void)navigationCancelDidTouchUpInside:(PtCoViewNavigationButton *)button
{
    [_cameraController layoutViews];
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
