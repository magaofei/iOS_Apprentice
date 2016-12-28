//
//  ViewController.m
//  全屏滑动
//
//  Created by MAMIAN on 2016/12/28.
//  Copyright © 2016年 Gaofei Ma. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>


@interface ViewController () <UIGestureRecognizerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
     // 添加全屏滑动手势
    
    
    
    UIGestureRecognizer *ges = self.interactivePopGestureRecognizer;

    self.navigationItem.title = @"手势";
    /**
     获取类下成员变量的列表
     class_copyIvarList,只能获取某一个类下面的成员属性,也就是不能获取他的子类,或者父类的成员属性,所以我们必须要获取他爷爷类下面的成员属性,因为根据推测,target在UIPanGestureRecognizer这个类下面,因为
     */
//    unsigned int outCount = 0;
//    Ivar *ivars = class_copyIvarList([UIGestureRecognizer class], &outCount);
//    for (int i = 0; i < outCount; i++) {
//        //ivar_getName 获取某一个成员变量下面的名称,因为这个方法返回的类型是const char *所以需要把char转换为NSString,直接包装成对象就可以了
//        NSString *name = @(ivar_getName(ivars[i]));
//        
//        NSLog(@"%@",name);
//    }
    NSArray *targetArray = [ges valueForKeyPath:@"_targets"];
    id tempTarget = targetArray[0];
    id target = [tempTarget valueForKeyPath:@"_target"];
    NSLog(@"-- target%@", target);
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    [self.view addGestureRecognizer:pan];
    
    pan.delegate = self;
}


- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (self.viewControllers.count > 1) {
        return YES;
    } else {
        return NO;
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
