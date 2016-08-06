//
//  ViewController.m
//  Checklists
//
//  Created by Mark MaMian on 16/8/2.
//  Copyright © 2016年 Mark MaMian. All rights reserved.
//

#import "ViewController.h"
#import "ChecklistItem.h"
@interface ViewController ()



@end

@implementation ViewController
{
    NSMutableArray *_items;   //存储一个NSMutableArray
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _items = [[NSMutableArray alloc] initWithCapacity:20];//初始化了20个
    ChecklistItem *item;
    
    item = [[ChecklistItem alloc] init];   //创建空间存储，初始化
    
    item.text = @"Walk the dog";
    
    item.checked = NO;
    [_items addObject:item];  //继承？  NSMutableArray _items 继承 ChecklistItem？
    
    item = [[ChecklistItem alloc] init];
    
    item.text = @"Brush my teeth";
    
    item.checked = YES;
    
    [_items addObject:item];
    
    item = [[ChecklistItem alloc] init];
    
    item.text = @"Learn iOS development";
    
    item.checked = YES;
    
    [_items addObject:item];
    
    item = [[ChecklistItem alloc] init];
    
    item.text = @"Soccer practice";
    
    item.checked = NO;
    
    [_items addObject:item];
    
    item = [[ChecklistItem alloc] init];
    
    item.text = @"Eat ice cream";
    
    item.checked = YES;
    
    [_items addObject:item];
    
    item = [[ChecklistItem alloc] init];   //自动申请注册为ChecklistItem
    
    item.text = @"Eat ice cream";
    
    item.checked = YES;
    
    [_items addObject:item];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_items count];   //控制显示数量 现在数量为NSMutableArray _items的总数
}



/**
 *  设置点击后的状态
 *
 *  @param cell UITableViewCell
 *  @param item ChecklistItem
 */
- (void)configureCheckmarkForCell:(UITableViewCell *)cell withChecklistItem:(ChecklistItem *)item    //默认 ChecklistItem 右边状态不点击
{                           //解决了点击两次才能取消ChecklistItem右边状态的问题
    //如果被按下或者没有按下
    if (item.checked) {    //如果被点击之后，更改后边的状态
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
        
    }
    
}

- (void)configureTextForCell:(UITableViewCell *)cell withChecklistItem:(ChecklistItem *)item{
    UILabel *label = (UILabel *)[cell viewWithTag:1000];//注意row  //列表显示的名称
    
    label.text = item.text;
    
}


/**
 *  类型为UITableViewCell的函数
 *
 *  @param tableView 哪个tableView
 *  @param indexPath 索引号
 *
 *  @return 返回cell
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChecklistItem"];   //对应的UITableViewCell的名称
    ChecklistItem *item = _items[indexPath.row];
    
    
       //调用两个设置函数 ，一个设置文本，一个设置点击状态
    [self configureTextForCell:cell withChecklistItem:item];
    [self configureCheckmarkForCell:cell withChecklistItem:item];
    
    return cell;
}
/**
 *  选中行数后更改按钮状态
 *
 *  @param tableView 选择哪个tableView
 *  @param indexPath 索引号
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];  //绑定indexPath？
    //让tableView 的索引赋值给本函数的UITableViewCell
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    //This asks the array for the ChecklistItem object at the index that corresponds with the row number.
    
    ChecklistItem *item = _items[indexPath.row];
    [item toggleChecked];   //取反
   // [item toggleChecked];   //这个还不清楚
    
    //调用
    [self configureCheckmarkForCell:cell withChecklistItem:item];
       
    [tableView deselectRowAtIndexPath:indexPath animated:YES]; }







@end
