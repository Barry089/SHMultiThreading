//
//  SHloadImgOperation.h
//  MultiThreading
//
//  Created by Li Zhe on 10/15/16.
//  Copyright © 2016 SH10. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol SHloadImgDelegate <NSObject>

- (void)loadFinishedWithImage:(UIImage *)image;

@end

@interface SHloadImgOperation : NSOperation

@property (nonatomic, copy) NSString *imgUrl;
@property (nonatomic, assign) id <SHloadImgDelegate> delegate;
@end
