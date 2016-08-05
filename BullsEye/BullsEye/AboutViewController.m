//
//  AboutViewController.m
//  BullsEye
//
//  Created by Mark MaMian on 16/7/31.
//  Copyright © 2016年 Mark MaMian. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"BullsEye" ofType:@"html"];  //应该是引用文件名 和 后缀名
    NSData *htmlData = [NSData dataWithContentsOfFile:htmlFile];   //先引用文件名
    //接着引用数据 ， NSData   来自  html文件
    //接着引用NSURL  链接地址   从本地调用
    //最后 ，再设置 webView 设置 其数据， 网页格式 ，编码格式 ，和网址 （NSURL）
    NSURL *baseURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
    [self.webView loadData:htmlData MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:baseURL];  //调用   格式是UTF-8
    
    
    
    
    
    
    
    
    
    
    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)close{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];//点击按钮后执行  
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
