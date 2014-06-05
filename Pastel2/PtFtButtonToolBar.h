//
//  VnViewEditorToolBarButton.h
//  Pastel
//
//  Created by SSC on 2014/05/10.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, PtFtViewToolBarButtonType){
    PtFtViewToolBarButtonTypeShuffle = 1,
    PtFtViewToolBarButtonTypeSlider,
    PtFtViewToolBarButtonTypeFavorites,
    PtFtViewToolBarButtonTypeAddToFavorites
};

@class PtFtButtonToolBar;

@protocol VnViewEditorToolBarButtonDelegate
- (void)didToolBarButtonTouchUpInside:(PtFtButtonToolBar*)button;
@end

@interface PtFtButtonToolBar : UIButton

@property (nonatomic, weak) id<VnViewEditorToolBarButtonDelegate> delegate;
@property (nonatomic, assign) PtFtViewToolBarButtonType type;

- (void)didTouchUpInside:(PtFtButtonToolBar*)sender;

@end
