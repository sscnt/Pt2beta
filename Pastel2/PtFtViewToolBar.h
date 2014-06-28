//
//  PtFtViewToolBar.h
//  Pastel2
//
//  Created by SSC on 2014/06/25.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PtFtViewToolBarButton.h"

@interface PtFtViewToolBar : UIView
{
    float _lx;
    float _rx;
}

- (void)appendButtonToLeft:(PtFtViewToolBarButton*)button;
- (void)appendButtonToRight:(PtFtViewToolBarButton*)button;

@end
