//
//  ShareOtherAppViewController.h
//  Pastel
//
//  Created by SSC on 2014/05/13.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareOtherAppViewController : UIViewController <UIDocumentInteractionControllerDelegate>

@property (nonatomic,strong) UIDocumentInteractionController *interactionController;

@end
