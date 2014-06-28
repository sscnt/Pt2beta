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
        PtStViewOptionItem* item;
        PtSharedApp* app = [PtSharedApp instance];
        
        //// Use Full Resolution
        item = [[PtStViewOptionItem alloc] initWithFrame:CGRectMake(0.0f, 50.0f, self.view.width, 50.0f)];
        sw = [[PtStViewSwitch alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 60.0f, 26.0f)];
        sw.on = app.useFullResolutionImage;
        [sw addTarget:self selector:@selector(switchFullResolutionDidToggle:)];
        [item addSwitch:sw];
        [item setTitle:NSLocalizedString(@"Use full resolution image", nil)];
        [self.view addSubview:item];
        
        //// Left handed mode
        item = [[PtStViewOptionItem alloc] initWithFrame:CGRectMake(0.0f, item.bottom, self.view.width, 50.0f)];
        sw = [[PtStViewSwitch alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 60.0f, 26.0f)];
        sw.on = app.leftHandedUI;
        [sw addTarget:self selector:@selector(switchLeftHandedDidToggle:)];
        [item addSwitch:sw];
        [item setTitle:NSLocalizedString(@"Left-handed mode", nil)];
        [self.view addSubview:item];
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
    [PtSharedApp instance].useFullResolutionImage = switdh.on;
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
