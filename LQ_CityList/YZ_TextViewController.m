//
//  YZ_TextViewController.m
//  YZ_CityList
//
//  Created by mr kong on 15-3-7.
//  Copyright (c) 2015年 kong. All rights reserved.
//

#import "YZ_TextViewController.h"
#import "YZ_CityListTVC.h"

@interface YZ_TextViewController ()

@end

@implementation YZ_TextViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view reloadInputViews];
    // Do any additional setup after loading the view.
     self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(cityName)];
}

- (void)cityName
{
    YZ_CityListTVC *cityList = [[YZ_CityListTVC alloc] init];
    cityList.delegate = self;
    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:cityList];
    [self presentViewController:navigation animated:YES completion:nil];
}
- (void)sendCityNameToBarButtonCityName:(NSString *)cityName cityID:(NSString *)cityID
{
    if (cityName == nil) {
        return;
    }
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:cityName style:UIBarButtonItemStyleBordered target:self action:@selector(cityName)];
    /**
     *  如果选择的是最近的城市那么请求数据中的 id 是不变的;
     */
    NSLog(@"cityName is %@, cityID is %@",cityName,cityID);
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
