//
//  ViewController.m
//  多线程
//
//  Created by MAMIAN on 2016/12/24.
//  Copyright © 2016年 Gaofei Ma. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    [self async];
//    [self blockOpeation];
    [self asyncWithSerial];
}

- (void)asyncWithSerial {
    dispatch_queue_t queue = dispatch_queue_create("0", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        NSLog(@"1");
    });
    
    dispatch_async(queue, ^{
        NSLog(@"2");
    });
    // 异步串行
}

- (void)asyncWithCONCURRENT {
    dispatch_queue_t queue = dispatch_queue_create("0", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        NSLog(@"1");
    });
    
    dispatch_async(queue, ^{
        NSLog(@"2");
    });
    // 有可能是1 2 也可能是2 1
}

- (void)blockOpeation {
    NSBlockOperation *op =
    [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"1");
    }];
    op.completionBlock = ^(){
        NSLog(@"2");
    };
    [[NSOperationQueue mainQueue] addOperation:op];
    [op cancel];  // 取消了blockOperation的执行， 但是completionBlock 无论取消不取消都还会执行
}

- (void)async {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"1");
    });
    NSLog(@"2");
}

- (void)sync {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"1");
        });
        NSLog(@"2");
        
    });
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
