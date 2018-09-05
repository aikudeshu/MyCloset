//
//  AppDelegate.h
//  MyCloset
//
//  Created by sunning on 14-11-2.
//  Copyright (c) 2014年 ___NinaS Corp__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabViewAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property NSMutableArray *Type0;    // 外套
@property NSMutableArray *Type1;    // 上衣
@property NSMutableArray *Type2;    // 裤装
@property NSMutableArray *Type3;    // 裙装
@property NSMutableArray *Type4;    // 鞋
@property NSMutableArray *Type5;    // 饰物
@property NSMutableArray *Types;
@property NSString *filePath;       // documents文件夹路径
@property NSMutableArray *todayImages;


@end
