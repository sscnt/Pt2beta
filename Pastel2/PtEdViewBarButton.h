//
//  PtViewBarButton.h
//  Pastel2
//
//  Created by SSC on 2014/05/30.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, PtEdViewBarButtonType){
    PtEdViewBarButtonTypeSaveToCameraRoll = 1,
    PtEdViewBarButtonTypeInstagram,
    PtEdViewBarButtonTypeTwitter,
    PtEdViewBarButtonTypeFacebook,
    PtEdViewBarButtonTypeOther,
    PtEdViewBarButtonTypeBackToCamera,
    PtEdViewBarButtonTypeFilters,
    PtEdViewBarButtonTypeSliders
};

@interface PtEdViewBarButton : UIButton

@property (nonatomic, assign) PtEdViewBarButtonType type;
@property (nonatomic, assign) BOOL active;

- (id)initWithType:(PtEdViewBarButtonType)type;

@end
