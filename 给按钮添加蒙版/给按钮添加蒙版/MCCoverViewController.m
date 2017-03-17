//
//  MCCoverViewController.m
//  给按钮添加蒙版
//
//  Created by 孙承秀 on 2017/2/22.
//  Copyright © 2017年 孙承秀. All rights reserved.
//

#import "MCCoverViewController.h"
#import "MCCoverView.h"
@interface MCCoverViewController (){
    MCCoverView *_coverView;
    UIButton *_oneButton;
    
    UIButton *_twoButton;
}

@end

@implementation MCCoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *oneButton = ({
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(200, 200, 100, 50)];
        [btn setBackgroundColor:[UIColor blueColor]];
        [btn setTitle:@"矩形蒙版一" forState:UIControlStateNormal];
        btn;
    });
    _oneButton = oneButton;
    [self.view addSubview:oneButton];
    
    UIButton *twoButton = ({
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(200, 400, 100, 50)];
        [btn setBackgroundColor:[UIColor blueColor]];
        [btn setTitle:@"矩形蒙版二" forState:UIControlStateNormal];
        btn;
    });
    _twoButton = twoButton;
    [self.view addSubview:twoButton];
}

- (void)setType:(coverType)type{
    _type = type;
    NSString *typeStr = [NSString stringWithFormat:@"macan_%ld",type];
    
    // 判断一下是否设置过这个key了，如果设置过这个key、了，则下一次不会覆盖，这样做的目的是，用户第一次打开应用的时候，会出现蒙版，当用户取消了蒙版之后，后面都不会出现蒙版.
    [[NSUserDefaults standardUserDefaults] registerDefaults:@{typeStr : @(YES)}];
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:typeStr] boolValue]) {
        UIImage *hintImage = [UIImage imageNamed:@"recommend_mongolia"];
        CGRect imageRect = CGRectMake(_oneButton.frame.origin.x + _oneButton.frame.size.width / 2 - hintImage.size.width, _oneButton.frame.origin.y - hintImage.size.height, hintImage.size.width, hintImage.size.height);
        switch (type) {
                
            case coverTypeRound:
            {
                _coverView = [[MCCoverView alloc]initWithBackFrame:self.view.frame withRoundedRect:_oneButton.frame andCornerRadius:2 hintImage:hintImage imageFrame:imageRect];
                
            }
                break;
            case coverTypeCircle:{
                
                _coverView = [[MCCoverView alloc]initWithBackFrame:self.view.frame withCircleCenter:CGPointMake(_oneButton.center.x, _oneButton.frame.origin.y) andCircleRadius:sqrt((pow(_oneButton.frame.size.width / 2, 2)) + (pow(_oneButton.frame.size.height, 2)))  startAngle:0 endAngle:M_PI hintImage:hintImage imageFrame:imageRect];
                                
            }
                break;
            case coverTypeAll  :{
            
                _coverView = [[MCCoverView alloc]initWithBackFrame:self.view.bounds withRoundRect:@[[NSValue valueWithCGRect:_oneButton.frame] , [NSValue valueWithCGRect:_twoButton.frame]] hintImage:hintImage imageFrame:imageRect];
            }
                break;
                
            default:
                break;
        }
        if (_coverView) {
            _coverView.key = typeStr;
            [_coverView showInView:[[[UIApplication sharedApplication] delegate] window]];
        }
    }
    else{
        NSLog(@"点击过蒙版了");
    }
}
-(void)dealloc{
    // 测试可以不关闭，真实项目中可以关闭
    NSString *key = [NSString stringWithFormat:@"macan_%ld",_type];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
}

@end
