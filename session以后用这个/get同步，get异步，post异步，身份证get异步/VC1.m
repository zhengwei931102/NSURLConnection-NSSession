//
//  VC1.m
//  get同步，get异步，post异步，身份证get异步
//
//  Created by stu074 on 16/3/23.
//  Copyright © 2016年 stu074. All rights reserved.
//

#import "VC1.h"
#import "TwoViewController.h"
#import "UIImageView+WebCache.h"
#define Width [UIScreen mainScreen].bounds.size.width
@interface VC1 ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *dic_data;
    UISearchBar *searchBar;
}
@property(nonatomic,retain)UITableView *table;
@end

@implementation VC1

- (void)viewDidLoad {
    [super viewDidLoad];
    self.table = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    self.table.backgroundColor = [UIColor grayColor];
    self.table.dataSource = self;
    self.table.delegate = self;//两个代理
    [self.view addSubview:self.table];
    
    searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 60, [UIScreen mainScreen].bounds.size.width, 50)];
    [searchBar setTintColor:[UIColor clearColor]];
    [self.view addSubview:searchBar];
    
    
    [self createTable];
    
    
}
- (void)createTable{
    //把中文编码代码
    NSString *str = @"http://apis.juhe.cn/cook/query?key=5c7bb350799fb1b79485e2c040c3289a&menu=红烧肉";
    NSCharacterSet *set = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSString *result = [str stringByAddingPercentEncodingWithAllowedCharacters:set];
    //处理请求
    NSURL *url = [NSURL URLWithString:result];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    //NSString *ss = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSDictionary *dic_result = dic[@"result"];
    dic_data = dic_result[@"data"];
    NSLog(@"%@",dic_data);
    
}
#pragma mark 返回几行,UITableViewDataSource的方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;{
    return dic_data.count;
}
#pragma mark 每一行都要执行一遍，UITableViewDataSource的方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;{
    static NSString *identity = @"cell";
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:identity];
    
    if(cell==nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identity];
    }
    
    NSDictionary *p = dic_data[indexPath.row];
    //下载图片，用的gcd，但实际开发最好不用多线程
    //    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
    //        NSString *url = p[@"albums"][0];
    //        NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
    //        UIImage *image= [[UIImage alloc] initWithData:data];
    //        if (image!=nil) {
    //            dispatch_async(dispatch_get_main_queue(), ^{
    //                 cell.imageView.image = image;
    //            });
    //
    //        } else{
    //            NSLog(@"--下载图片出现错误－－");
    //        }
    //
    //    });
    
    
    [cell.imageView sd_setImageWithURL:p[@"albums"][0] placeholderImage:[UIImage imageNamed:@"default.jpg"]];
    cell.textLabel.text = p[@"title"];
    cell.detailTextLabel.text = p[@"tags"];
    cell.detailTextLabel.numberOfLines = 0;
    return cell;
}
#pragma mark uitableviewdelegate代理的方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;{
    return 150.f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TwoViewController *two = [TwoViewController new];
    two.p = dic_data[indexPath.row];
    [self.navigationController pushViewController:two animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
