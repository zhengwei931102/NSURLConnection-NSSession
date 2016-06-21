//
//  AppDelegate.m
//  get同步，get异步，post异步，身份证get异步
//
//  Created by stu074 on 16/3/23.
//  Copyright © 2016年 stu074. All rights reserved.
//

#import "AppDelegate.h"
#import "VC1.h"
#import "VC2.h"
#import "VC3.h"
#import "VC4.h"
#import "VC5.h"
#import "VC6.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    [self tab];
    return YES;
}
- (void)tab{
    UITabBarController *tbc = [[UITabBarController alloc]init];
    
    VC1 *v1 = [VC1 new];
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:v1];
    nc.title = @"get同步";
    UIImage *img1 = [UIImage imageNamed:@"tab1"];
    nc.tabBarItem.image = img1;
    VC2 *v2 = [VC2 new];
    v2.title = @"get异步";
    VC3 *v3 = [VC3 new];
    v3.title = @"post异步";
    VC4 *v4 = [VC4 new];
    v4.title = @"身份证get异";
    VC5 *v5 = [VC5 new];
    v5.title = @"session";
    VC6 *v6 = [VC6 new];
    v6.title = @"session代理";
    
   
    
    NSArray *arr =@[nc,v2,v3,v4,v5,v6];
    tbc.viewControllers = arr;
    tbc.selectedIndex = 0;
//    [tbc.tabBar setTintColor:[UIColor greenColor]];
//    [tbc.tabBar setBarTintColor:[UIColor orangeColor]];
    self.window.rootViewController = tbc;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
