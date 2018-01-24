//
//  databaseTools.h
//  SQLite3Demo
//
//  Created by 巫永健 on 2018/1/24.
//  Copyright © 2018年 wu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface databaseTools : NSObject

+ (instancetype)shareInstance;
- (void)createDatabase;
- (void)updateWithPnoneNo: (NSString *)phoneNO andPWd: (NSString *)pwd;
- (void)searchWithPhoneNO: (NSString *)phoneNO;

@end
