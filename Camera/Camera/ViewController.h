//
//  ViewController.h
//  Camera
//
//  Created by 山田 慶 on 2013/01/08.
//  Copyright (c) 2013年 山田 慶. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIActionSheetDelegate, UIImagePickerControllerDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *imageVIew;

- (IBAction)showCameraSheet;

@end
