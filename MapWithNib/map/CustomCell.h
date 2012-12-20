//
//  CustomCell.h
//  map
//
//  Created by 山田 慶 on 2012/12/05.
//  Copyright (c) 2012年 山田 慶. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
//#import "MapView.h"
#import "AnnotationView.h"
#import "ViewForMap.h"


@interface CustomCell : UITableViewCell<MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *cityName;
@property (weak, nonatomic) IBOutlet UILabel *latitude;
@property (weak, nonatomic) IBOutlet UILabel *longitude;
@property (weak, nonatomic) IBOutlet ViewForMap *viewForMap;

@property (nonatomic) AnnotationView *annotationView;

@end
