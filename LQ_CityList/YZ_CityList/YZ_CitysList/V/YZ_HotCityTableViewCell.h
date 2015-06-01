//
//  YZHotCityTableViewCell.h
//  XM_cityList
//
//  Created by mr kong on 15-3-5.
//  Copyright (c) 2015年 kong. All rights reserved.
//
@protocol hotCityDelegate <NSObject>

- (void)dismissViewControllerWithHotCity:(NSString *)cityName
                               HotCityID:(NSString *)cityID;

@end

#import <UIKit/UIKit.h>

@interface YZ_HotCityTableViewCell : UITableViewCell

@property (nonatomic,strong) NSArray * hotCityKey;
@property (nonatomic,strong) NSDictionary *hotCityDic;
@property (nonatomic,assign) id<hotCityDelegate>delegate;

- (void)hotCityDictionary:(NSDictionary *)dic;


@end
