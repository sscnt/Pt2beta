//
//  PtFtViewNavigationBar.h
//  Pastel2
//
//  Created by SSC on 2014/06/01.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PtCoViewNavigationButton.h"

@interface PtCoViewNavigationBar : UIView
{
    VnViewLabel* _titleLabel;
}

@property (nonatomic, strong) NSString* title;

- (void)addDoneButton:(PtCoViewNavigationButton*)button;
- (void)addCancelButton:(PtCoViewNavigationButton*)button;

@end
