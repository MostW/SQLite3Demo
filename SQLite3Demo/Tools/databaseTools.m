//
//  databaseTools.m
//  SQLite3Demo
//
//  Created by 巫永健 on 2018/1/24.
//  Copyright © 2018年 wu. All rights reserved.
//

#import "databaseTools.h"
#import <sqlite3.h>

@interface databaseTools() {
    
}
@end

static databaseTools *DBT = nil;

@implementation databaseTools

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DBT = [[self alloc] init];
    });
    return DBT;
}

- (NSString *)path {
    //创建数据库路径
    NSArray *document = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [document firstObject];
    NSString *path = [NSString stringWithFormat:@"%@/user.db", documentPath];
//    NSLog(@"%@",path);
    return path;
    
}

- (void)createDatabase {
    
    //打开/创建数据库
    sqlite3 *database;
    int databaseResult = sqlite3_open([[self path] UTF8String], &database);
    if (databaseResult == SQLITE_OK) {
        const char *createTable = "create table if not exists accounts(id integer primary key autoincrement,phoneNo char,pw char)";
        int tableResult = sqlite3_exec(database, createTable, NULL, NULL, NULL);
        if (tableResult == SQLITE_OK) {
            NSLog(@"建表成功");
        }
    }
    sqlite3_close(database);
}

- (void)updateWithPnoneNo:(NSString *)phoneNO andPWd:(NSString *)pwd {
    
    //打开/创建数据库
    sqlite3 *database;
    int databaseResult = sqlite3_open([[self path] UTF8String], &database);
    if (databaseResult == SQLITE_OK) {
            const char *insertStr = "insert into accounts(phoneNo,pw) values(?,?)";
            sqlite3_stmt *stmt;
            int insertResult = sqlite3_prepare_v2(database, insertStr, -1, &stmt, nil);
            sqlite3_bind_text(stmt, 1, [phoneNO UTF8String], -1, NULL);
            sqlite3_bind_text(stmt, 2, [pwd UTF8String], -1, NULL);
            if (insertResult == SQLITE_OK) {
                int result=sqlite3_step(stmt);
                NSLog(@"修改成功");
            }
    }
    sqlite3_close(database);
}

- (void)searchWithPhoneNO:(NSString *)phoneNO {
    //打开/创建数据库
    sqlite3 *database;
    int databaseResult = sqlite3_open([[self path] UTF8String], &database);
    if (databaseResult == SQLITE_OK) {
        const char *searchStr = "select * from accounts where phoneNo = ?";
        sqlite3_stmt *stmt;
        int searchResult = sqlite3_prepare_v2(database, searchStr, -1, &stmt, nil);
        sqlite3_bind_text(stmt, 1, [phoneNO UTF8String], -1, NULL);
        if (searchResult == SQLITE_OK) {
            while (sqlite3_step(stmt) == SQLITE_ROW) {
                // 查询的结果可能不止一条,直到 sqlite3_step(stmt) != SQLITE_ROW,查询结束。
                int orderID = sqlite3_column_int(stmt, 0);
                char *phoneStr = (char *) sqlite3_column_text(stmt, 1);
                char *passWord = (char *)sqlite3_column_text(stmt, 2);
                NSLog(@"id: %d, 手机号码: %s, 密码: %s",orderID,phoneStr,passWord);
            }
        }
    }
    sqlite3_close(database);
}

@end
