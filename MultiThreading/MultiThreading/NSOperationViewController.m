//
//  NSOperationViewController.m
//  MultiThreading
//
//  Created by Li Zhe on 10/15/16.
//  Copyright © 2016 SH10. All rights reserved.
//

#import "NSOperationViewController.h"
#import "SHloadImgOperation.h"

@interface NSOperationViewController () <SHloadImgDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *loadingLab;

- (IBAction)loadImage:(id)sender;
@end

@implementation NSOperationViewController {
    NSString *_imgUrl;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _imgUrl = @"https://d262ilb51hltx0.cloudfront.net/fit/t/880/264/1*kE8-X3OjeiiSPQFyhL2Tdg.jpeg";
}

// 使用子类NSInvocationOperation
- (void)useInvocationOperation {
    NSLog(@"invocation operation.....");
    NSInvocationOperation *invocationOperation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(loadImageSource:) object:_imgUrl];
    //[invocationOperation start];//直接会在当前线程主线程执行
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:invocationOperation];
}

//使用子类NSBlockOperation
- (void)useBlockOperation {
    
    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
        [self loadImageSource:_imgUrl];
    }];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:blockOperation];
}

- (void)loadImageSource:(NSString *)url {
    
    NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    UIImage *image = [UIImage imageWithData:imgData];
    if (imgData != nil) {
        [self performSelectorOnMainThread:@selector(refreshImageView1:) withObject:image waitUntilDone:YES];
    } else {
        NSLog(@"There is no image data!");
    }
}

- (void)refreshImageView1:(UIImage *)image {
    
    [self.loadingLab setHidden:YES];
    [self.imageView setImage:image];
}


//使用自定义的继承NSOperation的子类
- (void)useSubClassOperation {
    
    SHloadImgOperation *imgOperation = [SHloadImgOperation new];
    imgOperation.delegate = self;
    imgOperation.imgUrl = _imgUrl;
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:imgOperation];
}

- (void)loadFinishedWithImage:(UIImage *)image {
    [self.loadingLab setHidden:YES];
    [self.imageView setImage:image];
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
    
    [self.loadingLab setHidden:NO];
    [self.imageView setImage:nil];
    
    NSInteger index = (NSInteger)((UIButton *)sender).tag;
    switch (index) {
        case 1:
            [self useInvocationOperation];
            break;
        case 2:
            [self useBlockOperation];
        case 3:
            [self useSubClassOperation];
        default:
            break;
    }
}
@end
