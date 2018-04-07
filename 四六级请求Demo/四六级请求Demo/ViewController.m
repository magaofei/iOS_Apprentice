//
//  ViewController.m
//  四六级请求Demo
//
//  Created by MAMIAN on 2017/2/22.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import "ViewController.h"

#import <AFNetworking/AFNetworking.h>
#import <WebKit/WebKit.h>

@interface ViewController ()

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    [manager.requestSerializer setValue:@"http://www.chsi.com.cn/cet/" forHTTPHeaderField:@"Referer"];
    
    
//    [manager POST:@"http://www.chsi.com.cn/cet/query" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//        
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"失败%@", error);
//    }];
    

    
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"zkzh"] = @"150737301211223";
    parameters[@"xm"] = @"马高飞";
    
    
    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    _webView = webView;
    
    
    NSString *urlStr = [NSString stringWithFormat:@"%@?zkzh=%@&xm=%@",@"http://www.chsi.com.cn/cet/query", parameters[@"zkzh"], parameters[@"xm"]];
//    NSString *urlStr = [NSString stringWithFormat:@"%@",@"http://www.baidu.com"];
    
    
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:url];
    [urlRequest setValue:@"http://www.chsi.com.cn/cet/" forHTTPHeaderField:@"Referer"];
    //    urlRequest.HTTPMethod = @"POST";
    
    [webView loadRequest:urlRequest];
    [self.view addSubview:webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
