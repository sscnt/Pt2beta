//
//  PtFtButtonNavigation.h
//  Pastel2
//
//  Created by SSC on 2014/06/01.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, PtFtButtonNavigationType){
    PtFtButtonNavigationTypeCancel = 1,
    PtFtButtonNavigationTypeDone
};

@interface PtFtButtonNavigation : UIButton

@property (nonatomic, assign) PtFtButtonNavigationType type;

@end
