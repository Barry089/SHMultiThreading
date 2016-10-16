//
//  NSThreadLoadViewController.m
//  MultiThreading
//
//  Created by Li Zhe on 10/15/16.
//  Copyright © 2016 SH10. All rights reserved.
//

#import "NSThreadLoadViewController.h"

@interface NSThreadLoadViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *loadingLb;

- (IBAction)loadImage:(id)sender;
@end

@implementation NSThreadLoadViewController {
    NSString *_imgUrl;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _imgUrl = @"https://d262ilb51hltx0.cloudfront.net/fit/t/880/264/1*zF0J7XHubBjojgJdYRS0FA.jpeg";
}

- (void)loadImageSource:(NSString *)url {
    NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    UIImage *image = [UIImage imageWithData:imgData];
    
    if (imgData != nil) {
        [self performSelectorOnMainThread:@selector(refreshImageView:) withObject:image waitUntilDone:YES];
    } else {
        NSLog(@"there is not image data.");
    }
}

- (void)refreshImageView:(UIImage *)image {
    [self.loadingLb setHidden:YES];
    [self.imageView setImage:image];
}

//动态创建线程
- (void)dynamicCreateThread {
    
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(loadImageSource:) object:_imgUrl];
    thread.threadPriority = 1; // 设置线程的优先级（0.0 － 1.0，1.0优先级最高）
    [thread start];
}

//静态创建线程
- (void)staticCreateThread {
    
    [NSThread detachNewThreadSelector:@selector(loadImageSource:) toTarget:self withObject:_imgUrl];
}

//隐式创建线程
- (void)implicitCreateThread {
    
    [self performSelectorInBackground:@selector(loadImageSource:) withObject:_imgUrl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)loadImage:(id)sender {
    
    [self.loadingLb setHidden:NO];
    [self.imageView setImage:nil];
    
    NSInteger index = (NSInteger)((UIButton *)sender).tag;
    
    switch (index) {
        case 1:
            [self dynamicCreateThread];
            break;
        case 2:
            [self staticCreateThread];
            break;
        case 3:
            [self implicitCreateThread];
            break;
        default:
            break;
    }
}
@end
