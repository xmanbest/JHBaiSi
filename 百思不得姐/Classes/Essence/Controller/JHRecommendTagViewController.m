//
//  JHRecommendTagViewController.m
//  百思不得姐
//
//  Created by 李建華 on 16/3/29.
//  Copyright © 2016年 lijianhua. All rights reserved.
//

#import "JHRecommendTagViewController.h"
#import <AFNetworking.h>
#import "JHRecommendTag.h"
#import "JHRecommendTagCell.h"
#import <MJExtension.h>
#import <SVProgressHUD.h>

static NSString * const JHRecommendTagKey = @"recommendTag";

@interface JHRecommendTagViewController ()
@property(nonatomic, strong)NSArray *recommendTags;
@end

@implementation JHRecommendTagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 基本设置
    [self setUp];
    
    // 网络请求tags数据
    [self requestForTags];
}

/**
 *  基本设置
 */
- (void)setUp {
    self.tableView.backgroundColor = JHGlobalBackColore;
    
    self.navigationItem.title = @"推荐标签";
    
    self.tableView.rowHeight = 70;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([JHRecommendTagCell class]) bundle:nil] forCellReuseIdentifier:JHRecommendTagKey];
}

/**
 *  网络请求tags数据
 */
- (void)requestForTags {
    // 显示刷新菊花
    [SVProgressHUD show];
    
    NSString *urlPath = @"http://api.budejie.com/api/api_open.php?a=tags_list&appname=baisi_xiaohao&asid=63CB234F-A84B-469E-A741-426F9B739C6C&c=subscribe&client=iphone&device=ios%20device&from=ios&jbk=0&mac=&market=&openudid=11b2cfdd928b5fd15c0d37ea09d674a151762b55&udid=&uid=17906106&ver=4.1";
    
    [[AFHTTPSessionManager manager] GET:urlPath parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 取消刷新菊花
        [SVProgressHUD dismiss];
        // 封装数据模型
        self.recommendTags = [JHRecommendTag mj_objectArrayWithKeyValuesArray:responseObject[@"rec_tags"]];
        JHLog(@"%@", self.recommendTags);
        // 刷新tableView数据
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 显示错误信息
        [SVProgressHUD showErrorWithStatus:@"加载失败！"];
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.recommendTags.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JHRecommendTagCell *cell = [tableView dequeueReusableCellWithIdentifier:JHRecommendTagKey];
    
    cell.recommendTag = self.recommendTags[indexPath.row];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
