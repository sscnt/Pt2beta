//
//  PtEdViewControllerAdjustmentBrightness.m
//  Pastel2
//
//  Created by SSC on 2014/06/21.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "PtEdViewControllerAdjustmentBrightness.h"

@interface PtEdViewControllerAdjustmentBrightness ()

@end

@implementation PtEdViewControllerAdjustmentBrightness

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationBar.title = NSLocalizedString(@"Brightness", nil);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
