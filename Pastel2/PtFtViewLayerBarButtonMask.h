//
//  VnViewEditorLayerBarButtonMaskView.h
//  Pastel
//
//  Created by SSC on 2014/05/01.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, VnViewEditorLayerBarButtonMaskSelectionType){
    VnViewEditorLayerBarButtonMaskSelectionTypeColor = 1,
    VnViewEditorLayerBarButtonMaskSelectionTypePhoto
};

@interface PtFtViewLayerBarButtonMask : UIView

@property (nonatomic, strong) UIColor* maskColor;
@property (nonatomic, strong) UIColor* selectionColor;
@property (nonatomic, assign) float radius;
@property (nonatomic, assign) BOOL selected;

@end
