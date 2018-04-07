//
//  ViewController.m
//  LocationDemo
//
//  Created by MAMIAN on 2017/2/25.
//  Copyright © 2017年 Gaofei Ma. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        NSLog(@"requestAlwaysAuthorization");
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    // 如果在ios9.0以后, 想要在后台获取用户位置,
    // 如果当前的授权状态是前台定位授权, 那么你需要勾选后台模式 location updates, 还要额外的设置以下属性为true
    // 注意: 如果设置这个属性为true, 那么必须勾选后台模式 BackgroundModes Update
    if ([self.locationManager respondsToSelector:@selector(allowsBackgroundLocationUpdates)]) {
        self.locationManager.allowsBackgroundLocationUpdates = YES;

    }
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    // 获取用户位置信息
    
    // 1. 创建位置管理者
    //        locationM = CLLocationManager()
    //
    //        // 1.1 block, 代理, 通知,
    //        locationM.delegate = self
    
    // 2. 实用位置管理者, 开始获取用户位置信息
    // 小经验: 如果以后实用位置管理者这个对象, 实现某个服务, 那么可以以startXX 开始某个服务  以 stopXX停止某个服务
    // 开始更新位置信息 ing, 意味着, 一旦调用了这个方法, 就会不断的刷新用户位置, 然后高武外界

    
    [self.locationManager startUpdatingLocation];
    
    // 设置过滤距离
    // 每隔100米定位一次
    // 1 111KM/100M
    // 如果最新的位置距离上一次的位置之间的物理距离, 大于这个值, 就会通过代理来告诉我们最新的位置数据
    self.locationManager.distanceFilter = 100;
    
    // 定位精确度
    //         kCLLocationAccuracyBestForNavigation // 最适合导航
    //         kCLLocationAccuracyBest; // 最好的
    //         kCLLocationAccuracyNearestTenMeters; // 附近10米
    //         kCLLocationAccuracyHundredMeters; // 附近100米
    //         kCLLocationAccuracyKilometer; // 附近1000米
    //         kCLLocationAccuracyThreeKilometers; // 附近3000米
    // 经验: 如果定位的精确度越高, 那么越耗电, 而且定位时间越长
    //
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    // 1.获取用户位置的对象
    CLLocation *location = [locations lastObject];
    // 当前位置
    CLLocationCoordinate2D coordinate = location.coordinate;
    // 转换为经纬度
    NSLog(@"纬度:%f 经度:%f", coordinate.latitude, coordinate.longitude);
    
    // 2.停止定位
    [manager stopUpdatingLocation];
    
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            NSLog(@"用户没有决定");
            break;
        case kCLAuthorizationStatusRestricted:
            NSLog(@"受限制");
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            NSLog(@"前台定位授权");
        case kCLAuthorizationStatusAuthorizedAlways:
            NSLog(@"后台持续定位");
        case kCLAuthorizationStatusDenied:
            NSLog(@"拒绝");
            if ([CLLocationManager locationServicesEnabled]) {
                // 真正被拒绝
                // 跳转到管理界面
            } else {
                // 当我们在App内部想要访问用户位置，但是当前的定位服务是关闭状态，那么系统会自动弹出一个窗口，快捷跳转到设置界面让用户设置
            }
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
