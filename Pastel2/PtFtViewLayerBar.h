//
//  VnVIewEditorToolBar.h
//  Vintage 2.0
//
//  Created by SSC on 2014/04/21.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PtFtViewLayerBarButton.h"
#import "PtFtViewToolBarButton.h"

@interface PtFtViewLayerBar : UIView
{
    float _left;
    float _right;
}
@property (nonatomic, strong) UIScrollView* view;
@property (nonatomic, weak) PtFtViewLayerBarButton* currentOpeningButton;
@property (nonatomic, assign) BOOL locked;

- (void)appendLayerButton:(PtFtViewLayerBarButton*)button;

- (void)scrollToLayerButton:(PtFtViewLayerBarButton*)button;
- (void)deallocAllButtons;

@end
