//
//  MKNewsItem.h
//  AyitHelperOC
//
//  Created by Mark MaMian on 2016/9/27.
//  Copyright © 2016年 Mark MaMian. All rights reserved.
//
//处理模型数据
#import <Foundation/Foundation.h>
@interface MKNewsItem : NSObject

@property (nonatomic, copy) NSString *title; //标题
@property (nonatomic, copy) NSString *time; //发表时间

//更改为NSString 更有利于存储
@property (nonatomic, copy) NSURL *url; // 文章链接

+ (instancetype)MKNewsItem;

+ (instancetype)MKNewsItemWithDict:(NSDictionary *)dict;

- (instancetype)initWithDict:(NSDictionary *)dict;


@end
