//
//  ChecklistItem.h
//  Checklists
//
//  Created by Mark MaMian on 16/8/6.
//  Copyright © 2016年 Mark MaMian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChecklistItem : NSObject 

@property (nonatomic,copy) NSString *text;
@property (nonatomic,assign) BOOL checked;    //  分别代表ChecklistItem的文本和点击状态
- (void) toggleChecked;

@end
