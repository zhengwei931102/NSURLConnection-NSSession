//
//  TwoViewController.m
//  get同步，get异步，post异步，身份证get异步
//
//  Created by stu074 on 16/3/23.
//  Copyright © 2016年 stu074. All rights reserved.
//

#import "TwoViewController.h"
#import "ZWCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#define Width [UIScreen mainScreen].bounds.size.width
#define Height [UIScreen mainScreen].bounds.size.height
@interface TwoViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    NSArray *a;
}
@end

@implementation TwoViewController
@synthesize p;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBarTintColor:[UIColor grayColor]];
    //左
    
    UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
    b.backgroundColor = [UIColor clearColor];
    b.frame = CGRectMake(0, 4, 60, 30);
    [b addTarget:self action:@selector(chuli) forControlEvents:UIControlEventTouchUpInside];
    [b setTitle:@"返回" forState:UIControlStateNormal];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(Width*1.2/3, 4, Width/3, 36)];
    label.text = @"做法";
    label.font = [UIFont systemFontOfSize:25.0];
    label.textColor = [UIColor blackColor];
    UIView *leftview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width/2, 44)];
    leftview.backgroundColor = [UIColor clearColor];
    [leftview addSubview:b];
    [leftview addSubview:label];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftview];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    //---------------------布局collectionview－－－－－－－－－－－－－－－－
    self.view.backgroundColor = [UIColor yellowColor];
    
    
    //比uitableview多了一个布局,每一个框框
    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
    flowlayout.itemSize = CGSizeMake(100, 180);
    //水平滚动条下角标一行一行的变
    //a d g
    //b e h
    //c f
    flowlayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowlayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    self.grid=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, Width, 600) collectionViewLayout:flowlayout];
    [self.view addSubview:self.grid];
    [self.grid registerClass:[ZWCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    self.grid.backgroundColor = [UIColor whiteColor];
    self.grid.dataSource=self;
    self.grid.delegate=self;
    a = p[@"steps"];
    
    
    
    
}
#pragma mark 以下两个方法是必须实现的
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;{
    return a.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;{
    static NSString * identity=@"cell";
    ZWCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identity forIndexPath:indexPath];
    [cell initcontent];
    
    NSDictionary *step = a[indexPath.row];
    
    [cell.img sd_setImageWithURL:step[@"img"] placeholderImage:[UIImage imageNamed:@"default.jpg"]];
    cell.lbl.backgroundColor = [UIColor whiteColor];
    cell.lbl.text=step[@"step"];
    cell.lbl.numberOfLines = 0;
    return cell;
    //运用了第三方，第一次从网上下载，第二次及以后则用本地
    //[self.imageView sd_setImageWithURL:IMAGE_URL];
}

- (void)chuli{
    
    
    [self.navigationController popToRootViewControllerAnimated:YES];
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
