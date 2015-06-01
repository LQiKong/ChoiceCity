//
//  YZ_CityModel.h
//  XM_cityList
//
//  Created by mr kong on 15-3-6.
//  Copyright (c) 2015年 kong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YZ_CityModel : NSObject
@property (nonatomic,copy) NSString *ID;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *pinyin;
@property (nonatomic,copy) NSString *rank;

- (id)initWithAttributes:(NSDictionary *)attributes;

@end
