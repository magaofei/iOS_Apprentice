//
//  AddItemViewController.h
//  Checklists
//
//  Created by Mark MaMian on 16/8/6.
//  Copyright © 2016年 Mark MaMian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddItemViewController;
@class ChecklistItem;

@protocol AddItemViewControllerDelegate <NSObject>
- (void)addItemViewControllerDidCancel:(AddItemViewController *)controller;

- (void)addItemViewController:(AddItemViewController *)controller didFinishAddingItem:(ChecklistItem *)item;
@end

@interface AddItemViewController : UITableViewController
                        <UITextFieldDelegate>
@property (nonatomic,weak) id <AddItemViewControllerDelegate> delegate;

- (void) AddItemViewControllerDidCancel:(AddItemViewController *) controller;
@property (weak, nonatomic) IBOutlet UITableViewCell *textField;  //用来保存输入的字符

@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneBarButton;
//@property (weak,nonatomic) IBOutlet UIBarButtonItem *doneBarButton;
- (IBAction) cancel;
- (IBAction) done;

@end
