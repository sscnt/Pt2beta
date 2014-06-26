//
//  PtFtViewBarWrapper.h
//  Pastel2
//
//  Created by SSC on 2014/06/01.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PtFtViewLayerBar.h"
#import "PtFtViewToolBar.h"

@interface PtFtViewBarWrapper : UIView

- (void)addToolBar:(PtFtViewToolBar*)bar;
- (void)addOverlayBar:(PtFtViewLayerBar*)bar;
- (void)addArtisticBar:(PtFtViewLayerBar*)bar;
- (void)addColorBar:(PtFtViewLayerBar*)bar;

@end
