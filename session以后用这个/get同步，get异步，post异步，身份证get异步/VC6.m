//
//  VC6.m
//  get同步，get异步，post异步，身份证get异步
//
//  Created by stu074 on 16/3/24.
//  Copyright © 2016年 stu074. All rights reserved.
//

#import "VC6.h"
#import "UIImageView+WebCache.h"

#define Width [UIScreen mainScreen].bounds.size.width

@interface VC6 ()<UITableViewDataSource,UITableViewDelegate,NSURLSessionDataDelegate>
{
    NSMutableArray *dic_data;
    
    
}
@property(nonatomic,retain)UITableView *table;
@property(nonatomic,retain)NSMutableData *mutableData;
@end
@implementation VC6

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.table = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    self.table.backgroundColor = [UIColor grayColor];
    self.table.dataSource = self;
    self.table.delegate = self;//两个代理
    [self.view addSubview:self.table];
    
    [self createTable];
}
- (void)createTable{
    //把中文编码代码
    NSString *str = @"http://apis.juhe.cn/cook/query?key=5c7bb350799fb1b79485e2c040c3289a&menu=红烧肉";
    NSCharacterSet *set = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSString *result = [str stringByAddingPercentEncodingWithAllowedCharacters:set];
    //处理请求
    NSURL *url = [NSURL URLWithString:result];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];
    NSString *str1 = @"type=focus-c";
    NSData *data = [str1 dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
    
//        NSURLSession *session = [NSURLSession sharedSession];
//    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//        NSDictionary *dic_result = dic[@"result"];
//        dic_data = dic_result[@"data"];
//        NSLog(@"%@",dic_data);
//        //重点，重新加载table
//        [self.table reloadData];
//        
//    }];
//    //发送
//    [task resume];
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    NSURLSessionTask *task =[session dataTaskWithRequest:request];
    self.mutableData = [NSMutableData data];
    [task resume];
    
}
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data{
    [self.mutableData appendData:data];
}
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask willCacheResponse:(NSCachedURLResponse *)proposedResponse completionHandler:(void (^)(NSCachedURLResponse * _Nullable))completionHandler{
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:self.mutableData options:0 error:nil];
            NSDictionary *dic_result = dic[@"result"];
            dic_data = dic_result[@"data"];
            NSLog(@"%@",dic_data);
            //重点，重新加载table
            [self.table reloadData];
    
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
    
    //UITableViewCellStyleDefault 这种形式是一张图，一行文字,也可自行减少
    //如果有详情的话，换成UITableViewCellStyleSubtitle
    NSDictionary *p = dic_data[indexPath.row];
    
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
