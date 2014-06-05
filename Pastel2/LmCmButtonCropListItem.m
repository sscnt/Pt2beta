//
//  LmCmButtonCropListItem.m
//  Lumina
//
//  Created by SSC on 2014/05/25.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "LmCmButtonCropListItem.h"

@implementation LmCmButtonCropListItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        float padding = 40.0f;
        self.backgroundColor = [UIColor clearColor];
        _label = [[VnViewLabel alloc] initWithFrame:CGRectMake(padding, 0.0f, frame.size.width - padding, frame.size.height)];
        _label.fontSize = 17.0f;
        _label.textAlignment = NSTextAlignmentLeft;
        _label.minimumScaleFactor = 0.10f;
        [self addSubview:_label];
        
        if ([UIDevice isCurrentLanguageJapanese]) {
            if ([UIDevice isIOS6]) {
                [_label setY:2.0f];
            }else{
                [_label setY:1.0f];
            }
        }else{
            if ([UIDevice isIOS6]) {
                
            }else{
                [_label setY:-0.50f];
            }
        }
    }
    return self;
}

- (void)setActive:(BOOL)active
{
    _active = active;
    if (active) {
        self.alpha = 1.0f;
    }else{
        self.alpha = 0.30f;
    }
}

- (void)setCropSize:(LmCmViewCropSize)cropSize
{
    _cropSize = cropSize;
    self.tag = cropSize;
    switch (cropSize) {
        case LmCmViewCropSizeNormal:
            _label.text = NSLocalizedString(@"Original", nil);
            break;
        case LmCmViewCropSizeSquare:
            _label.text = NSLocalizedString(@"Square", nil);
            break;
        case LmCmViewCropSize16x9:
            _label.text = NSLocalizedString(@"16:9", nil);
            break;
        case LmCmViewCropSize2x1:
            _label.text = NSLocalizedString(@"2:1", nil);
            break;            
        default:
            break;
    }
}


- (void)drawRect:(CGRect)rect
{
    //// Color Declarations
    UIColor* color = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
    
    switch (_cropSize) {
        case LmCmViewCropSizeNormal:
        {
            //// cropNormal Drawing
            UIBezierPath* cropNormalPath = [UIBezierPath bezierPathWithRect: CGRectMake(15, 17, 15, 11.5)];
            [color setStroke];
            cropNormalPath.lineWidth = 2;
            [cropNormalPath stroke];
        }
            break;
        case LmCmViewCropSizeSquare:
        {
            //// square Drawing
            UIBezierPath* squarePath = [UIBezierPath bezierPathWithRect: CGRectMake(15, 15, 15, 15)];
            [color setStroke];
            squarePath.lineWidth = 2;
            [squarePath stroke];
        }
            break;
        case LmCmViewCropSize16x9:
        {
            //// crop16x9 Drawing
            UIBezierPath* crop16x9Path = [UIBezierPath bezierPathWithRect: CGRectMake(15, 18.5, 15, 8.5)];
            [color setStroke];
            crop16x9Path.lineWidth = 2;
            [crop16x9Path stroke];
        }
            break;
        case LmCmViewCropSize2x1:
        {
            //// crop2x` Drawing
            UIBezierPath* crop2xPath = [UIBezierPath bezierPathWithRect: CGRectMake(15, 19, 15, 7.5)];
            [color setStroke];
            crop2xPath.lineWidth = 2;
            [crop2xPath stroke];
        }
            break;
        default:
            break;
    }
}

@end
