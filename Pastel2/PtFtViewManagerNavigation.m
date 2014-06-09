//
//  PtFtViewManagerNavigation.m
//  Pastel2
//
//  Created by SSC on 2014/06/01.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "PtFtViewManagerNavigation.h"
#import "PtViewControllerFilters.h"

@implementation PtFtViewManagerNavigation

- (void)viewDidLoad
{
    //// Navigation Bar
    _navigationBar = [[PtFtViewNavigationBar alloc] initWithFrame:CGRectMake(0.0f, self.view.height - [PtSharedApp bottomNavigationBarHeight], self.view.width, [PtSharedApp bottomNavigationBarHeight])];
    _navigationBar.title = NSLocalizedString(@"Filters", nil);
    [self.view addSubview:_navigationBar];
    
    //// Navigation Button
    _cancelButton = [[PtFtButtonNavigation alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [PtSharedApp bottomNavigationBarHeight], [PtSharedApp bottomNavigationBarHeight])];
    _cancelButton.type = PtFtButtonNavigationTypeCancel;
    [_cancelButton addTarget:self action:@selector(navigationCancelDidTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [_navigationBar addCancelButton:_cancelButton];
    _doneButton = [[PtFtButtonNavigation alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [PtSharedApp bottomNavigationBarHeight], [PtSharedApp bottomNavigationBarHeight])];
    _doneButton.type = PtFtButtonNavigationTypeDone;
    [_doneButton addTarget:self action:@selector(navigationDoneDidTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [_navigationBar addDoneButton:_doneButton];
}

#pragma mark button

- (void)navigationCancelDidTouchUpInside:(PtFtButtonNavigation *)button
{
    PtViewControllerFilters* con = self.delegate;
    //[con.filtersManager deallocArtisticButtonImages];
    [PtFtSharedQueueManager instance].canceled = YES;
    [con.navigationController popViewControllerAnimated:NO];
}

- (void)navigationDoneDidTouchUpInside:(PtFtButtonNavigation *)button
{
    [self.delegate applyFiltersToOriginalImage];
}

@end
