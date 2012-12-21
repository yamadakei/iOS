//
//  AnnoURLTextView.m
//  map
//
//  Created by 山田 慶 on 2012/12/21.
//  Copyright (c) 2012年 山田 慶. All rights reserved.
//

#import "AnnoURLTextView.h"
#import "WebViewController.h"
#import "TableViewController.h"

@implementation AnnoURLTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

#pragma mark - EventHandler

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    WebViewController *webViewController = [[WebViewController alloc]initWithNibName:@"WebViewController" bundle:nil];
    TableViewController *currentController = self.window.rootViewController;
    [currentController presentViewController:webViewController animated:YES completion:nil];
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
