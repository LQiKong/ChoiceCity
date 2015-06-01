//
//  kAppDelegate.h
//  YZ_CityList
//
//  Created by mr kong on 15-3-7.
//  Copyright (c) 2015年 kong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface kAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
