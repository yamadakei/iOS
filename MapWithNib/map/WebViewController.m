//
//  WebViewController.m
//  map
//
//  Created by 山田 慶 on 2012/12/20.
//  Copyright (c) 2012年 山田 慶. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _webView.delegate = self;
    NSURL *url = [[NSURL alloc]initWithString:self.URLString];
    [_webView loadRequest:[NSURLRequest requestWithURL:url]];
    NSLog(@"%@",self.URLString);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebViewDelegate

- (void) webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"start");
}

- (void) webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"finish");
}

- (void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"%@",error);
}

#pragma mark - EventHandler

- (IBAction)backToTheFirstView:(id)sender {
    NSLog(@"back");
    [self removeFromParentViewController];
}
@end
