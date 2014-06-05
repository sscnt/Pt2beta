//
//  PtFtViewNavigationBar.h
//  Pastel2
//
//  Created by SSC on 2014/06/01.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PtFtButtonNavigation.h"

@interface PtFtViewNavigationBar : UIView
{
    VnViewLabel* _titleLabel;
}

@property (nonatomic, strong) NSString* title;

- (void)addDoneButton:(PtFtButtonNavigation*)button;
- (void)addCancelButton:(PtFtButtonNavigation*)button;

@end
