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


@protocol AddItemViewControllerDelegate <NSObject>  //协议

- (void)addItemViewControllerDidCancel:(AddItemViewController *)controller;

- (void)addItemViewController:(AddItemViewController *)controller didFinishAddingItem:(ChecklistItem *)item; //当done按下后 

@end

@interface AddItemViewController : UITableViewController
<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneBarButton;

@property (nonatomic, weak) id <AddItemViewControllerDelegate> delegate;

- (IBAction)cancel;
- (IBAction)done;

@end

