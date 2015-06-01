//
//  YZ_CityModel.m
//  XM_cityList
//
//  Created by mr kong on 15-3-6.
//  Copyright (c) 2015年 kong. All rights reserved.
//

#import "YZ_CityModel.h"

@implementation YZ_CityModel
- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (self && attributes) {
        //注意，类如created_at这样属性名，我们在选用的时候，要注意命名规范，避免“id”,"newInfo","new"等等这样的属性命名。以便于跟系统的原有命名冲突
        [self setValuesForKeysWithDictionary:attributes];
        self.ID = [attributes valueForKey:@"id"];
        
    }
    return self;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}



@end
