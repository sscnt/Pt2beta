//
//  PtFtViewToolBarButton.h
//  Pastel2
//
//  Created by SSC on 2014/06/25.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, PtFtViewToolBarButtonType){
    PtFtViewToolBarButtonTypeShuffle = 1,
    PtFtViewToolBarButtonTypeSlider,
    PtFtViewToolBarButtonTypeFavorites,
    PtFtViewToolBarButtonTypeAddToFavorites
};

@class PtFtViewToolBarButton;

@protocol PtFtViewToolBarButtonDelegate
- (void)didToolBarButtonTouchUpInside:(PtFtViewToolBarButton*)button;
@end

@interface PtFtViewToolBarButton : UIButton

@property (nonatomic, weak) id<PtFtViewToolBarButtonDelegate> delegate;
@property (nonatomic, assign) PtFtViewToolBarButtonType type;

- (void)didTouchUpInside:(PtFtViewToolBarButton*)sender;

@end
