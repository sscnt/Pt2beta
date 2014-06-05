//
//  PtViewBottomBar.h
//  Pastel2
//
//  Created by SSC on 2014/05/30.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PtEdViewBarButton.h"

@interface PtEdViewBottomBar : UIView

- (void)addBackToCameraButton:(PtEdViewBarButton*)button;
- (void)addFiltersButton:(PtEdViewBarButton*)button;
- (void)addSlidersButton:(PtEdViewBarButton*)button;

@end
