//
//  PtViewControllerRoot.h
//  Pastel2
//
//  Created by SSC on 2014/05/27.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LmCmViewController.h"

@interface PtViewControllerRoot : UINavigationController <UINavigationControllerDelegate>

@property (nonatomic, strong) LmCmViewController* lmCmViewController;

- (void)applicationDidEnterBackground;
- (void)applicationWillEnterForeground;

@end
