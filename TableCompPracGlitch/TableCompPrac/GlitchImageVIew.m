//
//  GlitchImageVIew.m
//  GLitchImage
//
//  Created by 山田 慶 on 2012/11/27.
//  Copyright (c) 2012年 山田 慶. All rights reserved.
//

#import "GlitchImageVIew.h"

@implementation GlitchImageVIew
{
    NSArray *glitchArr;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) prepareForGlitch
{
    NSMutableArray *tempArr = [[NSMutableArray alloc]init];
    for(int j = 0; j < 12; j++){
        NSData *data = UIImageJPEGRepresentation(self.image, 0.8);
        NSMutableData *mutableData = [NSMutableData dataWithData:data];
        for (int i = 0; i < 32; i++) {
            int rand = ((random()*10000) % ([mutableData length] - 1024) + 1024);
            [mutableData resetBytesInRange:NSMakeRange(rand, 1)];
        }
        UIImage *imageFromData = [UIImage imageWithData:mutableData];
        [tempArr addObject:imageFromData];
    }
    glitchArr = [[NSArray alloc]initWithArray:tempArr];
}

- (void) glitch
{
    self.animationImages = glitchArr;
    self.animationDuration = 0.7;
    [self startAnimating];
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
