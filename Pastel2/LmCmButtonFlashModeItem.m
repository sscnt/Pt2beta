//
//  LmCmButtonFlashModeItem.m
//  Lumina
//
//  Created by SSC on 2014/05/26.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "LmCmButtonFlashModeItem.h"

@implementation LmCmButtonFlashModeItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _label = [[VnViewLabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height)];
        _label.fontSize = 17.0f;
        _label.textAlignment = NSTextAlignmentCenter;
        _label.minimumScaleFactor = 0.10f;
        [self addSubview:_label];
    }
    return self;
}

- (void)setMode:(LmCmViewBarButtonFlashMode)mode
{
    _mode = mode;
    switch (mode) {
        case LmCmViewBarButtonFlashModeOn:
            _label.text = NSLocalizedString(@"On", nil);
            break;
        case LmCmViewBarButtonFlashModeOff:
            _label.text = NSLocalizedString(@"Off", nil);
            break;
        case LmCmViewBarButtonFlashModeAuto:
            _label.text = NSLocalizedString(@"Auto", nil);
            break;            
        default:
            break;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
