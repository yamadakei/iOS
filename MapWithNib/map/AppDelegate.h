//
//  AppDelegate.h
//  map
//
//  Created by 山田 慶 on 2012/12/05.
//  Copyright (c) 2012年 山田 慶. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityArray.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic, readonly) CityArray *cityArr;

@end
