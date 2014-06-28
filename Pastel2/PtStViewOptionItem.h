//
//  PtStViewOptionItem.h
//  Pastel2
//
//  Created by SSC on 2014/06/27.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PtStViewSwitch.h"
#import "VnViewLabel.h"

@interface PtStViewOptionItem : UIView
{
    VnViewLabel* _label;
}

- (void)setTitle:(NSString*)title;
- (void)addSwitch:(PtStViewSwitch*)sw;

@end
