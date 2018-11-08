//
//  LXDNavigationController.m
//  LXDHRMS
//
//  Created by Experimental Computer on 2017/11/8.
//  Copyright © 2017年 Luxondata. All rights reserved.
//

#import "LXDNavigationController.h"
//#import "UIViewController+MMDrawerController.h"

@interface LXDNavigationController ()

@end

@implementation LXDNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) { // 如果现在push的不是栈底控制器(最先push进来的那个控制器)
        viewController.hidesBottomBarWhenPushed = YES;  //隐藏tabbar
    }
    [super pushViewController:viewController animated:YES];
}
@end
