//
//  MBProgressHUD+SFJHUD.h
//  IOS_MVVM_Framwork
//
//  Created by Experimental Computer on 11/8/18.
//  Copyright © 2018 Luxondata. All rights reserved.
//

#import "MBProgressHUD.h"

NS_ASSUME_NONNULL_BEGIN

@interface MBProgressHUD (SFJHUD)

/**
 *  自定义图片的提示
 *
 *  @param title 要显示的文字
 *  @param iconName 图片名称(建议不要太大的图片)
 *  @param view 要添加的view
 *  @param duration 持续时间
 */
+ (void)showCustomIcon:(NSString *)iconName Title:(NSString *)title ToView:(UIView *)view Duration:(CGFloat)duration;

/**
 在 view 展示自定义序列帧图片 - 图片数组外界传入
 
 @param images 序列帧
 @param message 提示语
 @param view 要添加的view
 @param duration 持续时间
 */
+ (void)showCustomImagesHUDInView:(NSArray <UIImage *> *)images message:(NSString *)message ToView:(UIView *)view Duration:(CGFloat)duration;

/**
 在 View 展示自定义GIF图片 - 传入Gif 文件名
 
 @param gifFileName Gif 文件名
 @param message 提示语
 @param view 要添加的view
 @param duration 持续时间
 */
+ (void)showGifImagesHUDInView:(NSString *)gifFileName message:(NSString *)message ToView:(UIView *)view Duration:(CGFloat)duration;

/**
 *  自动消失成功提示，带默认图
 *
 *  @param success 要显示的文字
 *  @param view    要添加的view
 */
+ (void)showSuccess:(NSString *)success ToView:(UIView *)view;


/**
 *  自动消失错误提示,带默认图
 *
 *  @param error 要显示的错误文字
 *  @param view  要添加的View
 */
+ (void)showError:(NSString *)error ToView:(UIView *)view;


/**
 *  自动消失提示,带默认图
 *
 *  @param Info 要显示的文字
 *  @param view  要添加的View
 */
+ (void)showInfo:(NSString *)Info ToView:(UIView *)view;


/**
 *  自动消失提示,带默认图
 *
 *  @param Warn 要显示的文字
 *  @param view  要添加的View
 */
+ (void)showWarn:(NSString *)Warn ToView:(UIView *)view;

/**
 *  文字+菊花提示,不自动消失
 *
 *  @param message 要显示的文字
 *  @param view    要添加的View
 *
 *  @return MBProgressHUD
 */
+ (MBProgressHUD *)showMessage:(NSString *)message ToView:(UIView *)view;


/**
 *  快速显示一条提示信息
 *
 *  @param message 要显示的文字
 */
+ (void)showAutoMessage:(NSString *)message;


/**
 *  自动消失提示，无图
 *
 *  @param message 要显示的文字
 *  @param view    要添加的View
 */
+ (void)showAutoMessage:(NSString *)message ToView:(UIView *)view;


/**
 *  自定义停留时间，带菊花
 *
 *  @param message 要显示的文字
 *  @param view    要添加的View
 *  @param time    停留时间
 */
+(void)showIconMessage:(NSString *)message ToView:(UIView *)view RemainTime:(CGFloat)time;


/**
 *  自定义停留时间，无图
 *  @param view 要添加的View
 *  @param time 停留时间
 */
+(void)showMessage:(NSString *)message ToView:(UIView *)view RemainTime:(CGFloat)time;


/**
 *  加载视图
 *
 *  @param view 要添加的View
 */
+ (void)showLoadToView:(UIView *)view;



/**
 *  进度条View
 *
 *  @param view     要添加的View
 *  @param text     显示的文字
 *
 *  @return 返回使用
 */
+ (MBProgressHUD *)showProgressToView:(UIView *)view Text:(NSString *)text;


/**
 *  隐藏ProgressView
 *
 *  @param view superView
 
 */
+ (void)hideHUDForView:(UIView *)view;


/**
 *  快速从window中隐藏ProgressView
 */
+ (void)hideHUD;


@end

NS_ASSUME_NONNULL_END
