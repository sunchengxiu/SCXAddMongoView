//
//  MCCoverViewController.h
//  给按钮添加蒙版
//
//  Created by 孙承秀 on 2017/2/22.
//  Copyright © 2017年 孙承秀. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger , coverType) {
    coverTypeRound = 0,
    coverTypeCircle ,
    coverTypeAll
};
@interface MCCoverViewController : UIViewController

/*************  类型 ***************/
@property ( nonatomic , assign )coverType type;
@end
