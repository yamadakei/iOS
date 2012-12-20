//
//  CustomCell.m
//  map
//
//  Created by 山田 慶 on 2012/12/05.
//  Copyright (c) 2012年 山田 慶. All rights reserved.
//

#import "CustomCell.h"
#import "AnnotationView.h"

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

@end
