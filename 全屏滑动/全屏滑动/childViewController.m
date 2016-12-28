//
//  childViewController.m
//  全屏滑动
//
//  Created by MAMIAN on 2016/12/28.
//  Copyright © 2016年 Gaofei Ma. All rights reserved.
//

#import "childViewController.h"
#import "child2ViewController.h"

@interface childViewController ()

@end

@implementation childViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.title = @"手势";
    
    
    UIButton *push = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 70, 30)];
    push.titleLabel.text = @"push";
    push.titleLabel.textColor = [UIColor blueColor];
    push.backgroundColor = [UIColor purpleColor];
    [push addTarget:self action:@selector(toChild2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:push];
}

- (void)toChild2 {
    child2ViewController *child2VC = [[child2ViewController alloc] init];
    [self.navigationController pushViewController:child2VC animated:YES];
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

@end
