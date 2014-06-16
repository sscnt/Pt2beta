//
//  PtEdViewToolBar.h
//  Pastel2
//
//  Created by SSC on 2014/06/16.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PtEdViewBarButton.h"


@interface PtEdViewToolBar : UIView
{
    float x;
}

- (void)appendButton:(PtEdViewBarButton*)button;

@end
