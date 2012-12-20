//
//  Annotation.h
//  map
//
//  Created by 山田 慶 on 2012/12/06.
//  Copyright (c) 2012年 山田 慶. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Annotation : NSObject <MKAnnotation, MKMapViewDelegate>

@property (nonatomic,readonly) CLLocationCoordinate2D coordinate;

- (id) initWithCoordinate:(CLLocationCoordinate2D)coord;

@end
