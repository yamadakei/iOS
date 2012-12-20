//
//  ViewForMap.m
//  map
//
//  Created by 山田 慶 on 2012/12/17.
//  Copyright (c) 2012年 山田 慶. All rights reserved.
//

#import "ViewForMap.h"

@implementation ViewForMap

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    NSLog(@"view");
    return self;
}

- (id)initWithNib
{
    UIView *view = [[[NSBundle mainBundle] loadNibNamed:@"ViewForMap" owner:self options:nil] objectAtIndex:0];
    return view;
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
