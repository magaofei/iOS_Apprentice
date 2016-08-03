//
//  ViewController.m
//  Checklists
//
//  Created by Mark MaMian on 16/8/2.
//  Copyright © 2016年 Mark MaMian. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()



@end

@implementation ViewController
{
    NSString *_row0text;
    NSString *_row1text;
    NSString *_row2text;
    NSString *_row3text;
    NSString *_row4text;   //存储ChecklistItem的值
    
    
    BOOL _row0checked;
    BOOL _row1checked;
    BOOL _row2checked;
    BOOL _row3checked;
    BOOL _row4checked;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _row0text = @"Walk the dog";
    _row1text = @"Brush teeth";
    _row2text = @"Learn iOS development";
    _row3text = @"Soccer practice";
    _row4text = @"Eat ice cream";//初始化
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;   //控制显示数量
}

//UITableViewCell

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChecklistItem"];   //对应的UITableViewCell的名称
    UILabel *label = (UILabel *) [cell viewWithTag:1000];
       //注意row  //列表显示的名称
    
    if (indexPath.row == 0) {   //传递值
        label.text = _row0text;
    } else if (indexPath.row == 1) {
        label.text = _row1text;
    } else if (indexPath.row == 2) {
        label.text = _row2text;
    } else if (indexPath.row == 3) {
        label.text = _row3text;
    } else if (indexPath.row == 4) {
        label.text = _row4text;
    }
    
    return cell;
}
//
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];  //绑定indexPath？
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    BOOL isChecked = NO;  //初始化为NO
    // UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.row == 0) { isChecked = _row0checked; _row0checked = !_row0checked;
    } else if (indexPath.row == 1) {
        isChecked = _row1checked;
        _row1checked = !_row1checked;
    } else if (indexPath.row == 2) {
        isChecked = _row2checked;
        _row2checked = !_row2checked;
    } else if (indexPath.row == 3) {
        isChecked = _row3checked;
        _row3checked = !_row3checked;
    } else if (indexPath.row == 4) {
        isChecked = _row4checked;
        _row4checked = !_row4checked;
    }
    if (isChecked) {
        cell.accessoryType = UITableViewCellAccessoryNone;  //如果被按下或者没有按下
       
    } else {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;  ///
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES]; }


@end
