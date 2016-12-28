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

- (void) addItemViewControllerDidCancel:(AddItemViewController *)controller{
    [self dismissViewControllerAnimated:YES completion:nil];   //点击取消按钮后, 画面消失
}

- (void) addItemViewController:   //done按钮按下后
(AddItemViewController *)controller didFinishAddingItem:(ChecklistItem *)item{
   
    NSInteger newRowIndex = [_items count]; //让现在的总数等于最新一个的行位置
    [_items addObject:item];  //添加一个新的item 到 NSMutableArray里
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:newRowIndex inSection:0];   //第几行?
    NSArray *indexPaths = @[indexPath];
    
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];  //插入
    
    [self dismissViewControllerAnimated:YES completion:nil]; //让画面消失
    
    
    
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

/**
 *  删除行功能
 *
 *  @param tableView    选择哪个tableView
 *  @param editingStyle 修改样式
 *  @param indexPath    行数索引
 */
- (void)tableView:(UITableView *)tableView

commitEditingStyle:(UITableViewCellEditingStyle)editingStyle

forRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    [_items removeObjectAtIndex:indexPath.row];  //不仅仅是告诉ChecklistItem的索引号，并且永久的删除了
    
    NSArray *indexPaths = @[indexPath];
    
    [tableView deleteRowsAtIndexPaths:indexPaths   //调用删除
    withRowAnimation:UITableViewRowAnimationAutomatic];
    
}






//-(IBAction) addItem {    //点击按钮后做的事情
//    NSInteger newRowIndex = [_items count];//NSMutbaleArray的长度  , 也就是 ChecklistItem的总个数  此时， 这个数的位置就是最新一个的空行，因为是从0开始的，所以下一个空行就等于总长度
//    ChecklistItem *item = [[ChecklistItem alloc] init]; //初始化
//    item.text = @"I am a new row";
//    item.checked = NO;
//    [_items addObject:item];
//    
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:newRowIndex inSection:0] ;  //把ChecklistItem的总个数赋值给 indexPathForRow 默认选择0
//    
//    NSArray *indexPaths = @[indexPath];//赋值为数组
//    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];  //调用  插入一个新行， 位置==现在的总长度， 格式自动
//    
//}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"AddItem"]) {  //如果转场是AddItem
        //1
        UINavigationController *navigationController = segue.destinationViewController;
        
        //2
        AddItemViewController *controller = (AddItemViewController *)navigationController.topViewController;
        
        //3
        controller.delegate = self;
        
    }
}



@end
