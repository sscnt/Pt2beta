//
//  LmCmViewFlashModeList.m
//  Lumina
//
//  Created by SSC on 2014/05/25.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "LmCmViewFlashModeList.h"

@implementation LmCmViewFlashModeList

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        CGRect buttonFrame = CGRectMake(0.0f, 0.0f, frame.size.width, [LmCmSharedCamera topBarHeight]);
        
        //// On
        _onButton = [[LmCmButtonFlashModeItem alloc] initWithFrame:buttonFrame];
        _onButton.mode = LmCmViewBarButtonFlashModeOn;
        [_onButton addTarget:self action:@selector(didSelectMode:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_onButton];
        
        //// Off
        _offButton = [[LmCmButtonFlashModeItem alloc] initWithFrame:buttonFrame];
        _offButton.mode = LmCmViewBarButtonFlashModeOff;
        [_offButton addTarget:self action:@selector(didSelectMode:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_offButton];
        
        //// Auto
        _autoButton = [[LmCmButtonFlashModeItem alloc] initWithFrame:buttonFrame];
        _autoButton.mode = LmCmViewBarButtonFlashModeAuto;
        [_autoButton addTarget:self action:@selector(didSelectMode:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_autoButton];
    }
    return self;
}

- (void)setCurrentMode:(LmCmViewBarButtonFlashMode)currentMode
{
    _currentMode = currentMode;
    [self layoutButtons];
}

- (void)layoutButtons
{
    _onButton.hidden = NO;
    _offButton.hidden = NO;
    _autoButton.hidden = NO;
    switch (_currentMode) {
        case LmCmViewBarButtonFlashModeOff:
        {
            _offButton.hidden = YES;
            [_onButton setY:0.0f];
            [_autoButton setY:[_onButton height]];
        }
            break;
        case LmCmViewBarButtonFlashModeOn:
        {
            _onButton.hidden = YES;
            [_offButton setY:0.0f];
            [_autoButton setY:[_offButton height]];
        }
            break;
        case LmCmViewBarButtonFlashModeAuto:
        {
            _autoButton.hidden = YES;
            [_onButton setY:0.0f];
            [_offButton setY:[_onButton height]];
        }
            break;
            
        default:
            break;
    }
}

- (void)didSelectMode:(LmCmButtonFlashModeItem *)item
{
    self.currentMode = item.mode;
    [self.delegate flashModeDidSelect:_currentMode];
    
}

- (void)drawRect:(CGRect)rect
{
    //// Color Declarations
    UIColor* color = [LmCmSharedCamera settingsBgColor];
    
    //// Rounded Rectangle Drawing
    UIBezierPath* roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect: rect byRoundingCorners: UIRectCornerBottomRight | UIRectCornerBottomLeft cornerRadii: CGSizeMake(3, 3)];
    [roundedRectanglePath closePath];
    [color setFill];
    [roundedRectanglePath fill];
}

@end
