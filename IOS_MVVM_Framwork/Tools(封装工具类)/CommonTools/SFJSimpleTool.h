//
//  SFJSimpleTool.h
//  SimpleShoppingMall
//
//  Created by Experimental Computer on 2018/8/1.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SFJSimpleTool : NSObject

/**
 设置控件的圆角
 
 @param anyControl 控件
 @param radius 圆角度
 @param width 边宽度
 @param borderColor 边线颜色
 @param can 是否裁剪
 @return 控件
 */
+(id)sfj_chageControlCircularWith:(id)anyControl AndSetCornerRadius:(NSInteger)radius SetBorderWidth:(NSInteger)width SetBorderColor:(UIColor *)borderColor canMasksToBounds:(BOOL)can;

/**
 选取部分数据变色（label）
 
 @param label label
 @param arrray 变色数组
 @param color 变色颜色
 @return label
 */
+(id)sfj_setSomeOneChangeColor:(UILabel *)label SetSelectArray:(NSArray *)arrray SetChangeColor:(UIColor *)color;

/**
 根据传入字体大小计算字体宽高
 */
+ (CGSize)sfj_calculateTextSizeWithText : (NSString *)text WithTextFont: (NSInteger)textFont WithMaxW : (CGFloat)maxW ;

/**
 触动
 */
+ (void)sfj_callFeedback;

/**
 label首行缩进
 
 @param label label
 @param emptylen 缩进比
 */
+ (void)sfj_setUpLabel:(UILabel *)label Content:(NSString *)content IndentationFortheFirstLineWith:(CGFloat)emptylen;


/**
 字符串加星处理
 
 @param content NSString字符串
 @param findex 第几位开始加星
 @return 返回加星后的字符串
 */
+ (NSString *)sfj_encryptionDisplayMessageWith:(NSString *)content WithFirstIndex:(NSInteger)findex;

/**
 下划线
 
 @param view 下划线
 */
+ (void)sfj_setUpAcrossPartingLineWith:(UIView *)view WithColor:(UIColor *)color WithWidthRatio:(CGFloat)ratio;

/**
 竖线线
 
 @param view 竖线线
 */
+ (void)sfj_setUpLongLineWith:(UIView *)view WithColor:(UIColor *)color WithHightRatio:(CGFloat)ratio;
@end
