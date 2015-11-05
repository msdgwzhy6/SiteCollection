//
//  AppDelegate.m
//  SiteCollection
//
//  Created by WangZhengHong on 15/10/13.
//  Copyright © 2015年 WangZhengHong. All rights reserved.
//

#import "AppDelegate.h"
#import  "RootViewController.h"
#import "PersonViewController.h"
#import "SetViewController.h"
#import "AboutViewController.h"
#import "SharedDataBaseManager.h"
#import "WebViewController.h"

@interface AppDelegate ()
{
    NSString * HomeUrl;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    RootViewController * rootVc = [[RootViewController alloc]init];
    UIImage * NewsImage1= [UIImage imageNamed:@"rd@2x"];
    UIImage * NewsImage2= [UIImage imageNamed:@"rd@2x"];
    rootVc.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"热门" image:NewsImage1 selectedImage:NewsImage2];
    UINavigationController * rootNc =[[UINavigationController alloc]initWithRootViewController:rootVc];
    
    
    
    PersonViewController * personVc =[[PersonViewController alloc]init];
    NewsImage1= [UIImage imageNamed:@"sc@2x"];
    NewsImage2= [UIImage imageNamed:@"sc@2x"];
    personVc.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"收藏" image:NewsImage1 selectedImage:NewsImage2];
    UINavigationController * personNc=[[UINavigationController alloc]initWithRootViewController:personVc];
    
    
    SetViewController * setVc =[[SetViewController alloc]init];
    NewsImage1= [UIImage imageNamed:@"sz@2x"];
    NewsImage2= [UIImage imageNamed:@"sz@2x"];
    setVc.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"设置" image:NewsImage1 selectedImage:NewsImage2];
    UINavigationController * setNc=[[UINavigationController alloc]initWithRootViewController:setVc];
    
//    AboutViewController *aboutVc= [[AboutViewController alloc]init];
    
//    NewsImage1= [UIImage imageNamed:@"gd@2x"];
//    NewsImage2= [UIImage imageNamed:@"gd@2x"];
//    aboutVc.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"关于" image:NewsImage1 selectedImage:NewsImage2];
//    UINavigationController * aboutNc=[[UINavigationController alloc]initWithRootViewController:aboutVc];
    
    
    UITabBarController *rootBarControll=[[UITabBarController alloc]init];
    rootBarControll.viewControllers=[NSArray arrayWithObjects:rootNc,personNc,setNc, nil];
    
    self.window.rootViewController=rootBarControll;
    rootBarControll.delegate=self;
    
    
    
    FMDatabase *db=[[SharedDataBaseManager sharedManager] returnShareDb];
    
    NSString *sql=@"SELECT * FROM URL ORDER BY HITS DESC";
    
    
    FMResultSet *rs=[db executeQuery:sql];
    while ([rs next]){
        //NSLog(@"%@ %@",[rs stringForColumn:@"url"],[rs stringForColumn:@"url_txt"]);
        
       HomeUrl=[rs stringForColumn:@"url"];
        
        
        break;
        
    }

    
    //获取当前应用程序对象
   // UIApplication *app = [UIApplication sharedApplication];
    //获取一个应用程序对象的shortcutItem列表
   // id existingShortcutItems = [app shortcutItems];
    
    
    //获取第0个shortcutItem
   // id oldItem = [existingShortcutItems objectAtIndex: 0];
    //将旧的shortcutItem改变为可修改类型shortcutItem
   // id mutableItem = [oldItem mutableCopy];
    //修改shortcutItem的显示标题
   // [mutableItem setLocalizedTitle: @"Click Lewis"];
    
    //根据旧的shortcutItems生成可变shortcutItems数组
   // id updatedShortcutItems = [existingShortcutItems mutableCopy];
    //修改可变shortcutItems数组中对应index下的元素为新的shortcutItem
   // [updatedShortcutItems replaceObjectAtIndex: 0 withObject: mutableItem];
    //修改应用程序对象的shortcutItems为新的数组
   // [app setShortcutItems: updatedShortcutItems];

    
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
}

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem
  completionHandler:(void(^)(BOOL succeeded))completionHandler{
    //判断先前我们设置的唯一标识
    if([shortcutItem.type isEqualToString:@"UITouchText.home"]){
        
        
        WebViewController * vc =[[WebViewController alloc]init];
        [vc showViewUrlValue:HomeUrl];
        [vc AddBtnOfReturn];
        UINavigationController * webNC =  [[UINavigationController alloc]initWithRootViewController:vc];
        [self.window.rootViewController presentViewController:webNC animated:YES completion:^{}];
    }
    else if ([shortcutItem.type isEqualToString:@"UITouchText.search"])
    {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"好想你" delegate:nil cancelButtonTitle:@"cancle" otherButtonTitles:@"sure", nil];
        [alertView show];
    }
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
    
   // [[SharedDataBaseManager sharedManager] closeDB];
    
    
}

@end
