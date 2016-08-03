//
//  ViewController.h
//  BullsEye
//
//  Created by Mark MaMian on 16/7/29.
//  Copyright © 2016年 Mark MaMian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIAlertViewDelegate> //You’re just adding <UIAlertViewDelegate> to the existing @interface line. This tells the app that your view controller is now a delegate of UIAlertView.

 - (IBAction)showAlert;//added to BullsEyeViewController.h lets Interface Builder know that the controller has a “showAlert” action, which presumably will show an alert view popup
- (IBAction)sliderMoved:(UISlider *)slider;  //声明 slider移动的IBAction
- (IBAction)startOver;
@property (nonatomic, weak) IBOutlet UISlider *slider;   // 为了让slider起作用 并连接
@property (nonatomic,weak) IBOutlet UILabel *targetlabel;
@property (nonatomic,weak) IBOutlet UILabel *scoreLabel;
@property (nonatomic, weak) IBOutlet UILabel *roundLabel;
@end

