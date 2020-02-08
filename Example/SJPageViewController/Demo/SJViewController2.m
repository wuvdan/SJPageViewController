//
//  SJViewController0.m
//  SJPageViewController_Example
//
//  Created by BlueDancer on 2020/2/8.
//  Copyright © 2020 changsanjiang@gmail.com. All rights reserved.
//

#import "SJViewController2.h"
#import <SJPageViewController/SJPageViewController.h>
#import <Masonry/Masonry.h>
#import <MJRefresh/MJRefresh.h>
#import "SJDemoTableViewController.h"

@interface SJViewController2 ()<SJPageViewControllerDelegate, SJPageViewControllerDataSource>
@property (nonatomic, strong) SJPageViewController *pageViewController;
@end

@implementation SJViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _setupViews];
}

- (void)dealloc {
#ifdef DEBUG
    NSLog(@"%d \t %s", (int)__LINE__, __func__);
#endif
}

#pragma mark -

- (void)_setupViews {
    self.view.backgroundColor = UIColor.blackColor;
    
    _pageViewController = [SJPageViewController pageViewControllerWithOptions:@{SJPageViewControllerOptionInterPageSpacingKey:@(3)}];
    _pageViewController.dataSource = self;
    _pageViewController.delegate = self;
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [_pageViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
}

- (NSUInteger)numberOfViewControllers {
    return 3;
}

- (UIViewController *)pageViewController:(SJPageViewController *)pageViewController viewControllerAtIndex:(NSInteger)index {
    SJDemoTableViewController *vc = SJDemoTableViewController.new;
    vc.tableView.mj_header = nil;
    return vc;
}

///
/// 顶部下拉时, headerView 同比放大
///
- (SJPageViewControllerHeaderMode)modeForHeaderWithPageViewController:(SJPageViewController *)pageViewController {
    return SJPageViewControllerHeaderModeAspectFill;
}

///
/// 头部视图
///
- (nullable __kindof UIView *)viewForHeaderWithPageViewController:(SJPageViewController *)pageViewController {
    UIImageView *headerView = [UIImageView.alloc initWithFrame:CGRectZero];
    headerView.backgroundColor = UIColor.redColor;
    headerView.image = [UIImage imageNamed:@"cover1"];
    headerView.contentMode = UIViewContentModeScaleAspectFill;
    headerView.clipsToBounds = YES;
    
    UILabel *channelView = [UILabel.alloc initWithFrame:CGRectZero];
    channelView.text = @"左右滑动切换vc";
    channelView.backgroundColor = UIColor.greenColor;
    [headerView addSubview:channelView];
    [channelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.bottom.offset(0);
        make.width.offset(self.view.bounds.size.width);
        make.height.offset([self heightForHeaderPinToVisibleBoundsWithPageViewController:pageViewController]);
    }];
    
    return headerView;
}

///
/// 头部视图的高度
///
- (CGFloat)heightForHeaderBoundsWithPageViewController:(SJPageViewController *)pageViewController {
    return 200;
}

///
/// 在顶部悬浮保留的高度
///
- (CGFloat)heightForHeaderPinToVisibleBoundsWithPageViewController:(SJPageViewController *)pageViewController {
    return 40;
}

@end
