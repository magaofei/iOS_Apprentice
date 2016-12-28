//
//  AddItemViewController.m
//  Checklists
//
//  Created by Mark MaMian on 16/8/6.
//  Copyright © 2016年 Mark MaMian. All rights reserved.
//

#import "AddItemViewController.h"
#import "ChecklistItem.h"
#pragma mark - Table view data source
@implementation AddItemViewController


- (IBAction) cancel{
//    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];   //self后用点语法    这两个都是用来让视图消失的
    
    [self.delegate addItemViewControllerDidCancel:self];//调用自己
}

- (IBAction)done
{
    ChecklistItem *item = [[ChecklistItem alloc] init];
    item.text = self.textField.text;
    item.checked = NO;
    
    [self.delegate addItemViewController:self didFinishAddingItem:item];
}

- (NSIndexPath *)tableView:(UITableView *)tableView   //当选中这一行的时候，什么也不做
  willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

- (void) viewWillAppear:(BOOL)animated{   //添加？
    [super viewWillAppear:animated];  //决定是否让父类视图显示
    [self.textField becomeFirstResponder];
}

/**
 *  textField格式的函数，用来判断，当用户输入时更改doneBarButton.enabled的值 ，目的的是为了在前端进行控制，防止输入空值就点击Done
 *
 *  @param theTextField 选择textField
 *  @param range        <#range description#>
 *  @param string       <#string description#>
 *
 *  @return <#return value description#>
 */
- (BOOL)textField:(UITextField *)theTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
      //创建一个新的Text
    NSString *newText = [theTextField.text stringByReplacingCharactersInRange:range withString:string];
    
    self.doneBarButton.enabled = ([newText length] > 0);   //大于0 时
    return YES;
}




@end
