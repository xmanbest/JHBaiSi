//
//  JHRecommendViewController.m
//  百思不得姐
//
//  Created by 李建華 on 16/3/25.
//  Copyright © 2016年 lijianhua. All rights reserved.
//

#import "JHRecommendViewController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import <MJExtension.h>
#import <MJRefresh.h>

#import "JHRecommendCategory.h"
#import "JHRecommendCategoryTableViewCell.h"
#import "JHRecommendUser.h"
#import "JHRecommedUserCell.h"

#define JHPagesize @"10";

static NSString * const recommendCategory = @"recommendCategory";
static NSString * const recommendUser = @"recommendUser";

@interface JHRecommendViewController () <UITableViewDataSource, UITableViewDelegate>
/**
 *  左侧tableView数据模型数组
 */
@property(nonatomic, strong)NSArray *categories;
/**
 *  左侧tableView
 */
@property (weak, nonatomic) IBOutlet UITableView *recommendCategoryTableView;
/**
 *  右侧tableView
 */
@property (weak, nonatomic) IBOutlet UITableView *recommendUserTableView;

@property (nonatomic, strong) AFHTTPSessionManager *manager;

/**
 *  记录最后的请求参数，使快速切换种类时只刷新最后停留的种类
 */
@property (nonatomic, strong) NSDictionary *params;

@end

@implementation JHRecommendViewController

- (void)dealloc {
    
    JHLog(@"%s", __func__);
}

- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUp];
    
    // 设置右侧刷新控件
    [self setUpReflesh];
    
    // 请求左侧种类数据
    [self requestForCategory];
}

- (void)setUp {
    // 设置背景色
    self.view.backgroundColor = JHGlobalBackColore;
    // 设置导航栏标题
    self.navigationItem.title = @"推荐关注";
    
    // 设置左侧tableView的背景色
    self.recommendCategoryTableView.backgroundColor = JHRGBColore(244, 244, 244);
    
    // 注册左侧tableView的cell
    [self.recommendCategoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([JHRecommendCategoryTableViewCell class]) bundle:nil] forCellReuseIdentifier:recommendCategory];
    // 注册右侧tableView的cell
    [self.recommendUserTableView registerNib:[UINib nibWithNibName:NSStringFromClass([JHRecommedUserCell class]) bundle:nil] forCellReuseIdentifier:recommendUser];
    
    // 设置cell高度
    self.recommendUserTableView.rowHeight = 70;
    
    // 设置tableView上端缩进相关
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.recommendCategoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.recommendUserTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
}

/**
 *  请求左侧种类数据
 */
