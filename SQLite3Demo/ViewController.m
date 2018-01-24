//
//  ViewController.m
//  SQLite3Demo
//
//  Created by 巫永健 on 2018/1/24.
//  Copyright © 2018年 wu. All rights reserved.
//

#import "ViewController.h"
#import "databaseTools.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[databaseTools shareInstance] createDatabase];
    
    [[databaseTools shareInstance] updateWithPnoneNo:@"123" andPWd:@"456"];
    [[databaseTools shareInstance] updateWithPnoneNo:@"124" andPWd:@"aaa"];
    [[databaseTools shareInstance] updateWithPnoneNo:@"125" andPWd:@"acd"];
    
    [[databaseTools shareInstance] searchWithPhoneNO:@"123"];
    [[databaseTools shareInstance] searchWithPhoneNO:@"124"];
    [[databaseTools shareInstance] searchWithPhoneNO:@"125"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
