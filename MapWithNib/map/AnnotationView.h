//
//  AnnotationView.h
//  map
//
//  Created by 山田 慶 on 2012/12/11.
//  Copyright (c) 2012年 山田 慶. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "AnnoURLTextView.h"

@interface AnnotationView : MKAnnotationView

@property (nonatomic) UITextView *annoCityName;
@property (nonatomic) UIImageView *annoCityImg;
@property (nonatomic) AnnoURLTextView *annoCityURL;

//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
//-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
//-(UITextView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event;

//- (id)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier;

- (id)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier population:(NSString *)population cityImg:(NSString *)cityImg cityURL:(NSString *)cityURL;

@end
