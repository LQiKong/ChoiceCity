//
//  YZHotCityTableViewCell.m
//  XM_cityList
//
//  Created by mr kong on 15-3-5.
//  Copyright (c) 2015年 kong. All rights reserved.
//

#import "YZ_HotCityTableViewCell.h"

@implementation YZ_HotCityTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
           }
    return self;
}

- (void)hotCityDictionary:(NSDictionary *)dic
{
    self.hotCityKey = [NSMutableArray arrayWithArray:[dic allKeys]];
    self.hotCityDic = [NSDictionary dictionaryWithDictionary:dic];
    for (int i = 0; i < 11; i++) {
        UIButton *hotCityButton = [[UIButton alloc] initWithFrame:CGRectMake( 30 + (i % 4) * 70 , (i / 4) * 50 , 50, 30)];
        hotCityButton.backgroundColor = [UIColor colorWithRed:0.093 green:0.689 blue:0.954 alpha:1.000];
        [hotCityButton setBackgroundImage:[UIImage imageNamed:@"YZ_HotCityListButton.png"] forState:UIControlStateHighlighted];
        hotCityButton.tag = i;
        [hotCityButton addTarget:self action:@selector(cityName:) forControlEvents:UIControlEventTouchUpInside];
        [hotCityButton setTitle:[_hotCityDic objectForKey:_hotCityKey[i]] forState:UIControlStateNormal];
        [self.contentView addSubview:hotCityButton];
    }
}

- (void)cityName:(UIButton *)button
{
    for (int i = 0; i < 11; i++) {
        if (button.tag == i) {
            if ([_delegate respondsToSelector:@selector(dismissViewControllerWithHotCity:HotCityID:)]) {
                [_delegate dismissViewControllerWithHotCity:[_hotCityDic objectForKey:_hotCityKey[i]] HotCityID:_hotCityKey[i]];
                 }
        }
    }
}


- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
