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
//#import "FMDB.h"

@interface AppDelegate ()

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
    
    AboutViewController *aboutVc= [[AboutViewController alloc]init];
    
    NewsImage1= [UIImage imageNamed:@"gd@2x"];
    NewsImage2= [UIImage imageNamed:@"gd@2x"];
    aboutVc.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"关于" image:NewsImage1 selectedImage:NewsImage2];
    UINavigationController * aboutNc=[[UINavigationController alloc]initWithRootViewController:aboutVc];
    
    
    UITabBarController *rootBarControll=[[UITabBarController alloc]init];
    rootBarControll.viewControllers=[NSArray arrayWithObjects:rootNc,personNc,setNc,aboutNc, nil];
    
    self.window.rootViewController=rootBarControll;
    rootBarControll.delegate=self;
//    
//    FMDatabase *db=[[SharedDataBaseManager sharedManager] returnShareDb];
//    
//    
//    NSString *sql=@"SELECT * FROM URL";
//    
//        sql=@"SELECT * FROM URL ORDER BY HITS DESC";
//  
//    
//    FMResultSet *rs=[db executeQuery:sql];
//    while ([rs next]){
//        NSLog(@"%@ %@ hits =%d  ID = %@",[rs stringForColumn:@"url"],[rs stringForColumn:@"url_txt"],[rs intForColumn:@"hits"],[rs stringForColumn:@"ID"]);
//        
//        
//        
//        
//    }
    
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
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
