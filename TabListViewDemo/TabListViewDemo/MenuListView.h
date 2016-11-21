//
//  MenuListView.h
//  TabListViewDemo
//
//  Created by apple on 2016/11/21.
//  Copyright © 2016年 Lingser. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, TabListViewScreeningType){
    TablistViewScreeningNone = 0, //没有筛选栏
    TablistViewScreening
};


@interface MenuListView : UIView


/**
 所有的子视图
 */
@property (nonatomic, strong)NSArray <UIView *>*listViewes;
/**
 所有的标题
 */
@property (nonatomic, strong) NSArray *tabListTitles;



- (instancetype)initWithViewY:(CGFloat)viewY listViewScreeningType:(TabListViewScreeningType)screeningType;

- (instancetype)initWithListViewY:(CGFloat)viewY listViewScreeningType:(TabListViewScreeningType)screeningType tabListTitle:(NSArray *)titles tabListMainView:(NSArray <UIView *>*)listViews;


@end
