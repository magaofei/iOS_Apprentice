//
//  ViewController.m
//  TFHppleWithAFNetworking2x
//
//  Created by MAMIAN on 2017/1/1.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking/AFNetworking.h"
#import "TFHpple.h"
#import "MKNewsItem.h"

@interface ViewController ()

@property (nonatomic, strong)NSDate * tmpStartDate;

@property (nonatomic, strong)UITextView *dataTextView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _dataTextView = [[UITextView alloc]
                     initWithFrame:CGRectMake(30, 30, 200, 200)];
    [self.view addSubview:_dataTextView];
    
//    [self wangyi];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    _tmpStartDate = [NSDate date];
    [self wangyi];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)wangyi {
    
    
    NSString *str=[NSString stringWithFormat:@"http://www.ayit.edu.cn/xwzx/ybdt.htm"];
    NSURL *url = [NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    // UTF－8
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    // 请求数据，设置成功与失败的回调函数
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        // 请求下来的整个网页数据
//        NSString *html = operation.responseString;
        NSData *responseData = responseObject;
        
        
        NSMutableArray *newsGroup = [NSMutableArray array];
        
        TFHpple *hpple = [[TFHpple alloc] initWithHTMLData:responseData];
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
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSMutableString *str = [[NSMutableString alloc] init];
            for (MKNewsItem *s in newsGroup) {
                [str appendString:s.title];
            }
            self.dataTextView.text = str;
        });

        
        
        
        NSLog(@"%@", newsGroup);
        
        double deltaTime = [[NSDate date] timeIntervalSinceDate:_tmpStartDate];
        NSLog(@"cost time = %f", deltaTime);
        
        // 网页有gbk编码有utf8编码，全部换成utf8
//        NSString *utf8HtmlStr = [html stringByReplacingOccurrencesOfString:@"<meta http-equiv=\"Content-Type\" content=\"text/html; charset=gbk\">" withString:@"<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">"];
//        // TFHpple解析的是data，转换成data
//        NSData *htmlDataUTF8 = [utf8HtmlStr dataUsingEncoding:NSUTF8StringEncoding];
//        // 开始解析
//        TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:htmlDataUTF8];
//        // 查找所有的 <div class="g-cell1"
//        // 因为首页的“小编推荐”是使用该class标示的，所以主要获取的是该种形式的小课程节目
//        NSArray *elements
//        = [xpathParser searchWithXPathQuery:@"//div[@class='g-container m-openEC']"];
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
        NSLog(@"thread = %@", [NSThread currentThread]);
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"发生错误！%@",error);
    }];
    // 加入队列 开始执行
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
}


@end
