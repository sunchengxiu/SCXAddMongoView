//
//  MCCoverView.m
//  给按钮添加蒙版
//
//  Created by 孙承秀 on 2017/2/22.
//  Copyright © 2017年 孙承秀. All rights reserved.
//

#import "MCCoverView.h"
#define HexAlphaColor(rgbValue, alp) [UIColor colorWithRed:((float) ((rgbValue & 0xFF0000) >> 16)) / 255.0 green:((float) ((rgbValue & 0xFF00) >> 8)) / 255.0 blue:((float) (rgbValue & 0xFF)) / 255.0 alpha:alp]
#define MongoliaColor HexAlphaColor(0x000000, 0.7)

@implementation MCCoverView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
       
    }
    return self;
}

#pragma mark - 初始化矩形蒙版
- (instancetype)initWithBackFrame:(CGRect)frame withRoundedRect:(CGRect)roundRect andCornerRadius:(CGFloat)radius hintImage:(UIImage *)image imageFrame:(CGRect)imageFrame{

    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        [self configRoundedRect:roundRect cornerRadius:radius];
        
        [self addHintImage:image imageRect:imageFrame];
        
        [self adddTapGesture];
    }
    return self;

}
-(instancetype)initWithBackFrame:(CGRect)frame withCircleCenter:(CGPoint)center andCircleRadius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle hintImage:(UIImage *)image imageFrame:(CGRect)imageFrame{
    if (self = [super initWithFrame:frame]) {
        
        [self configCircleViewWithframe:frame WithArcCenter:center radius:radius startAngle:startAngle endAngle:endAngle];
        
        [self addHintImage:image imageRect:imageFrame];
        
        [self adddTapGesture];
        
    }
    return self;
}
#pragma mark - 多个蒙版
-(instancetype)initWithBackFrame:(CGRect)frame withRoundRect:(NSArray<NSValue *> *)roundRectArr hintImage:(UIImage *)image imageFrame:(CGRect)imageFrame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self configMoreView:roundRectArr andHintImage:image imageRect:imageFrame];
    
        [self addHintImage:image imageRect:imageFrame];
        
        [self adddTapGesture];
        
    }
    return self;
    
}

#pragma mark - 设置矩形蒙版
- (void)configRoundedRect:(CGRect)roundedRect cornerRadius:(CGFloat)radius{

    // 先设置背景
    UIBezierPath *backPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))];
    
    // 设置矩形蒙版
    UIBezierPath *roundedPath = [UIBezierPath bezierPathWithRoundedRect:roundedRect cornerRadius:radius];
    
    [self remakeBezierPath:backPath andOtherPath:roundedPath];


}

#pragma mark - 配置圆形蒙版
- (void)configCircleViewWithframe:(CGRect)frame WithArcCenter:(CGPoint)center radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle{

    UIBezierPath *path = [UIBezierPath bezierPathWithRect:frame];
    
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];

    [self remakeBezierPath:path andOtherPath:circlePath];
    
}
#pragma mark - 配置多个蒙版
- (void)configMoreView:(NSArray *)arr andHintImage:(UIImage *)image imageRect:(CGRect )imageRect{

    UIBezierPath *path =[UIBezierPath bezierPathWithRect:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))];
    
    for (NSValue *valur in arr) {
        CGRect rect = [valur CGRectValue];
        UIBezierPath *rectPath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:2];
        [path appendPath:rectPath];
        [path setUsesEvenOddFillRule:YES];
        
    }
    CAShapeLayer *layer = [CAShapeLayer layer];
    
    layer.path = path.CGPath;
    
    layer.fillRule = kCAFillRuleEvenOdd;
    
    layer.fillColor = MongoliaColor.CGColor;
    
    [self.layer addSublayer:layer];
}
#pragma mark - 工具路径合成方法
- (void)remakeBezierPath:(UIBezierPath *)path andOtherPath:(UIBezierPath *)otherPath{

    [path appendPath:otherPath];
    
    [path setUsesEvenOddFillRule:YES];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    
    layer.path = path.CGPath;
    
    layer.fillRule = kCAFillRuleEvenOdd;
    
    layer.fillColor = MongoliaColor.CGColor;
    
    [self.layer addSublayer:layer];

}

#pragma mark - 配置引导视图
- (void)addHintImage:(UIImage *)image imageRect:(CGRect)imageRect{
    UIImageView *imageView= [[UIImageView alloc]initWithFrame:imageRect];
    imageView.image = image;
    [self addSubview:imageView];
}
- (void)adddTapGesture{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc ]initWithTarget:self action:@selector(tapClick)];
    [self addGestureRecognizer:tap];
}
- (void)tapClick{
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        NSLog(@"%@",_key);
        [[NSUserDefaults standardUserDefaults] setObject:@(NO) forKey:_key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }];
    
}
-(void)showInView:(UIView *)view{
    self.alpha = 0;
    [view addSubview:self];
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.5 animations:^{
        weakSelf.alpha = 1;
    }];
}
@end
