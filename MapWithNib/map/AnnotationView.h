//
//  AnnotationView.h
//  map
//
//  Created by 山田 慶 on 2012/12/11.
//  Copyright (c) 2012年 山田 慶. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface AnnotationView : MKAnnotationView

@property (nonatomic) UITextView *annoCityName;
@property (nonatomic) UIImageView *annoCityImg;
@property (nonatomic) UITextView *annoCityURL;

//- (id)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier;

- (id)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier population:(NSString *)population cityImg:(NSString *)cityImg cityURL:(NSString *)cityURL;

@end
