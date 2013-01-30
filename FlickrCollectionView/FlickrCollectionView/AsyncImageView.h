//
//  AsyncImageView.h
//  FlickrCollectionView
//
//  Created by 山田 慶 on 2013/01/30.
//  Copyright (c) 2013年 山田 慶. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AsyncImageView : UIImageView{

    NSURLConnection *conn;
    NSMutableData *data;
}

-(void)loadImage:(NSString *)url;

@end
