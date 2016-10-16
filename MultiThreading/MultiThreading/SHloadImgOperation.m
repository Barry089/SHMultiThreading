//
//  SHloadImgOperation.m
//  MultiThreading
//
//  Created by Li Zhe on 10/15/16.
//  Copyright © 2016 SH10. All rights reserved.
//

#import "SHloadImgOperation.h"

@implementation SHloadImgOperation

- (void)main {
    
    if (self.isCancelled) {
        return;
    }
    
    NSURL *url = [NSURL URLWithString:self.imgUrl];
    NSData *imageData = [NSData dataWithContentsOfURL:url];
    
    if (self.isCancelled) {
        url = nil;
        imageData = nil;
        return;
    }
    
    UIImage *image = [UIImage imageWithData:imageData];
    
    if (self.isCancelled) {
        image = nil;
        return;
    }
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(loadFinishedWithImage:)]) {
        
        [(NSObject *)self.delegate performSelectorOnMainThread:@selector(loadFinishedWithImage:) withObject:image waitUntilDone:NO];
    }
}
@end
