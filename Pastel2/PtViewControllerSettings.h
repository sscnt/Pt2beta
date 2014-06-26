//
//  PtViewControllerSettings.h
//  Pastel2
//
//  Created by SSC on 2014/05/30.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PtStViewSwitch.h"
#import "PtCoViewNavigationBar.h"
#import "PtCoViewNavigationButton.h"

@class LmCmViewController;

@interface PtViewControllerSettings : UIViewController

@property (nonatomic, strong) PtCoViewNavigationBar* navigationBar;
@property (nonatomic, strong) PtCoViewNavigationButton* cancelButton;
@property (nonatomic, weak) LmCmViewController* cameraController;

- (void)switchFullResolutionDidToggle:(PtStViewSwitch*)switdh;
- (void)switchLeftHandedDidToggle:(PtStViewSwitch*)switdh;

@end
