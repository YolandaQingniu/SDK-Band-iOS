//
//  AppDelegate.m
//  QNBandSDKDemo
//
//  Created by donyau on 2019/7/26.
//  Copyright © 2019 Yolanda. All rights reserved.
//

#import "AppDelegate.h"
#import "QNDeviceSDK.h"
#import "ScanVC.h"
#import "SetListVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    NSString *bindMac = [[NSUserDefaults standardUserDefaults] objectForKey:QNBandBindMac];
    UINavigationController *nav = nil;
    if (bindMac == nil) {
        nav = [[UINavigationController alloc] initWithRootViewController:[[ScanVC alloc] init]];
    }else {
        nav = [[UINavigationController alloc] initWithRootViewController:[[SetListVC alloc] init]];
    }
    
    self.window.rootViewController = nav;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    QNConfig *config = [[QNBleApi sharedBleApi] getConfig];
    config.showPowerAlertKey = YES;

    QNBleApi.debug = YES;
    NSString *file = [[NSBundle mainBundle] pathForResource:@"123456789" ofType:@"qn"];
    [[QNBleApi sharedBleApi] initSdk:@"123456789" firstDataFile:file callback:^(NSError *error) {

    }];
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
