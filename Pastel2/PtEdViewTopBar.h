//
//  PtViewTopBar.h
//  Pastel2
//
//  Created by SSC on 2014/05/30.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PtEdViewBarButton.h"

@interface PtEdViewTopBar : UIView

- (void)addInstagramButton:(PtEdViewBarButton*)button;
- (void)addTwitterButton:(PtEdViewBarButton*)button;
- (void)addFacebookButton:(PtEdViewBarButton*)button;
- (void)addOtherButton:(PtEdViewBarButton*)button;
- (void)addCamerarollButton:(PtEdViewBarButton*)button;

@end
