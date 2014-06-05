//
//  LmCmViewCropList.m
//  Lumina
//
//  Created by SSC on 2014/05/25.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "LmCmViewCropList.h"

@implementation LmCmViewCropList

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        LmCmButtonCropListItem* button;
        float itemWidth = frame.size.width / 2.0f;
        float itemHeight = 44.0f;
        CGRect buttonFrame = CGRectMake(0.0f, 0.0f, itemWidth, itemHeight);
        
        //// Grid
        button = [[LmCmButtonCropListItem alloc] initWithFrame:buttonFrame];
        button.cropSize = LmCmViewCropSizeNormal;
        [button setX:0.0f];
        [button setY:0.0f];
        [button addTarget:self action:@selector(didSelectSize:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        //// Zoom
        button = [[LmCmButtonCropListItem alloc] initWithFrame:buttonFrame];
        button.cropSize = LmCmViewCropSizeSquare;
        [button setX:itemWidth];
        [button setY:0.0f];
        [button addTarget:self action:@selector(didSelectSize:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        //// Volume Snap
        button = [[LmCmButtonCropListItem alloc] initWithFrame:buttonFrame];
        button.cropSize = LmCmViewCropSize16x9;
        [button setX:0.0f];
        [button setY:itemHeight];
        [button addTarget:self action:@selector(didSelectSize:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        //// Volume Snap
        button = [[LmCmButtonCropListItem alloc] initWithFrame:buttonFrame];
        button.cropSize = LmCmViewCropSize2x1;
        [button setX:itemWidth];
        [button setY:itemHeight];
        [button addTarget:self action:@selector(didSelectSize:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        [self clearAllButtonSelection];
    }
    return self;
}

- (void)clearAllButtonSelection
{
    for (UIView* button in [self subviews]) {
        if ([button isKindOfClass:[LmCmButtonCropListItem class]]) {
            ((LmCmButtonCropListItem*)button).active = NO;
        }
    }
}

- (void)setCurrentSize:(LmCmViewCropSize)currentSize
{
    [self clearAllButtonSelection];
    _currentSize = currentSize;
    LmCmButtonCropListItem* button = [self viewWithTag:currentSize];
    if (button) {
        button.active = YES;
    }
}

- (void)didSelectSize:(LmCmButtonCropListItem *)item
{
    [self clearAllButtonSelection];
    item.active = YES;
    [self.delegate cropSizeSelected:item.cropSize];
}

- (void)drawRect:(CGRect)rect
{
    //// Color Declarations
    UIColor* color = [LmCmSharedCamera settingsBgColor];
    
    //// Rounded Rectangle Drawing
    UIBezierPath* roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect: rect byRoundingCorners: UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii: CGSizeMake(3, 3)];
    [roundedRectanglePath closePath];
    [color setFill];
    [roundedRectanglePath fill];
}


@end
