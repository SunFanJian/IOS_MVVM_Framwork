//
//  UIBarButtonItem+Extension.m
//  LDWeiBo01
//
//  Created by Experimental Computer on 2017/10/10.
//  Copyright © 2017年 Luxondata. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

+(UIBarButtonItem *)itemWithImage:(NSString *)image highlightImage:(NSString *)highlightImage target:(id)target action:(SEL)action
{
    UIButton *NavButton=[[UIButton alloc]init];
    [NavButton setBackgroundImage:[UIImage imageWithName:image] forState:UIControlStateNormal];
    [NavButton setBackgroundImage:[UIImage imageWithName:highlightImage] forState:UIControlStateHighlighted];
    //设置按钮的尺寸为其背景图片的尺寸
    NavButton.size=NavButton.currentBackgroundImage.size;
    [NavButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:NavButton];
}
@end
