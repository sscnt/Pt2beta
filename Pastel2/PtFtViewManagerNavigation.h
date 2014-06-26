//
//  PtFtViewManagerNavigation.h
//  Pastel2
//
//  Created by SSC on 2014/06/01.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PtCoViewNavigationBar.h"
#import "PtCoViewNavigationButton.h"

@class PtViewControllerFilters;

@interface PtFtViewManagerNavigation : NSObject

@property (nonatomic, weak) UIView* view;
@property (nonatomic, weak) PtViewControllerFilters* delegate;
@property (nonatomic, strong) PtCoViewNavigationBar* navigationBar;
@property (nonatomic, strong) PtCoViewNavigationButton* cancelButton;
@property (nonatomic, strong) PtCoViewNavigationButton* doneButton;

- (void)viewDidLoad;

- (void)navigationDoneDidTouchUpInside:(PtCoViewNavigationButton*)button;
- (void)navigationCancelDidTouchUpInside:(PtCoViewNavigationButton*)button;

@end
