//
//  CustomCell.h
//  TableCompPrac
//
//  Created by 山田 慶 on 2012/11/20.
//  Copyright (c) 2012年 山田 慶. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlitchImageVIew.h"

@interface CustomCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbl1;
@property (weak, nonatomic) IBOutlet UILabel *lbl2;
@property (weak, nonatomic) IBOutlet GlitchImageVIew *cityImgView;

@end
