//
//  ZWTableViewCell.m
//  get同步，get异步，post异步，身份证get异步
//
//  Created by stu074 on 16/3/23.
//  Copyright © 2016年 stu074. All rights reserved.
//

#import "ZWTableViewCell.h"

@implementation ZWTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.sex = [[UILabel alloc] initWithFrame:CGRectMake(0,10,80,50)];
        self.birthday = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, 150, 50)];
        self.address= [[UILabel alloc ] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 50)];
        self.address.numberOfLines = 0;
        self.address.lineBreakMode = UILineBreakModeWordWrap;
        
        [self.contentView addSubview:self.sex];
        [self.contentView addSubview:self.birthday];
        
        [self.contentView addSubview:self.address];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0.5)];
        view.backgroundColor = [UIColor blackColor];
        [self.contentView addSubview:view];
        
    }
    return self;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
