//
//  AppDelegate.m
//  MyCloset
//
//  Created by sunning on 14-11-2.
//  Copyright (c) 2014年 ___NinaS Corp__. All rights reserved.
//

#import "TabViewAppDelegate.h"

#import "MyClosetItemsManager.h"
#import "MyClosetItemsNav.h"
#import "MyClosetItemsView.h"
#import "MyClosetTab.h"

@implementation TabViewAppDelegate
@synthesize Type0;
@synthesize Type1;
@synthesize Type2;
@synthesize Type3;
@synthesize Type4;
@synthesize Type5;
@synthesize Types;
@synthesize filePath;
@synthesize todayImages;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    //insert by sunn
    //NSString *imageToLoad = @"ji";
    //MyClosetTab * myClosetTab = (MyClosetTab *)self.window.rootViewController;
    //MyClosetItemsNav *myClosetItemsNav = [[myClosetTab viewControllers]objectAtIndex:0];
    //MyClosetItemsView *myClosetItemsView = [[myClosetItemsNav viewControllers]objectAtIndex:0];
    /*_Type0 = [[NSMutableArray alloc] initWithObjects:
                            @"0.jpg",
                            @"1.jpg",
                            @"2.jpg",nil];
    _Type1 = [[NSMutableArray alloc] initWithObjects:
              @"0.jpg",
              @"1.jpg",
              @"2.jpg",nil];
    
    _Type2 = [[NSMutableArray alloc] initWithObjects:
              @"0.jpg",
              @"1.jpg",
              @"2.jpg",nil];*/
    
    filePath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingFormat:@"/"];
    NSString *fileName,*fullPath;
    
    for (int i=0; i<6; i++) {
        fileName = [[NSString alloc] initWithFormat:@"Type%d.xml",i];
        fullPath = [filePath stringByAppendingString:fileName];
        if ([[NSFileManager defaultManager] fileExistsAtPath:fullPath]) {
            switch (i) {
                case 0:
                    Type0 = [NSMutableArray arrayWithContentsOfFile:fullPath];
                    break;
                case 1:
                    Type1 = [NSMutableArray arrayWithContentsOfFile:fullPath];
                    break;
                case 2:
                    Type2 = [NSMutableArray arrayWithContentsOfFile:fullPath];
                    break;
                case 3:
                    Type3 = [NSMutableArray arrayWithContentsOfFile:fullPath];
                    break;
                case 4:
                    Type4 = [NSMutableArray arrayWithContentsOfFile:fullPath];
                    break;
                case 5:
                    Type5 = [NSMutableArray arrayWithContentsOfFile:fullPath];
                    break;
                default:
                    break;
            }
        }
        else {
            switch (i) {
                case 0:
                    Type0 = [NSMutableArray arrayWithCapacity:10];
                    break;
                case 1:
                    Type1 = [NSMutableArray arrayWithCapacity:10];
                    break;
                case 2:
                    Type2 = [NSMutableArray arrayWithCapacity:10];
                    break;
                case 3:
                    Type3 = [NSMutableArray arrayWithCapacity:10];
                    break;
                case 4:
                    Type4 = [NSMutableArray arrayWithCapacity:10];
                    break;
                case 5:
                    Type5 = [NSMutableArray arrayWithCapacity:10];
                    break;
                default:
                    break;
            }
        }
    }
    
    Types = [NSMutableArray arrayWithCapacity:6];
    
    for (int i=0; i<6; i++) {
        fileName = [[NSString alloc] initWithFormat:@"Type%d.xml",i];
        fullPath = [filePath stringByAppendingString:fileName];
        if ([[NSFileManager defaultManager] fileExistsAtPath:fullPath]) {
            [Types addObject: [NSMutableArray arrayWithContentsOfFile:fullPath]];
        }
        else {
            [Types addObject: [NSMutableArray arrayWithCapacity:10]];
        }
        NSLog(@"%d:%@",i,[Types objectAtIndex:i]);
    }
    
    todayImages = [NSMutableArray arrayWithCapacity:6];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
