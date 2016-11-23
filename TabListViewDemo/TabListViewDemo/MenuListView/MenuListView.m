//
//  MenuListView.m
//  TabListViewDemo
//
//  Created by apple on 2016/11/21.
//  Copyright © 2016年 Lingser. All rights reserved.
//

#import "MenuListView.h"
#import "TopScrollTab.h"
#import "MenuList.h"

@interface MenuListView ()<TopScrollTabDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>{
    NSInteger _viewCount;
    CGFloat _itemH;
    TabListViewScreeningType _screenType;
}


@property (nonatomic, strong) UICollectionView *mainListView;
@property (nonatomic, strong) TopScrollTab *topScrollView;
@property (nonatomic, strong) UIView *screeningView;

@end
static NSString *listCellID = @"ListCell";
@implementation MenuListView

#pragma mark - 初始化方法
- (instancetype)initWithViewY:(CGFloat)viewY listViewScreeningType:(TabListViewScreeningType)screeningType{
    self = [self initWithFrame:CGRectMake(0, viewY, kScreenWidth,kScreenHeight - viewY)];
    
    return self;
}

- (instancetype)initWithListViewY:(CGFloat)viewY listViewScreeningType:(TabListViewScreeningType)screeningType tabListTitle:(NSArray *)titles tabListMainView:(NSArray <UIView *>*)listViews{
    self = [self initWithFrame:CGRectMake(0, viewY, kScreenWidth,kScreenHeight - viewY)];
    _screenType = screeningType;
    self.listViewes = listViews;
    self.tabListTitles = titles;
    return self;
}


//赋值开始调用
- (void)setTabListTitles:(NSArray *)tabListTitles{
    _tabListTitles = tabListTitles;
    
    [self addSubview:self.topScrollView];
    self.topScrollView.topTitles = self.tabListTitles;
    
}

- (void)setListViewes:(NSArray<UIView *> *)listViewes{
    _listViewes = listViewes;
    [self addSubview:self.mainListView];
    [self.mainListView reloadData];//刷新collectionView
}


#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.listViewes.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:listCellID forIndexPath:indexPath];
    UIView *view = self.listViewes[indexPath.row];
    view.frame = CGRectMake(0, 0, self.frame.size.width,self.frame.size.height - self.topScrollView.frame.size.height);
    [cell.contentView addSubview:view];
    cell.contentView.backgroundColor = [UIColor orangeColor];
    return cell;
}



#pragma mark - 懒加载视图

- (TopScrollTab *)topScrollView{
    if (!_topScrollView) {
        _topScrollView = [[TopScrollTab alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, MenuListTopHeight) topDelegate:self];
    }
    return _topScrollView;
}

//筛选视图
- (UIView *)screeningView{
    if (!_screeningView) {
        _screeningView = [[UIView alloc] initWithFrame:CGRectMake(0,self.topScrollView.frame.size.height,self.frame.size.width,MenuListScreening)];
        _screeningView.backgroundColor = [UIColor orangeColor];
    }
    return _screeningView;
}

- (UICollectionView *)mainListView{
    if (!_mainListView) {
        CGRect collectionViewFrame = CGRectMake(0,self.topScrollView.frame.size.height,self.frame.size.width,self.frame.size.height - self.topScrollView.frame.size.height);
        //判断是否有筛选视图
        if (_screenType == TablistViewScreeningNone) {
            
        }else{
            collectionViewFrame.origin.y = self.topScrollView.frame.size.height + MenuListScreening;
            collectionViewFrame.size.height = self.frame.size.height - self.topScrollView.frame.size.height - MenuListScreening;
            [self addSubview:self.screeningView];
        }
        
        UICollectionViewFlowLayout *flowLayou = [[UICollectionViewFlowLayout alloc] init];
        flowLayou.itemSize = CGSizeMake(collectionViewFrame.size.width,collectionViewFrame.size.height);
        flowLayou.scrollDirection = UICollectionViewScrollDirectionHorizontal;//设置滚动方向
        flowLayou.minimumLineSpacing = 0;
        flowLayou.minimumInteritemSpacing = 0;
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:collectionViewFrame collectionViewLayout:flowLayou];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.showsHorizontalScrollIndicator  = NO;
        collectionView.showsVerticalScrollIndicator  = NO;
        collectionView.pagingEnabled = YES;
        collectionView.backgroundColor = [UIColor whiteColor];
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:listCellID];
        _mainListView = collectionView;
    }
    return _mainListView;
}

#pragma mark - <UIScrollViewDelegate>
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    float f_OffsetX = self.mainListView.contentOffset.x;
    NSInteger page = f_OffsetX/kScreenWidth;
    [self.topScrollView setScrollPage:page];
}

#pragma mark - TopScrollTabDelegate

- (void)selectTopMenu:(NSInteger)tagId{
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:tagId inSection:0];
    [self.mainListView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}


@end
