//
//  AnnotationView.m
//  map
//
//  Created by 山田 慶 on 2012/12/11.
//  Copyright (c) 2012年 山田 慶. All rights reserved.
//

#import "AnnotationView.h"
#import <UIKit/UIKit.h>

@implementation AnnotationView
@synthesize annoCityName;
@synthesize annoCityURL;
@synthesize annoCityImg;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier population:(NSString *)population cityImg:(NSString *)cityImg cityURL:(NSString *)cityURL
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    
    if(self != nil)
    {
        CGRect frame = self.frame;
        frame.size = CGSizeMake(60.0, 85.0);
        self.frame = frame;
        self.backgroundColor = [UIColor clearColor];
        self.centerOffset = CGPointMake(0,-20);
        
        //人口
        annoCityName = [[UITextView alloc]initWithFrame:CGRectMake(100, 30, 120, 20)];
        annoCityName.text = population;
        annoCityName.backgroundColor = [UIColor clearColor];
        annoCityName.editable = NO;
        [self addSubview:annoCityName];
        
        //写真
        annoCityImg = [[UIImageView alloc]initWithFrame:CGRectMake(35, 25, 60, 50)];
        annoCityImg.image = [UIImage imageNamed:cityImg];
        [self addSubview:annoCityImg];
        
        //URL
        annoCityURL = [[AnnoURLTextView alloc]initWithFrame:CGRectMake(30, 70, 250, 20)];
        annoCityURL.text = cityURL;
        [annoCityURL setFont:[UIFont systemFontOfSize:9]];
        annoCityURL.backgroundColor = [UIColor clearColor];
        annoCityURL.editable = NO;
//        annoCityURL.dataDetectorTypes = UIDataDetectorTypeLink;
        [self addSubview:annoCityURL];
        
    }
    return self;
}

- (void)setAnnotation:(id<MKAnnotation>)annotation
{
    [super setAnnotation:annotation];
    [self setNeedsDisplay];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
