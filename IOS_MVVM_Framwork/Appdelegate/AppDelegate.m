//
//  AppDelegate.m
//  IOS_MVVM_Framwork
//
//  Created by Experimental Computer on 2018/6/6.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import "AppDelegate.h"
#import "DHGuidePageHUD.h"
#import "DHLaunchAdPageHUD.h"
#import "LXDTabBarController.h"
#import "LXDNavigationController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    LXDTabBarController *tab = [[LXDTabBarController alloc]init];
    self.window.rootViewController = tab;
    
    // 引导页
    //    NSArray *imgArry = @[@"intro_0", @"intro_1", @"intro_2", @"intro_3"];
    //    DHGuidePageHUD *guidPage = [[DHGuidePageHUD alloc]dh_initWithFrame:self.window.frame imageNameArray:imgArry buttonIsHidden:NO];
    //    [self.window addSubview:guidPage];
    
    // 广告页
    NSString *adImageGifPath = [[NSBundle mainBundle] pathForResource:@"LaunchADPageBundle.bundle/intro_4" ofType:@"gif"];
    DHLaunchAdPageHUD *launchAd = [[DHLaunchAdPageHUD alloc]initWithFrame:self.window.frame aDduration:5.0 aDImageUrl:adImageGifPath hideSkipButton:NO launchAdClickBlock:^{
        // 广告跳转
    }];
    [self.window addSubview:launchAd];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
