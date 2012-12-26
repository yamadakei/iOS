//
//  ViewController.m
//  UploadImageToWeb
//
//  Created by 山田 慶 on 2012/12/26.
//  Copyright (c) 2012年 山田 慶. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize webView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSURL *url = [NSURL URLWithString:@"http://codemafia.asia/~ldqy/test.php"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    request.HTTPMethod = @"POST";
    
    NSString *body = [NSString stringWithFormat:@"a=testA&b=testB&c=testC"];
    request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
    
    [webView loadRequest:request];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
