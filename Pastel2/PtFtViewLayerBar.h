//
//  VnVIewEditorToolBar.h
//  Vintage 2.0
//
//  Created by SSC on 2014/04/21.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PtFtButtonLayerBar.h"
#import "PtFtButtonToolBar.h"

@interface PtFtViewLayerBar : UIView
{
    float _left;
    float _right;
}
@property (nonatomic, strong) UIScrollView* view;
@property (nonatomic, weak) PtFtButtonLayerBar* currentOpeningButton;
@property (nonatomic, assign) BOOL locked;

- (void)appendLayerButton:(PtFtButtonLayerBar*)button;
- (void)appendToolButton:(PtFtButtonToolBar*)button;
- (void)appendToolButtonRight:(PtFtButtonToolBar*)button;

- (void)scrollToLayerButton:(PtFtButtonLayerBar*)button;
- (void)deallocAllButtons;

@end
