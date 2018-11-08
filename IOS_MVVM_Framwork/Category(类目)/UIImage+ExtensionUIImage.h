//
//  UIImage+ExtensionUIImage.h
//  LDWeiBo01
//
//  Created by Experimental Computer on 2017/9/21.
//  Copyright © 2017年 Luxondata. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ExtensionUIImage)
/**
 根据图片名自动加载适配IOS6、7的图片
 **/
+(UIImage *)imageWithName:(NSString *)name;
/**
 根据图片名返回一张自由拉伸的图片
 **/
+(UIImage *)resizeImageWithName:(NSString *)name;

/**
 用颜色绘制图片
 **/
+(UIImage *)imageWithColor:(UIColor *)aColor;

/**
 *  返回圆形图片
 */
- (instancetype)sfj_circleImage;

/**
 *  返回圆形图片
 *  @param name  图片名称
 */
+ (instancetype)sfj_circleImage:(NSString *)name;
@end
