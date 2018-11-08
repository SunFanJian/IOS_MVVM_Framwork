//
//  UIColor+Additions.h
//  QMQZ_Rebuild
//
//  Created by admin on 15/8/24.
//  Copyright (c) 2015年 CL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Additions)

/**
 色值转换成颜色
 **/
+ (UIColor *)getColorWithHexString:(NSString*)hexColor;
/**
 色值转换成颜色
 **/
+ (UIColor *)getColorWithHexString:(NSString*)hexColor alpha:(CGFloat)alpha;

/**
 RGB转换成颜色
 **/
+ (UIColor *)getColorWithR:(int)r g:(int)g b:(int)b;
/**
 RGB转换成颜色
 **/
+ (UIColor *)getColorWithR:(int)r g:(int)g b:(int)b alpha:(CGFloat)alpha;

/**
 生成随机颜色
 */
+ (UIColor *)RandomColor;

@end
