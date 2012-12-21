//
//  WebViewController.h
//  map
//
//  Created by 山田 慶 on 2012/12/20.
//  Copyright (c) 2012年 山田 慶. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic) NSString *URLString;
- (IBAction)backToTheFirstView:(id)sender;

@end
