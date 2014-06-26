//
//  PtStViewSwitch.h
//  Pastel2
//
//  Created by SSC on 2014/06/26.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VnViewLabel.h"

@interface PtStViewSwitch : UIView

@property (nonatomic, assign) BOOL on;
@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL selector;
@property (nonatomic, strong) VnViewLabel* label;

- (void)addTarget:(id)target selector:(SEL)selector;

@end
