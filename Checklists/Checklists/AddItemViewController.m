//
//  AddItemViewController.m
//  Checklists
//
//  Created by Mark MaMian on 16/8/6.
//  Copyright © 2016年 Mark MaMian. All rights reserved.
//

#import "AddItemViewController.h"
#pragma mark - Table view data source
@implementation AddItemViewController
- (IBAction) cancel{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];   //self后用点语法    这两个都是用来让视图消失的
}

- (IBAction)done{
    
    [self.presentingViewController
     dismissViewControllerAnimated:YES completion:nil];
    
}



@end
