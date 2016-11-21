//
//  TopScrollTab.m
//  TabListViewDemo
//
//  Created by apple on 2016/11/21.
//  Copyright © 2016年 Lingser. All rights reserved.
//

#import "TopScrollTab.h"

@interface TopScrollTab ()

@property (strong, nonatomic)NSMutableArray *bttones;//保存所有的按钮

@property (strong, nonatomic)UIView *topLineView;

@end

@implementation TopScrollTab

- (instancetype)initWithFrame:(CGRect)frame topDelegate:(id<TopScrollTabDelegate>)topdelegate{
    self = [self initWithFrame:frame];
    self.delegate = self;
    self.topDelegate = topdelegate;
    [self settingTopScroll];
    
    return self;
}


//初始化设置
- (void)settingTopScroll{
    self.scrollEnabled = YES;
    self.scrollsToTop = NO;
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.pagingEnabled = NO;
    self.bounces = YES;
    self.backgroundColor = TopScrollBackColor;
}

- (void)setTopTitles:(NSArray *)topTitles{
    _topTitles = topTitles;
    
    [self calcurateWidth:self.topTitles];
}

//遍历数组并创建按钮
-(void)calcurateWidth:(NSArray *)menuList{
    [self clearView];//删除所有的子视图 防止重复创建
    
    __block CGFloat buttonHeight = self.frame.size.height;
    __block CGFloat buttonX = 0.0f;
    
    [menuList enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CGFloat buttonWidth = [TopScrollTab widthForMenuTitle:obj buttonEdgeInsets:kDefaultEdgeInsets];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(buttonX, 0, buttonWidth, buttonHeight);
        btn.tag = idx;
        btn.titleLabel.font = [UIFont systemFontOfSize:TopFont];
        [btn setTitle:obj forState:UIControlStateNormal];
        
        [btn setTitleColor:TopBarTitNormalColor forState:UIControlStateNormal];
        [btn setTitleColor:TopBarTitSelectColor forState:UIControlStateSelected];
        
        [btn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.selected = (idx == 0);
        
        [self addSubview:btn];
        
        self.bttones[idx] = btn;
        buttonX += buttonWidth + kIntroMarginW;
    }];
    
    //判断当contentSize的宽度小于屏幕的宽度时，就重新计算所有button的大小及位置
    if (buttonX < kScreenWidth) {
        buttonX = kScreenWidth;
        
        [self.bttones enumerateObjectsUsingBlock:^(UIButton *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CGRect btnFrame = obj.frame;
            btnFrame.size.width = kScreenWidth / self.bttones.count;
            btnFrame.origin.x = idx * btnFrame.size.width;
            obj.frame = btnFrame;
        }];
    }
    
    UIButton *btn = self.bttones[0];
    self.topLineView.frame = CGRectMake(TopLineMargan,self.bounds.size.height - 3,btn.bounds.size.width - 2 * TopLineMargan, 2);
    [self addSubview:self.topLineView];
    
    
    //设置ScrollView的滚动范围
    self.contentSize = CGSizeMake(buttonX, self.frame.size.height);
}


//清除所有的子视图
- (void)clearView
{
    [self.subviews enumerateObjectsUsingBlock:^(UIView *v, NSUInteger idx, BOOL *stop) {
        [v removeFromSuperview];
    }];
}

//按钮的点击事件
- (void)buttonAction:(id)sender{
    UIButton *btn = (UIButton *)sender;
    
    [self.bttones enumerateObjectsUsingBlock:^(UIButton *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.selected = (btn.tag == idx);
    }];
    
    CGFloat btnX = btn.frame.origin.x;
    CGFloat btnCenterX = btn.center.x;
    CGPoint scrollPoint;
    
    /* 计算自动偏移 */
    if(btnCenterX > kViewCenterX && self.contentSize.width + kViewCenterX - self.frame.size.width > btnCenterX){
        scrollPoint = CGPointMake(btnX - kViewCenterX + (btn.frame.size.width/2), 0.0f);
    }else if(self.contentSize.width + kViewCenterX - self.frame.size.width < btnCenterX){
        scrollPoint = CGPointMake(self.contentSize.width - self.bounds.size.width,0.0f);
    }else if(btnCenterX < kViewCenterX){
        scrollPoint = CGPointMake(0.0f,0.0f);
    }
    [self setContentOffset:scrollPoint animated:YES];
    
    
    //底部线条的位置
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = self.topLineView.frame;
        frame.origin.x = btn.frame.origin.x + TopLineMargan;
        frame.size.width = btn.frame.size.width - 2 * TopLineMargan;
        self.topLineView.frame = frame;
    }];
    
    
    //代理方法
    if (self.topDelegate && [self.topDelegate respondsToSelector:@selector(selectTopMenu:)]) {
        [self.topDelegate selectTopMenu:btn.tag];
    }
    
}

#pragma mark - 当page改变时

-(void)setScrollPage:(NSInteger)page{
    
    [self buttonAction:self.bttones[page]];
}


#pragma mark - 懒加载初始化数组
- (NSMutableArray *)bttones{
    if (!_bttones) {
        _bttones = [NSMutableArray array];
    }
    return _bttones;
}

- (UIView *)topLineView{
    if (!_topLineView) {
        _topLineView = [[UIView alloc] init];
        _topLineView.backgroundColor = TopLineColor;
    }
    return _topLineView;
}


#pragma mark - 计算文字的宽度
+ (CGFloat)widthForMenuTitle:(NSString *)title buttonEdgeInsets:(UIEdgeInsets)buttonEdgeInsets
{
    CGSize size = [title sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:TopFont]}];
    return CGSizeMake(size.width + buttonEdgeInsets.left + buttonEdgeInsets.right, size.height + buttonEdgeInsets.top + buttonEdgeInsets.bottom).width;
}






@end
