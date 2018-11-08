//
//  UIBarButtonItem+Extension.h
//  LDWeiBo01
//
//  Created by Experimental Computer on 2017/10/10.
//  Copyright © 2017年 Luxondata. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
/**
 创建导航条按钮
 */
+(UIBarButtonItem *)itemWithImage:(NSString *)image highlightImage:(NSString *)highlightImage target:(id)target action:(SEL)action;
@end
