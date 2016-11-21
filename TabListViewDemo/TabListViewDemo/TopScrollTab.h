//
//  TopScrollTab.h
//  TabListViewDemo
//
//  Created by apple on 2016/11/21.
//  Copyright © 2016年 Lingser. All rights reserved.
//  顶部滑动菜单

#import <UIKit/UIKit.h>
#import "MenuList.h"


@protocol TopScrollTabDelegate <NSObject>

@optional

//点击按钮时调用
-(void)selectTopMenu:(NSInteger)tagId;

@end

@interface TopScrollTab : UIScrollView<UIScrollViewDelegate>


@property (nonatomic, strong) NSArray *topTitles;//标题数组


@property (nonatomic, weak) id<TopScrollTabDelegate> topDelegate;


//初始化方法
- (instancetype)initWithFrame:(CGRect)frame topDelegate:(id<TopScrollTabDelegate>)topdelegate;

//改变选中按钮
-(void)setScrollPage:(NSInteger)page;


@end
