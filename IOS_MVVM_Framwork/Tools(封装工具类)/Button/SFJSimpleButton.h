//
//  SFJSimpleButton.h
//  SimpleShoppingMall
//
//  Created by Experimental Computer on 2018/8/2.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    imageTop = 0,   // 图片上 标题下
    imageLeft,      // 图片左 标题右
    imageBottom,    // 图片下 标题上
    imageRight,     // 图片右 标题左
}ButtonImageStyle;

@interface SFJSimpleButton : UIButton
/** 按钮布局样式 */
@property(nonatomic , assign)ButtonImageStyle buttonStyle;
@end
