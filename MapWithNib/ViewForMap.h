//
//  ViewForMap.h
//  map
//
//  Created by 山田 慶 on 2012/12/17.
//  Copyright (c) 2012年 山田 慶. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ViewForMap : UIView
@property (weak, nonatomic) IBOutlet MKMapView *map;
//@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;

- (id)initWithNib;

@end
