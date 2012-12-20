//
//  CityArray.h
//  map
//
//  Created by 山田 慶 on 2012/12/05.
//  Copyright (c) 2012年 山田 慶. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityArray : NSMutableArray

@property (nonatomic) NSString* cityName;
@property (nonatomic) NSString* latitude;
@property (nonatomic) NSString* longitude;
@property (nonatomic) NSString* population;
@property (nonatomic) NSString* picName;
@property (nonatomic) NSString* cityURL;

@end
