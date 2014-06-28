//
//  PtFtViewSliderWrapper.h
//  Pastel2
//
//  Created by SSC on 2014/06/28.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PtFtViewLayerBarButton.h"

@interface PtFtViewSliderWrapper : UIView

@property (nonatomic, strong) PtFtViewLayerBarButton* colorButton;
@property (nonatomic, strong) PtFtViewLayerBarButton* artisticButton;
@property (nonatomic, strong) PtFtViewLayerBarButton* overlayButton;

- (void)removeAllButtons;
- (void)addColorFilterButton:(PtFtViewLayerBarButton*)button;
- (void)addArtisticFilterButton:(PtFtViewLayerBarButton*)button;
- (void)addOverlayFilterButton:(PtFtViewLayerBarButton*)button;

@end
