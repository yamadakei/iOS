//
//  CustomCell.m
//  TableCompPrac
//
//  Created by 山田 慶 on 2012/11/20.
//  Copyright (c) 2012年 山田 慶. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    
    [super setSelected:selected animated:YES];

    
}

//- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
//{
//    UIView *view = [[UIView alloc] initWithFrame:self.frame];
//    view.backgroundColor = [UIColor colorWithRed:.0 green:.0 blue:.125 alpha:1.0];
//    
//    self.selectedBackgroundView = view;
//    
//    [super setHighlighted:YES animated:YES];
//    
//    if(animated)
//    {
//        [CATransaction begin];
//        CATransition* animation = [CATransition animation];
//        animation.type = kCATransitionFade;
//        animation.duration = 2.0;
//        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
//        [view.layer addAnimation:animation forKey:@"Cell"];
//        [CATransaction commit];
//    }
//    
//    
//}


@end
