//
//  ZWCollectionViewCell.m
//  get同步，get异步，post异步，身份证get异步
//
//  Created by stu074 on 16/3/23.
//  Copyright © 2016年 stu074. All rights reserved.
//

#import "ZWCollectionViewCell.h"

@implementation ZWCollectionViewCell
@synthesize img,lbl;
- (void)awakeFromNib {
    // Initialization code
}
-(void)initcontent{
    
    img=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 90, 90)];
    lbl=[[UILabel alloc] initWithFrame:CGRectMake(0, 90, 90, 50)];
    lbl.font = [UIFont systemFontOfSize:13 ];
    [self.contentView addSubview:img];
    [self.contentView addSubview:lbl];
    
}

@end
