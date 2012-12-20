//
//  Annotation.m
//  map
//
//  Created by 山田 慶 on 2012/12/06.
//  Copyright (c) 2012年 山田 慶. All rights reserved.
//

#import "Annotation.h"

@implementation Annotation

@synthesize coordinate;

- (id)initWithCoordinate:(CLLocationCoordinate2D)coord
{
    coordinate = coord;
    return self;
}

@end
