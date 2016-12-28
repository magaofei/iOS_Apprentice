//
//  ViewController.m
//  md5Demo
//
//  Created by MAMIAN on 2016/12/22.
//  Copyright © 2016年 Gaofei Ma. All rights reserved.
//

#import "ViewController.h"
#import <CommonCrypto/CommonDigest.h>
#import "NSString+Hash.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UILabel *user = [[UILabel alloc] initWithFrame:CGRectMake(50, 50, 70, 30)];
    
    [self.view addSubview:user];
    
    
    /* 
     dsdsdsdsdxcxdfgfg
     899750BC308351393886655930F225
     fgfggfdgtyuuyyuuckjg
     24CE4787736519A1F5AE27AC5CB18F
     */
    NSString *userStr = @"STU";
    userStr = [userStr md5String];
    userStr = [userStr substringWithRange:NSMakeRange(0, 29)];
    userStr = [userStr uppercaseString];
    NSMutableString *userMutableStr = [NSMutableString stringWithString:userStr];
    [userMutableStr appendString:@"11330"];
    
    userStr = [userMutableStr md5String];
    userStr = [userStr substringWithRange:NSMakeRange(0, 29)];
    userStr = [userStr uppercaseString];
    NSLog(@"%@", userStr);
    
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
