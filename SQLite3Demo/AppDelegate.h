//
//  AppDelegate.h
//  SQLite3Demo
//
//  Created by 巫永健 on 2018/1/24.
//  Copyright © 2018年 wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

