//
//  PtViewImagePreview.h
//  Pastel2
//
//  Created by SSC on 2014/05/31.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PtEdViewImagePreviewScrollView.h"

@interface PtEdViewImagePreview : UIView <UIScrollViewDelegate>

@property (nonatomic, strong) PtEdViewImagePreviewScrollView* scrollView;
@property (nonatomic, weak) UIImage* image;
@property (nonatomic, strong) UIImageView* imageView;

@end
