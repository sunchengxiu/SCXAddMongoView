//
//  MCCoverView.h
//  给按钮添加蒙版
//
//  Created by 孙承秀 on 2017/2/22.
//  Copyright © 2017年 孙承秀. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCCoverView : UIView

/*************  关键字 ***************/
@property ( nonatomic , copy )NSString *key;

/*************  绘制矩形蒙版 ***************/
- (instancetype)initWithBackFrame:(CGRect)frame withRoundedRect:(CGRect)roundRect andCornerRadius:(CGFloat)radius hintImage:(UIImage *)image imageFrame:(CGRect)imageFrame;


/*************  绘制弧形蒙版 ***************/
- (instancetype)initWithBackFrame:(CGRect)frame withCircleCenter:(CGPoint)center andCircleRadius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle hintImage:(UIImage *)image imageFrame:(CGRect)imageFrame;

/*************  绘制多个蒙版 ***************/
- (instancetype)initWithBackFrame:(CGRect)frame withRoundRect:(NSArray <NSValue *> *)roundRectArr  hintImage:(UIImage *)image imageFrame:(CGRect)imageFrame;


/*************  展示蒙版 ***************/
- (void)showInView:(UIView *)view;
@end
