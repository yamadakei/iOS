//
//  main.m
//  map
//
//  Created by 山田 慶 on 2012/12/05.
//  Copyright (c) 2012年 山田 慶. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"

int main(int argc, char *argv[])
{
    @try {
        @autoreleasepool {
            return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
        }
    }
    @catch (NSException *exception) {
        NSLog(@"%@", exception.callStackSymbols);
    }
}
