//
//  AppDelegate.h
//  Pastel2
//
//  Created by SSC on 2014/06/06.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PtViewControllerRoot.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, weak) PtViewControllerRoot* rootViewController;

@end
