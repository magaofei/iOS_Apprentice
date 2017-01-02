//
//  ViewController.m
//  NSURLSessionBackgroundData
//
//  Created by MAMIAN on 2016/12/14.
//  Copyright © 2016年 Gaofei Ma. All rights reserved.
//

#import "ViewController.h"
#import "TFHpple.h"
#import "AFNetworking.h"
#import "MKNewsItem.h"

@interface ViewController () <NSURLSessionTaskDelegate>

@property (nonatomic, strong)NSURLSession *session;

@property (nonatomic, strong)NSMutableArray *arr;

@property (nonatomic, strong) NSData *data;

@property (nonatomic, strong)NSDate * tmpStartDate;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
//    [self getData];
//    [self getDataWithDelegate];
   
    
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    _tmpStartDate = [NSDate date];
//    [self AFNetworkingLoadData];
    [self getData];
}

- (void)getDataWithDelegate {
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    _session = [NSURLSession sessionWithConfiguration:
                [NSURLSessionConfiguration defaultSessionConfiguration]
                                             delegate:self
                                        delegateQueue:[[NSOperationQueue alloc] init]];
    NSURLSessionTask *task = [_session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"data = %@", data);
        NSLog(@"%@", [NSThread currentThread]);
    }];
    [task resume];
    
}

- (void)getData{
    NSURL *url = [NSURL URLWithString:@"http://www.ayit.edu.cn/xwzx/ybdt.htm"];

    
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    
    NSMutableArray *newsGroup = [NSMutableArray array];
    
    TFHpple *hpple = [[TFHpple alloc] initWithHTMLData:data];
    //        TFHpple *hppleU = [[TFHpple alloc] initWithHTMLData:dataU];
    
    //参考网址 https://www.raywenderlich.com/14172/how-to-parse-html-on-ios
    //3
    NSString *pathQueryString = @"//div[@class='newslist l']/ul/li/a"; //
    NSArray *Nodes = [hpple searchWithXPathQuery:pathQueryString];//搜索这个css
    //        NSArray *NodesU = [hppleU searchWithXPathQuery:pathQueryString];//搜索这个css
    //4
    for (TFHppleElement *element in Nodes) {
        
        MKNewsItem *newsItem = [[MKNewsItem alloc] init];
        
        [newsGroup addObject:newsItem];
        
        // 6
        //                tutorial.title = [[element firstChild] content];
        newsItem.title = [element text];
        newsItem.time = [[element firstChildWithTagName:@"span"] content];
        NSMutableString *tempTime = [NSMutableString stringWithFormat:@"%@", newsItem.time];
        
        //删除时间前后的[]字符
        [tempTime replaceCharactersInRange:NSMakeRange(0, 1) withString:@""];
        [tempTime replaceCharactersInRange:NSMakeRange(10, 1) withString:@""];
        newsItem.time = tempTime;
        //获取第一个标签是span标签内容
        //返回每个属性的文字
        //        NSString *str = [element text];
        //        NSString *str2 = [[element firstChild] content];
        // 7
        newsItem.url = [NSURL URLWithString:[element objectForKey:@"href"]];
        
        //      学校网站没有添加日期
        //        NSLog(@"%@",tutorial.title);
        //        NSLog(@"%@",tutorial.url);
        //删除网址中多余的..
        NSMutableString *tempUrl = [NSMutableString stringWithFormat:@"http://www.ayit.edu.cn%@",newsItem.url.absoluteString];
        [tempUrl deleteCharactersInRange:NSMakeRange(22, 2)];  //删除那两个..
        newsItem.url = [NSURL URLWithString:tempUrl];
        
    }
    
    
    
    NSMutableString *str = [[NSMutableString alloc] init];
    for (MKNewsItem *s in newsGroup) {
        [str appendString:s.title];
    }
    self.dataTextView.text = str;
    
    NSLog(@"thread = %@", [NSThread currentThread]);
    
    double deltaTime = [[NSDate date] timeIntervalSinceDate:_tmpStartDate];
    NSLog(@"cost time = %f", deltaTime);

}

