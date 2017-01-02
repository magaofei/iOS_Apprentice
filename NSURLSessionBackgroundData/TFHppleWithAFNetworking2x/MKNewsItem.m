//
//  MKNewsItem.m
//  AyitHelperOC
//
//  Created by Mark MaMian on 2016/9/27.
//  Copyright © 2016年 Mark MaMian. All rights reserved.
//

#import "MKNewsItem.h"

@implementation MKNewsItem
+ (instancetype)MKNewsItem{
    return [[MKNewsItem alloc] init];
}

+ (instancetype)MKNewsItemWithDict:(NSDictionary *)dict{
    return [[MKNewsItem alloc] initWithDict:dict];
}


- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        MKNewsItem *new = [[MKNewsItem alloc] init];
//        [new setValuesForKeysWithDictionary:dict]; //从dict中寻找数据
        new.title = dict[@"title"];
        new.time = dict[@"time"];
        new.url = dict[@"url"];
        return new;
    }
    return self;
}

//在保存对象时告诉要保存当前对象哪些属性.
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.time forKey:@"time"];
    [aCoder encodeObject:self.url forKey:@"url"];
    
}

//当解析一个文件的时候调用.(告诉当前要解析文件当中哪些属性.)
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.time = [aDecoder decodeObjectForKey:@"time"];
        self.url = [aDecoder decodeObjectForKey:@"url"];
    }
    return self;
}







@end
