//
//  LmViewCameraPreview.h
//  Lumina
//
//  Created by SSC on 2014/05/22.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LmCmViewPreviewOverlay : UIView
{
    UIView* _flashView;
}

@property (nonatomic, assign) BOOL showGrid;

- (void)flash;

@end
