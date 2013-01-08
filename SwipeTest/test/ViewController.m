//
//  ViewController.m
//  test
//
//  Created by 山田 慶 on 2013/01/08.
//  Copyright (c) 2013年 山田 慶. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

{
    IBOutlet UIScrollView *scrollView;
}

const CGFloat kScrollObjHeight = 460.0;
const CGFloat kScrollObjWidth  = 320.0;
const NSUInteger kNumImages    = 3;

- (void)layoutScrollImages
{
    UIImageView *view = nil;
    NSArray *subviews = [scrollView subviews];
    
    CGFloat curXLoc = 0;
    for (view in subviews)
    {
        if ([view isKindOfClass:[UIImageView class]] && view.tag > 0)
        {
            CGRect frame = view.frame;
            frame.origin = CGPointMake(curXLoc, 40);
            view.frame = frame;
            
            curXLoc += (kScrollObjWidth);
        }
    }
    
    [scrollView setContentSize:CGSizeMake((kNumImages * kScrollObjWidth), kScrollObjHeight)];
}

- (void)viewDidLoad {
    NSUInteger i;
    for (i = 1; i <= kNumImages; i++)
    {
        NSString *imageName = [NSString stringWithFormat:@"img%d.png", i];
        UIImage *image = [UIImage imageNamed:imageName];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        
        CGRect rect = imageView.frame;
        rect.size.height = kScrollObjHeight;
        rect.size.width = kScrollObjWidth;
        imageView.frame = rect;
        imageView.tag = i;
        [scrollView addSubview:imageView];
    }
    
    [self layoutScrollImages];
}
@end
