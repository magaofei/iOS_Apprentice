//
//  ViewController.m
//  NSURLSessionBackgroundData
//
//  Created by MAMIAN on 2016/12/14.
//  Copyright © 2016年 Gaofei Ma. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <NSURLSessionTaskDelegate>

@property (nonatomic, strong)NSURLSession *session;

@property (nonatomic, strong)NSMutableArray *arr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    [self getData];
//    [self getDataWithDelegate];
    
}

- (void)getDataWithDelegate {
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    _session = [NSURLSession sessionWithConfiguration:
                [NSURLSessionConfiguration defaultSessionConfiguration]
                                             delegate:self
                                        delegateQueue:[[NSOperationQueue alloc] init]];
    NSURLSessionTask *task = [_session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"data = %@", data);
        NSLog(@"%@", [NSThread currentThread]);
    }];
    [task resume];
    
}

- (void)getData{
    NSURL *url = [NSURL URLWithString:@"http://jwgl.ayit.edu.cn"];

    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    
    _session = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:nil];
    
    _arr = [NSMutableArray array];
    
    NSURLSessionDataTask *task = [_session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"task = %@", [NSThread currentThread]);
        NSString *str = [[NSString alloc] initWithData:data encoding:enc];
        
        /*  编码格式
        NSStringEncoding stringEncoding = NSUTF8StringEncoding;
        if (response.textEncodingName) {
            CFStringEncoding IANAEncoding = CFStringConvertIANACharSetNameToEncoding((__bridge CFStringRef)response.textEncodingName);
            if (IANAEncoding != kCFStringEncodingInvalidId) {
                stringEncoding = CFStringConvertEncodingToNSStringEncoding(IANAEncoding);
            }
        }
         
         */
        
        [_arr addObject:str];
        
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            _dataTextView.text = _arr[0];
//            NSLog(@"str = %@", _arr);
            
            NSLog(@"_dataTextView %@", [NSThread currentThread]);
        });
        
    }];
    
    [task resume];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
