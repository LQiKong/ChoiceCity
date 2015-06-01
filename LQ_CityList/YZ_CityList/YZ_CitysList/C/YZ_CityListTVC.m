//
//  YZ_CityListTVC.m
//  YZ_CityList
//
//  Created by mr kong on 15-3-7.
//  Copyright (c) 2015年 kong. All rights reserved.
//

#define kTableViewCell @"tableViewCellIdentifier"
#define kHotCityTVC @"hotCityTVCIdentifier"
#define kRecentCityCell @"recentCityCellIdentifier"

#import "YZ_CityListTVC.h"
#import "YZ_RecentlyTableViewCell.h"
#import "YZ_HotCityTableViewCell.h"
#import "YZ_CityModel.h"
#import "JSONKit.h"

@interface YZ_CityListTVC ()

@property (nonatomic,strong) NSMutableDictionary * cities;
@property (nonatomic,strong) NSMutableArray      * keys;
@property (nonatomic,strong) NSMutableArray      * hotCityArray;//热门城市数组;
@property (nonatomic,strong) NSMutableDictionary * hotCityDic;//热门城市字典
@property (nonatomic,strong) NSString            * selectCityName;//选择城市名;
@property (nonatomic,strong) NSString            * selectCityID;//选择城市 ID;



@end

@implementation YZ_CityListTVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kTableViewCell];
    [self.tableView registerClass:[YZ_RecentlyTableViewCell class] forCellReuseIdentifier:kRecentCityCell];
    [self.tableView registerClass:[YZ_HotCityTableViewCell class] forCellReuseIdentifier:kHotCityTVC];
    
    [self getCityData];
    [self setBackButton];
}
//  =================== SearchBar =================== //


//  =================== BackButton =================== //

- (void)setBackButton
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(BackPreviousView)];
}
- (void)BackPreviousView
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//  =================== CityData =================== //

- (void)getCityData
{
    self.hotCityArray = [NSMutableArray array];
    self.hotCityDic = [NSMutableDictionary dictionary];
    self.keys = [NSMutableArray array];
    self.cities = [NSMutableDictionary dictionary];
    NSString * string = [[NSBundle mainBundle] pathForResource:@"cities" ofType:@"json"];
    NSData * jsonData = [NSData dataWithContentsOfFile:string];
    NSDictionary *resultDic = [jsonData objectFromJSONData];
    NSArray * resultArray = resultDic[@"data"];
    for (NSDictionary * cityDic in resultArray) {
        YZ_CityModel * cityModel = [[YZ_CityModel alloc]initWithAttributes:cityDic];
        NSString * initial = [cityModel.pinyin substringToIndex:1];
        if (![self.keys containsObject:initial]) {
            [self.keys addObject:initial];
            [self.cities setValue:[NSMutableArray array] forKey:initial];
        }
        [self.cities[initial] addObject:cityModel];
       if ([cityModel.rank isEqualToString:@"S"]||[cityModel.rank isEqualToString:@"A"]) {
           [self.hotCityArray addObject:cityModel.name];
           [self.hotCityDic setObject:cityModel.name forKey:cityModel.ID];
        }
    }
    [self.keys sortUsingSelector:@selector(compare:)];//keys 的排序;
    [_keys insertObject:@"最近" atIndex:0];
    [_keys insertObject:@"热门" atIndex:1];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return _keys;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [_keys count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 1||section == 0) {
        return 1;
    }else{
        NSString *key = [_keys objectAtIndex:section];
        NSArray *city = [_cities objectForKey:key];
        return [city count];
    }return 0;
}

/* Header 的设置 */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(13, 0, 250, 30)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:12];
    NSString *key = [_keys objectAtIndex:section];
    titleLabel.text = key;
    if (section == 0) {
        titleLabel.text = @"最近选择城市";
    }else if (section == 1){
        titleLabel.text = @"热门城市";
    }
    titleLabel.font = [UIFont fontWithName:@"Zapfino" size:15.0];
    titleLabel.textColor = [UIColor colorWithRed:0.101 green:0.714 blue:0.915 alpha:1.000];
    [bgView addSubview:titleLabel];
    
    return bgView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.section == 0) {
        YZ_RecentlyTableViewCell *recentlyCell = [tableView dequeueReusableCellWithIdentifier:kRecentCityCell];
        recentlyCell.textLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"cityName"];
        recentlyCell.textLabel.textColor = [UIColor colorWithRed:0.089 green:0.498 blue:0.782 alpha:1.000];
        return recentlyCell;
    }else if (indexPath.section == 1 && indexPath.row == 0) {
        YZ_HotCityTableViewCell *hotCityCell = [tableView dequeueReusableCellWithIdentifier:kHotCityTVC];
        hotCityCell.delegate = self;
        [hotCityCell hotCityDictionary:_hotCityDic];
        return hotCityCell;
    } else {
        UITableViewCell *cityCell = [tableView dequeueReusableCellWithIdentifier:kTableViewCell forIndexPath:indexPath];
        NSString *key = [_keys objectAtIndex:indexPath.section];
        NSArray *array = [_cities objectForKey:key];
        cityCell.textLabel.text = [array[indexPath.row] name];
        return cityCell;
    }return nil;
}

- (void)dismissViewControllerWithHotCity:(NSString *)cityName HotCityID:(NSString *)cityID
{
    _selectCityName = cityName;
    _selectCityID = cityID;
    [self dismissViewControllerAnimated:YES completion:nil];
 
}


/* TableViewCell 的高度设置 */

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        return 160.0;
    }
    return 44.0;
}

/*  TableViewCell 的选择设置 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        self.selectCityName = [[NSUserDefaults standardUserDefaults] objectForKey:@"cityName"];
        [self dismissViewControllerAnimated:YES completion:nil];
    }else if (indexPath.section == 1) {
        self.selectCityName = [[NSUserDefaults standardUserDefaults] objectForKey:@"hotCity"];
        [self dismissViewControllerAnimated:YES completion:nil];
    }else {
    NSString *key = [_keys objectAtIndex:indexPath.section];
    _selectCityName = [[[_cities objectForKey:key] objectAtIndex:indexPath.row] name];
    _selectCityID = [[[_cities objectForKey:key] objectAtIndex:indexPath.row] ID];
//    NSLog(@"%@,%@", [[[_cities objectForKey:key] objectAtIndex:indexPath.row] ID], [[[_cities objectForKey:key] objectAtIndex:indexPath.row] name]);
    [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{

    if ([_delegate respondsToSelector:@selector(sendCityNameToBarButtonCityName:cityID:)]) {
        [_delegate sendCityNameToBarButtonCityName:_selectCityName cityID:_selectCityID];
        NSUserDefaults *selectUserDefaults = [NSUserDefaults standardUserDefaults];
        [selectUserDefaults setObject:_selectCityName forKey:@"cityName"];
        [selectUserDefaults setObject:_selectCityID forKey:@"cityID"];
        [selectUserDefaults synchronize];
    }
}

@end
