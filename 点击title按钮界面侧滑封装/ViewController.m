//
//  ViewController.m
//  点击title按钮界面侧滑封装
//
//  Created by 曹轩 on 2018/3/8.
//  Copyright © 2018年 曹轩. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "ZXLSegmentView.h"
#import "COMMON.h"
#import "LeftVC.h"
#import "RightVC.h"

//iPhoneX机型判断
#define IS_IPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ?  CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)


#define   rgb(a,b,c)    [UIColor colorWithRed:(a)/255.0 green:(b)/255.0 blue:(c)/255.0 alpha:(1)]


#define ZXLNavigationBarAdapterContentInsetTop (IS_IPHONE_X? 88.0f:64.0f) //顶部偏移

#define APPCONFIG_UI_SCREEN_FWIDTH              ([UIScreen mainScreen].bounds.size.width)//界面的宽度



@interface ViewController ()<UIScrollViewDelegate>
// 侧滑按钮视图
@property(nonatomic,strong) ZXLSegmentView *segment;

@property(nonatomic,strong) UIScrollView *myScrollView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=rgb(245, 245, 245);
    [self setUpViews];
    [self makeConstaints];
}
-(void)makeConstaints{
    [self.segment mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(self.view);
        make.left.mas_equalTo(self.view);
       make.top.mas_equalTo(ZXLNavigationBarAdapterContentInsetTop);
        make.size.mas_equalTo(CGSizeMake(APPCONFIG_UI_SCREEN_FWIDTH, 40));
        
    }];
    
    [self.myScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.segment.mas_bottom);
    }];

    //
self.myScrollView.contentSize=CGSizeMake(self.myScrollView.frame.size.width*self.childViewControllers.count, 0);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //只有这个方法中拿到了ctrlContanier的frame后才能去设置当前的控制器
    [self scrollViewDidEndScrollingAnimation:self.myScrollView];
}
-(void)setUpViews
{
   // self.navigationItem.title = @"资讯";
    // 加载标题
    [self.view addSubview:self.segment];
    //加载 身体 scorllview
    [self.view addSubview:self.myScrollView];
    
    [self createChildCtrls];
    
    //[self.view insertSubview:self.addBtn aboveSubview:self.ctrlContanier];
}

   //添加子控制器
- (void)createChildCtrls
{
    for (int i=0; i<2; i++) {
        
        LeftVC *left=[[LeftVC alloc]init];
        [self addChildViewController:left];
        
        RightVC  *right=[[RightVC alloc]init];
        [self addChildViewController:right];
        
        
    }
}
-(ZXLSegmentView *)segment{
    
    if (_segment==nil) {
        NSArray *arr=@[@"审核通过",@"审核未通过"];
        _segment=[[ZXLSegmentView alloc]initWithSegmentWithTitleArray:arr];
        _segment.canSliderLine.hidden=NO;
        
        __weak typeof(self) weakSelf=self;
        _segment.clickSegmentButton = ^(NSInteger index) {
            CGPoint offset=weakSelf.myScrollView.contentOffset;
            offset.x=index*weakSelf.myScrollView.frame.size.width*index;
            [weakSelf.myScrollView setContentOffset:offset animated:YES];
            
        };
    }
    return _segment;

}

-(UIScrollView *)myScrollView{
    if (_myScrollView==nil) {
        _myScrollView=[[UIScrollView alloc]init];
        _myScrollView.scrollsToTop=NO;
        _myScrollView.showsVerticalScrollIndicator = NO;
        _myScrollView.showsHorizontalScrollIndicator = NO;
        _myScrollView.pagingEnabled = YES;
        _myScrollView.delegate = self;
        _myScrollView.backgroundColor=rgb(245, 245, 245);
    }
    return _myScrollView;
    
}

#pragma mark - UIScrollViewDelegate

// 滑动添加在scrollview上添加view
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    CGFloat width = scrollView.frame.size.width;
    CGFloat height = scrollView.frame.size.height;
    CGFloat offsetX = scrollView.contentOffset.x;
    // 当前位置需要显示的控制器的索引
    NSInteger index = offsetX / width;
    //设置optionalNewsSegment滚动到控制器对应的位置
    [self.segment movieToCurrentSelectedSegment:index];
    //容错处理
    if (index<0) return;
    // 取出需要显示的控制器
    UIViewController *willShowVC = self.childViewControllers[index];
    // 如果当前位置已经显示过了，就直接返回
    if ([willShowVC isViewLoaded]) return;
    // 添加控制器的view到scrollView中;
    willShowVC.view.frame = CGRectMake(offsetX, 0, width, height);
    [scrollView addSubview:willShowVC.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}



@end
