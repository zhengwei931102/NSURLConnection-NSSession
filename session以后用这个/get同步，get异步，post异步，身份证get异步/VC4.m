//
//  VC4.m
//  get同步，get异步，post异步，身份证get异步
//
//  Created by stu074 on 16/3/23.
//  Copyright © 2016年 stu074. All rights reserved.
//

#import "VC4.h"
#import "UIImageView+WebCache.h"
#import "ZWTableViewCell.h"
@interface VC4 ()
{
    NSDictionary *dic_data;
}
@property(nonatomic,retain)UITableView *table;

@end

@implementation VC4

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.table = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    self.table.backgroundColor = [UIColor grayColor];
    self.table.dataSource = self;
    self.table.delegate = self;//两个代理
    [self.view addSubview:self.table];
    [self createTable];
    
    
}
- (void)createTable{
    //把中文编码代码
    NSString *httpUrl = @"http://apis.baidu.com/apistore/idservice/id";
    NSString *httpArg = @"id=211402199310024645";
    [self request: httpUrl withHttpArg: httpArg];
    
}
-(void)request: (NSString*)httpUrl withHttpArg: (NSString*)HttpArg  {
    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, HttpArg];
    NSURL *url = [NSURL URLWithString: urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
    [request setHTTPMethod: @"GET"];
    [request addValue: @"ebdce978ac5a698d60d4048fce2d50cb" forHTTPHeaderField: @"apikey"];
    [NSURLConnection sendAsynchronousRequest: request
                                       queue: [NSOperationQueue mainQueue]
                           completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error){
                               if(data!=nil){
                                   NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                   dic_data = dic[@"retData"];
                                   NSLog(@"%@",dic_data);
                                   //重点，重新加载table
                                   [self.table reloadData];
                                   
                               }
                               
                               if (error) {
                                   NSLog(@"Httperror: %@%ld", error.localizedDescription, error.code);
                               } else if(data==nil&&error==nil) {
                                   NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
                                   NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                   NSLog(@"HttpResponseCode:%ld", responseCode);
                                   NSLog(@"HttpResponseBody %@",responseString);
                               }
                           }];
}
#pragma mark 返回几行,UITableViewDataSource的方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;{
    return 1;
}
#pragma mark 每一行都要执行一遍，UITableViewDataSource的方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;{
    static NSString *identity = @"cell";
    ZWTableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:identity];
    
    if(cell==nil){
        cell = [[ZWTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identity];
    }
    
    //UITableViewCellStyleDefault 这种形式是一张图，一行文字,也可自行减少
    //如果有详情的话，换成UITableViewCellStyleSubtitle
    NSDictionary *p = dic_data;
    
    
    cell.sex.text = p[@"sex"];
    cell.birthday.text = p[@"birthday"];
    cell.birthday.numberOfLines = 0;
    cell.address.text = p[@"address"];
    cell.address.numberOfLines = 0;
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