- (void) requestForCategory{
    // 显示等待菊花
    [SVProgressHUD show];
    
    // 向服务器请求左侧tableView数据
    NSString *urlPath = @"http://api.budejie.com/api/api_open.php?appname=baisi_xiaohao&asid=63CB234F-A84B-469E-A741-426F9B739C6C&client=iphone&device=ios%20device&from=ios&jbk=0&mac=&market=&openudid=11b2cfdd928b5fd15c0d37ea09d674a151762b55&udid=&ver=4.1";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    [self.manager GET:urlPath parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 关闭等待菊花
        [SVProgressHUD dismiss];
        
        // 为左侧tebaleView数据模型赋值
        self.categories = [JHRecommendCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 刷新左侧tableView
        [self.recommendCategoryTableView reloadData];
        // 左侧tableView默认选中第一项
        [self.recommendCategoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        // 右侧下拉刷新第一类别对应的数据
        [self.recommendUserTableView.mj_header beginRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 显示错误提示
        [SVProgressHUD showErrorWithStatus:@"加载失败！"];
    }];

}

/**
 *  右侧添加刷新控件
 */
- (void)setUpReflesh {
    // 设置顶部下拉刷新控件
    self.recommendUserTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    
    // 设置底部上拉刷新控件
    self.recommendUserTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    
    self.recommendUserTableView.mj_footer.hidden = YES;
}

/**
 *  顶部下拉刷新第一页最新数据
 */
- (void)loadNewUsers {
    // 获取左侧当前选中类别的数据模型
    JHRecommendCategory *selCategory = self.categories[[self.recommendCategoryTableView indexPathForSelectedRow].row];
    
    // 右侧tableView数据请求url
    NSString *urlPath = @"http://api.budejie.com/api/api_open.php?appname=baisi_xiaohao&asid=63CB234F-A84B-469E-A741-426F9B739C6C&category_id=35&client=iphone&device=ios%20device&from=ios&jbk=0&mac=&market=&openudid=11b2cfdd928b5fd15c0d37ea09d674a151762b55&udid=&ver=4.1";
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"pagesize"] = JHPagesize;
    selCategory.currentPage = 1;
    params[@"page"] = @(selCategory.currentPage);
    params[@"category_id"] = [selCategory ID];
    self.params = params;
    
    [self.manager GET:urlPath parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        // 获取当前选中分类的User总数并封装入模型中
        selCategory.total = [responseObject[@"total"] integerValue];
        
        // 封装User数据模型
        NSArray *users = [JHRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 删除本分类中维护的就数据，避免数据重复
        [selCategory.users removeAllObjects];
        // 新获取的模型数据添加到本分类中进行维护
        [selCategory.users addObjectsFromArray:users];
        
        // 比较block和最后的请求参数，使快速切换种类时只刷新最后停留的种类
        if (self.params != params) return;
        
        // 刷新右侧tableView
        dispatch_async(dispatch_get_main_queue(), ^{
            // 顶部下拉刷新完毕，恢复下拉控件默认状态
            [self.recommendUserTableView.mj_header endRefreshing];
            
            [self.recommendUserTableView reloadData];
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 只有最后停留的种类请求出错才会显示错误信息
        if (self.params != params) return;
        
        [SVProgressHUD showErrorWithStatus:@"加载数据失败"];
        // 恢复顶部刷新控件状态
        [self.recommendUserTableView.mj_header endRefreshing];
    }];
    
}

/**
 *  底部上拉加载下一页
 */
- (void)loadMoreUsers {
    // 左侧当前选中的分类
    JHRecommendCategory *selCategory = self.categories[[self.recommendCategoryTableView indexPathForSelectedRow].row];

    // 右侧tableView数据请求url
    NSString *urlPath = @"http://api.budejie.com/api/api_open.php?appname=baisi_xiaohao&asid=63CB234F-A84B-469E-A741-426F9B739C6C&category_id=35&client=iphone&device=ios%20device&from=ios&jbk=0&mac=&market=&openudid=11b2cfdd928b5fd15c0d37ea09d674a151762b55&udid=&ver=4.1";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"pagesize"] = JHPagesize;
    params[@"page"] = @(++selCategory.currentPage);
    params[@"category_id"] = [selCategory ID];
    self.params = params;
    
    [self.manager GET:urlPath parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 封装数据模型
        NSArray *users = [JHRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        // 模型数据添加到本分类中进行维护
        [selCategory.users addObjectsFromArray:users];
        
        // 比较block和最后的请求参数，使快速切换种类时只刷新最后停留的种类
        if (self.params != params) return;
        
        // 刷新右侧tableView
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.recommendUserTableView reloadData];
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 只有最后停留的种类请求出错才会显示错误信息
        if (self.params != params) return;
        
        [SVProgressHUD showErrorWithStatus:@"加载数据失败"];
        // 恢复底部刷新控件状态
        [self.recommendUserTableView.mj_footer endRefreshing];
    }];
}

/**
 *  检查当前底部上拉刷新控件的应显示的状态并更新
 */
- (void)checkFootRefreshState {
    // 左侧当前选中的分类
    JHRecommendCategory *selCategory = self.categories[[self.recommendCategoryTableView indexPathForSelectedRow].row];
    
    // 返回行数为0时，隐藏foot上拉刷新控件
    self.recommendUserTableView.mj_footer.hidden = (selCategory.users.count == 0);
    
    if (selCategory.users.count == selCategory.total) { // 已经加载了全部的user
        // 显示为已加载完成
        [self.recommendUserTableView.mj_footer endRefreshingWithNoMoreData];
    } else { // 没到上限时
        // 恢复为初始状态
        [self.recommendUserTableView.mj_footer endRefreshing];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.recommendCategoryTableView) { // 左侧
        return self.categories.count;
    }
    else { // 右侧
        // 左侧选中的分类
        JHRecommendCategory *selCategory = self.categories[[self.recommendCategoryTableView indexPathForSelectedRow].row];
        
        // 每次刷新右侧时，都需要检查底部刷新控件应显示的状态并修改
        [self checkFootRefreshState];
        
        return selCategory.users.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.recommendCategoryTableView) { // 左侧
        JHRecommendCategoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:recommendCategory];
        cell.recommendCaregory = self.categories[indexPath.row];
        return cell;
    }
    else { // 右侧
        JHRecommedUserCell *cell = [tableView dequeueReusableCellWithIdentifier:recommendUser];
        // 左侧选中的分类
        JHRecommendCategory *selCategory = self.categories[[self.recommendCategoryTableView indexPathForSelectedRow].row];
        cell.recommendUser = selCategory.users[indexPath.row];
        
        return cell;
    }
    
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.recommendCategoryTableView) { // 选中左侧推荐类别
        // 左侧当前选中的分类
        JHRecommendCategory *selCategory = self.categories[indexPath.row];
        
        // 顶部下拉恢复控件默认状态
        [self.recommendUserTableView.mj_header endRefreshing];
        
        // 加载选中类别对应的右侧数据，避免重复网络请求右侧已加载的数据
        if (selCategory.users.count) { // 已请求过
            // 刷新右侧tableView
            [self.recommendUserTableView reloadData];
        }
        else { //未请求过
            // 刷新右侧tableView，避免网络延迟时上一个类别的右侧信息持续显示
            [self.recommendUserTableView reloadData];
            
            // 下拉刷新第一页最新数据
            [self.recommendUserTableView.mj_header beginRefreshing];
        }
    }
}

@end
