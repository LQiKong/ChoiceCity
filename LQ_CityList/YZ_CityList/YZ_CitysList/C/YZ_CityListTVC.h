//
//  YZ_CityListTVC.h
//  YZ_CityList
//
//  Created by mr kong on 15-3-7.
//  Copyright (c) 2015年 kong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YZ_HotCityTableViewCell.h"

@protocol sendCityName <NSObject>

- (void)sendCityNameToBarButtonCityName:(NSString *)cityName cityID:(NSString *)cityID;

@end


@interface YZ_CityListTVC : UITableViewController<hotCityDelegate>

@property (nonatomic,assign)id<sendCityName>delegate;


@end