- (void)AFNetworkingLoadData {
    
    NSString *str=[NSString stringWithFormat:@"http://www.ayit.edu.cn/xwzx/ybdt.htm"];
    NSURL *url = [NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    // UTF－8
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    

//    session.requestSerializer= [AFHTTPRequestSerializer serializer];
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        //    session.responseSerializer.acceptableContentTypes = [NSSet
        //                                                         setWithObject:@"text/html"];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        [manager GET:str parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            // 请求下来的整个网页数据
            //        NSString *html = responseObject;
            _data = responseObject;
            
            dispatch_semaphore_signal(semaphore);
            
            NSLog(@"thread = %@", [NSThread currentThread]);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"发生错误！%@",error);
            dispatch_semaphore_signal(semaphore);
            
        }];
        // 在网络请求成功之前 信号量等待中
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);

        
    });
    
    dispatch_group_notify(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSMutableArray *newsGroup = [NSMutableArray array];
        
        TFHpple *hpple = [[TFHpple alloc] initWithHTMLData:_data];
        //        TFHpple *hppleU = [[TFHpple alloc] initWithHTMLData:dataU];
        
        //参考网址 https://www.raywenderlich.com/14172/how-to-parse-html-on-ios
        //3
        NSString *pathQueryString = @"//div[@class='newslist l']/ul/li/a"; //
        NSArray *Nodes = [hpple searchWithXPathQuery:pathQueryString];//搜索这个css
        //        NSArray *NodesU = [hppleU searchWithXPathQuery:pathQueryString];//搜索这个css
        //4
        for (TFHppleElement *element in Nodes) {
            
            MKNewsItem *newsItem = [[MKNewsItem alloc] init];
            
            [newsGroup addObject:newsItem];
            
            // 6
            //                tutorial.title = [[element firstChild] content];
            newsItem.title = [element text];
            newsItem.time = [[element firstChildWithTagName:@"span"] content];
            NSMutableString *tempTime = [NSMutableString stringWithFormat:@"%@", newsItem.time];
            
            //删除时间前后的[]字符
            [tempTime replaceCharactersInRange:NSMakeRange(0, 1) withString:@""];
            [tempTime replaceCharactersInRange:NSMakeRange(10, 1) withString:@""];
            newsItem.time = tempTime;
            //获取第一个标签是span标签内容
            //返回每个属性的文字
            //        NSString *str = [element text];
            //        NSString *str2 = [[element firstChild] content];
            // 7
            newsItem.url = [NSURL URLWithString:[element objectForKey:@"href"]];
            
            //      学校网站没有添加日期
            //        NSLog(@"%@",tutorial.title);
            //        NSLog(@"%@",tutorial.url);
            //删除网址中多余的..
            NSMutableString *tempUrl = [NSMutableString stringWithFormat:@"http://www.ayit.edu.cn%@",newsItem.url.absoluteString];
            [tempUrl deleteCharactersInRange:NSMakeRange(22, 2)];  //删除那两个..
            newsItem.url = [NSURL URLWithString:tempUrl];
            
        }
        
        NSLog(@"%@", newsGroup);
        dispatch_async(dispatch_get_main_queue(), ^{
            NSMutableString *str = [[NSMutableString alloc] init];
            for (MKNewsItem *s in newsGroup) {
                [str appendString:s.title];
            }
            self.dataTextView.text = str;
        });
        
        NSLog(@"thread = %@", [NSThread currentThread]);
        
        double deltaTime = [[NSDate date] timeIntervalSinceDate:_tmpStartDate];
        NSLog(@"cost time = %f", deltaTime);
        
    });
    
  
    
    
        // 网页有gbk编码有utf8编码，全部换成utf8
//        NSString *utf8HtmlStr = [html stringByReplacingOccurrencesOfString:@"<meta http-equiv=\"Content-Type\" content=\"text/html; charset=GBK\">" withString:@"<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">"];
//
//        // TFHpple解析的是data，转换成data
//        NSData *htmlDataUTF8 = [utf8HtmlStr dataUsingEncoding:NSUTF8StringEncoding];
//        // 开始解析
//        TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:htmlDataUTF8];
//        // 查找所有的 <div class="g-cell1"
//        // 因为首页的“小编推荐”是使用该class标示的，所以主要获取的是该种形式的小课程节目
//        NSArray *elements
//        = [xpathParser searchWithXPathQuery:@"//div[@class='g-cell1']"];
//        // 不存在则不继续执行
//        if ([elements count] <= 0) {
//            return;
//        }
//        // 以下只是示例解析第一个课程，循环即可全部解析
//        TFHppleElement *first = [elements firstObject];
//        // 完整写法
//        NSArray *arr = [first searchWithXPathQuery:@"//a[1]/@href"];
//        TFHppleElement *ele = [arr firstObject];
//        NSLog(@"网址链接：%@",[ele text]);
//        // 合并的写法
//        NSLog(@"图片链接：%@",[[[first searchWithXPathQuery:@"//img/@src"] firstObject] text]);
//        NSLog(@"标题：%@",[[[first searchWithXPathQuery:@"//h5"] firstObject] text]);
//        NSLog(@"副标题：%@",[[[first searchWithXPathQuery:@"//p"] firstObject] text]);
        
    
    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//    // 请求数据，设置成功与失败的回调函数
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        // 请求下来的整个网页数据
//        NSString *html = operation.responseString;
//        // 网页有gbk编码有utf8编码，全部换成utf8
//        NSString *utf8HtmlStr = [html stringByReplacingOccurrencesOfString:@"<meta http-equiv=\"Content-Type\" content=\"text/html; charset=GBK\">" withString:@"<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">"];
//        // TFHpple解析的是data，转换成data
//        NSData *htmlDataUTF8 = [utf8HtmlStr dataUsingEncoding:NSUTF8StringEncoding];
//        // 开始解析
//        TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:htmlDataUTF8];
//        // 查找所有的 <div class="g-cell1"
//        // 因为首页的“小编推荐”是使用该class标示的，所以主要获取的是该种形式的小课程节目
//        NSArray *elements
//        = [xpathParser searchWithXPathQuery:@"//div[@class='g-cell1']"];
//        // 不存在则不继续执行
//        if ([elements count] <= 0) {
//            return;
//        }
//        // 以下只是示例解析第一个课程，循环即可全部解析
//        TFHppleElement *first = [elements firstObject];
//        // 完整写法
//        NSArray *arr = [first searchWithXPathQuery:@"//a[1]/@href"];
//        TFHppleElement *ele = [arr firstObject];
//        NSLog(@"网址链接：%@",[ele text]);
//        // 合并的写法
//        NSLog(@"图片链接：%@",[[[first searchWithXPathQuery:@"//img/@src"] firstObject] text]);
//        NSLog(@"标题：%@",[[[first searchWithXPathQuery:@"//h5"] firstObject] text]);
//        NSLog(@"副标题：%@",[[[first searchWithXPathQuery:@"//p"] firstObject] text]);
//    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"发生错误！%@",error);
//    }];
    // 加入队列 开始执行
//    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//    [queue addOperation:operation];

}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
