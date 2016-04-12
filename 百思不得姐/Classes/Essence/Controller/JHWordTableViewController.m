//
//  JHWordTableViewController.m
//  百思不得姐
//
//  Created by 李建華 on 16/4/1.
//  Copyright © 2016年 lijianhua. All rights reserved.
//

#import "JHWordTableViewController.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import <UIImageView+WebCache.h>
#import <MJRefresh.h>
#import "JHTopic.h"
#import "JHTopicCell.h"

static NSString * const JHTopicCellID = @"topic";

@interface JHWordTableViewController ()
/**
 *  数据仓库
 */
@property(nonatomic, strong)NSMutableArray *topics;
/**
 *  获取下一页数据的key
 */
@property(nonatomic, copy)NSString *npKey;
@end

@implementation JHWordTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // tableView基础设置
    [self setupTableView];
    // 设置头部下拉刷新控件
    [self setupHeaderDownRefleshControl];
    // 设置尾部上拉刷新控件
    [self setupFooterUpRefleshControl];
    // 下拉刷新
    [self.tableView.mj_header beginRefreshing];
    
}

/**
 *  tableView基础设置
 */
- (void)setupTableView {
    // tableView基本设置
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    // 设置tableView 的 inset
    self.tableView.contentInset = UIEdgeInsetsMake(JHHeadViewH + JHHeadViewY, 0, self.tabBarController.tabBar.height, 0);
    // 设置滑动条的 inset
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([JHTopicCell class]) bundle:nil] forCellReuseIdentifier:JHTopicCellID];
}
/**
 *  设置头部下拉刷新控件
 */
- (void)setupHeaderDownRefleshControl {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerDownReflesh)];
    // 根据拖拽比例自动切换透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
}
/**
 *  设置尾部上拉刷新控件
 */
- (void)setupFooterUpRefleshControl {
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerUpReflesh)];
}
/**
 *  头部下拉刷新触发方法
 */
- (void)headerDownReflesh {
    // 请求网络数据
    NSString *urlPath = [NSString stringWithFormat:@"http://s.budejie.com/topic/list/jingxuan/%@/baisi_xiaohao-iphone-4.1/%@-20.json", @"29", @"0"];//@"http://s.budejie.com/topic/list/jingxuan/29/baisi_xiaohao-iphone-4.1/0-20.json";
    /** info : {
     count : 4032,
     np : 1459333891
     */
    // http://s.budejie.com/topic/list/jingxuan/29/baisi_xiaohao-iphone-4.1/1459333891-20.json
    // http://s.budejie.com/topic/list/jingxuan/29/baisi_xiaohao-iphone-4.1/1459166178-20.json
    [[AFHTTPSessionManager manager] GET:urlPath parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 获取下一页数据的np
        self.npKey = responseObject[@"info"][@"np"];
        // 封装数据
        self.topics = [JHTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        // 刷新表格视图
        [self.tableView reloadData];
        // 恢复头部下拉刷新控件状态
        [self.tableView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 恢复头部下拉刷新控件状态
        [self.tableView.mj_header endRefreshing];
    }];
}
/**
 *  尾部上拉刷新触发方法
 */
- (void)footerUpReflesh {
    // 请求网络数据(下一页)
    NSString *urlPath = [NSString stringWithFormat:@"http://s.budejie.com/topic/list/jingxuan/%@/baisi_xiaohao-iphone-4.1/%@-20.json", @"29", self.npKey];
    
    [[AFHTTPSessionManager manager] GET:urlPath parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 获取下一页数据的np
        self.npKey = responseObject[@"info"][@"np"];
        // 封装数据
        NSArray *topicsArr = [JHTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        // 添加到数据仓库中
        [self.topics addObjectsFromArray:topicsArr];
        // 刷新表格视图
        [self.tableView reloadData];
        // 恢复头部下拉刷新控件状态
        [self.tableView.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 恢复头部下拉刷新控件状态
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // 没有数据时，隐藏底部上拉刷新控件
    tableView.mj_footer.hidden = (self.topics.count == 0);
    
    return self.topics.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JHTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:JHTopicCellID];
    
    cell.topic = self.topics[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}

@end
