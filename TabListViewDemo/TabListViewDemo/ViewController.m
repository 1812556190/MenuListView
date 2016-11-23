//
//  ViewController.m
//  TabListViewDemo
//
//  Created by apple on 16/11/16.
//  Copyright © 2016年 Lingser. All rights reserved.
//

#import "ViewController.h"

#import "MenuListView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *titArray = @[@"图片",@"歌曲",@"视频",@"动漫",@"动画GG",@"电影",@"音乐MP3"];
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger i = 0; i< titArray.count; i++) {
        UILabel *lable = [[UILabel alloc] init];
        lable.font = [UIFont systemFontOfSize:30];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.backgroundColor = [UIColor lightGrayColor];
        lable.textColor = [UIColor blueColor];
        lable.text = titArray[i];
        [array addObject:lable];
    }
   
    MenuListView *listView = [[MenuListView alloc] initWithListViewY:20 listViewScreeningType:TablistViewScreeningNone tabListTitle:titArray tabListMainView:array];
    
    [self.view addSubview:listView];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
