//
//  MenuList.h
//  TabListViewDemo
//
//  Created by apple on 2016/11/21.
//  Copyright © 2016年 Lingser. All rights reserved.
//  所有的宏

#ifndef MenuList_h
#define MenuList_h

/* 位置大小参数 */
#define kIntroMarginW 0 //两个按钮之间的间距
#define kViewCenterX self.center.x
#define kDefaultEdgeInsets UIEdgeInsetsMake(6, 12, 6, 12)
#define TopLineMargan 10 //线条与按钮之间的间距
#define TopFont 18     //顶部菜单文字的大小
#define MenuListScreening 40 //筛选视图的高度
#define MenuListTopHeight 40 //顶部菜单的高度
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

/* 所有视图的颜色  */
#define TopLineColor [UIColor orangeColor]
#define TopBarTitNormalColor [UIColor blackColor]
#define TopBarTitSelectColor [UIColor orangeColor]
#define TopScrollBackColor [UIColor whiteColor]

#endif /* MenuList_h */
