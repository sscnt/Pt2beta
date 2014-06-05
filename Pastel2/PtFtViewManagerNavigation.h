//
//  PtFtViewManagerNavigation.h
//  Pastel2
//
//  Created by SSC on 2014/06/01.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PtFtViewNavigationBar.h"
#import "PtFtButtonNavigation.h"

@class PtViewControllerFilters;

@interface PtFtViewManagerNavigation : NSObject

@property (nonatomic, weak) UIView* view;
@property (nonatomic, weak) PtViewControllerFilters* delegate;
@property (nonatomic, strong) PtFtViewNavigationBar* navigationBar;
@property (nonatomic, strong) PtFtButtonNavigation* cancelButton;
@property (nonatomic, strong) PtFtButtonNavigation* doneButton;

- (void)viewDidLoad;

- (void)navigationDoneDidTouchUpInside:(PtFtButtonNavigation*)button;
- (void)navigationCancelDidTouchUpInside:(PtFtButtonNavigation*)button;

@end
