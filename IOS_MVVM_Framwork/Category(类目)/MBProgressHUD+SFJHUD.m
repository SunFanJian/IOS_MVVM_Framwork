//
//  MBProgressHUD+SFJHUD.m
//  IOS_MVVM_Framwork
//
//  Created by Experimental Computer on 11/8/18.
//  Copyright © 2018 Luxondata. All rights reserved.
//

#import "MBProgressHUD+SFJHUD.h"

@implementation MBProgressHUD (SFJHUD)

#pragma mark 显示错误信息
+ (void)showError:(NSString *)error ToView:(UIView *)view{
    [self showCustomIcon:@"MBHUD_Error" Title:error ToView:view Duration:2];
}

+ (void)showSuccess:(NSString *)success ToView:(UIView *)view
{
    [self showCustomIcon:@"MBHUD_Success" Title:success ToView:view Duration:2];
}

+ (void)showInfo:(NSString *)Info ToView:(UIView *)view
{
    [self showCustomIcon:@"MBHUD_Info" Title:Info ToView:view Duration:2];
}

+ (void)showWarn:(NSString *)Warn ToView:(UIView *)view
{
    [self showCustomIcon:@"MBHUD_Warn" Title:Warn ToView:view Duration:2];
}

#pragma mark 显示一些信息
+ (MBProgressHUD *)showMessage:(NSString *)message ToView:(UIView *)view {
    if (view == nil) view = (UIView*)[UIApplication sharedApplication].delegate.window;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode=MBProgressHUDModeText;
    hud.label.text=message;
    hud.label.font= [UIFont systemFontOfSize:15];
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    //代表需要蒙版效果
    
    //    hud.dimBackground = YES;
    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    return hud;
}

//加载视图
+(void)showLoadToView:(UIView *)view{
    [self showMessage:@"加载中..." ToView:view];
}


/**
 *  进度条View
 */
+ (MBProgressHUD *)showProgressToView:(UIView *)view Text:(NSString *)text{
    if (view == nil) view = (UIView*)[UIApplication sharedApplication].delegate.window;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text=text;
    hud.label.font= [UIFont systemFontOfSize:15];
    // 代表需要蒙版效果
    hud.backgroundView.style = MBProgressHUDBackgroundStyleBlur;
    
    return hud;
}


//快速显示一条提示信息
+ (void)showAutoMessage:(NSString *)message{
    
    [self showAutoMessage:message ToView:nil];
}


//自动消失提示，无图
+ (void)showAutoMessage:(NSString *)message ToView:(UIView *)view{
    [self showMessage:message ToView:view RemainTime:1 Model:MBProgressHUDModeText];
}

//自定义停留时间，有图
+(void)showIconMessage:(NSString *)message ToView:(UIView *)view RemainTime:(CGFloat)time{
    [self showMessage:message ToView:view RemainTime:time Model:MBProgressHUDModeIndeterminate];
}

//自定义停留时间，无图
+(void)showMessage:(NSString *)message ToView:(UIView *)view RemainTime:(CGFloat)time{
    [self showMessage:message ToView:view RemainTime:time Model:MBProgressHUDModeText];
}

+(void)showMessage:(NSString *)message ToView:(UIView *)view RemainTime:(CGFloat)time Model:(MBProgressHUDMode)model{
    
    // 创建HUD
    MBProgressHUD *hud = [self createHUD:message ToView:view];
    //模式
    hud.mode = model;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // 代表需要蒙版效果
    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    // X秒之后再消失
    if (time > 0) {
         [hud hideAnimated:YES afterDelay:time];
    }
}

+ (void)showCustomIcon:(NSString *)iconName Title:(NSString *)title ToView:(UIView *)view Duration:(CGFloat)duration
{
    // 创建HUD
    MBProgressHUD *hud = [self createHUD:title ToView:view];
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:iconName]];
    
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 代表需要蒙版效果
    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    
    // x秒之后再消失
    if (duration > 0) {
        [hud hideAnimated:YES afterDelay:duration];
    }
}

+ (void)showCustomImagesHUDInView:(NSArray <UIImage *> *)images message:(NSString *)message ToView:(UIView *)view Duration:(CGFloat)duration
{
    // 创建HUD
    MBProgressHUD *hud = [self createHUD:message ToView:view];
    //设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 设置序列帧图片数组
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.animationImages = images;
    imageView.animationDuration = images.count * 0.1;
    imageView.animationRepeatCount = HUGE_VALF;
    [imageView startAnimating];
    hud.customView = imageView;
    
    if (duration > 0) {
         [hud hideAnimated:YES afterDelay:duration]; // 设置持续时间
    }
}

+(void)showGifImagesHUDInView:(NSString *)gifFileName message:(NSString *)message ToView:(UIView *)view Duration:(CGFloat)duration
{
    MBProgressHUD *hud = [self createHUD:message ToView:view];
    hud.mode = MBProgressHUDModeCustomView;
    
    //设置GIF图片
    NSString *gifFilePath = [[NSBundle mainBundle] pathForResource:gifFileName ofType:@"gif"];
    UIImage *gifImage = [self imageGIFWithData:[NSData dataWithContentsOfFile:gifFilePath]];
    UIImageView *gifImgView = [[UIImageView alloc]initWithImage:gifImage];
    hud.customView = gifImgView;
    
    if (duration > 0) {
        [hud hideAnimated:YES afterDelay:duration]; // 设置持续时间
    }
}

+ (void)hideHUDForView:(UIView *)view
{
    if (view == nil)
        view = (UIView*)[UIApplication sharedApplication].delegate.window;
    [self hideHUDForView:view animated:YES];
}

+ (void)hideHUD
{
    [self hideHUDForView:nil];
}


+(MBProgressHUD *)createHUD:(NSString *)message ToView:(UIView *)view
{
    if (view == nil)
        view = (UIView *)[UIApplication sharedApplication].delegate.window;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = message;
    hud.label.font = [UIFont systemFontOfSize:15];
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 代表需要蒙版效果 - 纯色背景
    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.style = MBProgressHUDBackgroundStyleBlur;
    
    return hud;
}

#pragma mark - Data -> Gif
+ (UIImage *)imageGIFWithData:(NSData *)data {
    if (!data) {
        return nil;
    }
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
    size_t count = CGImageSourceGetCount(source);
    UIImage *animatedImage;
    if (count <= 1) {
        animatedImage = [[UIImage alloc] initWithData:data];
    }
    else {
        NSMutableArray *images = [NSMutableArray array];
        NSTimeInterval duration = 0.0f;
        for (size_t i = 0; i < count; i++) {
            CGImageRef image = CGImageSourceCreateImageAtIndex(source, i, NULL);
            if (!image) {
                continue;
            }
            duration += [self p_frameDurationAtIndex:i source:source];
            [images addObject:[UIImage imageWithCGImage:image scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp]];
            CGImageRelease(image);
        }
        if (!duration) {
            duration = (1.0f / 10.0f) * count;
        }
        animatedImage = [UIImage animatedImageWithImages:images duration:duration];
    }
    CFRelease(source);
    return animatedImage;
}

+ (float)p_frameDurationAtIndex:(NSUInteger)index source:(CGImageSourceRef)source {
    float frameDuration = 0.1f;
    CFDictionaryRef cfFrameProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil);
    NSDictionary *frameProperties = (__bridge NSDictionary *)cfFrameProperties;
    NSDictionary *gifProperties = frameProperties[(NSString *)kCGImagePropertyGIFDictionary];
    NSNumber *delayTimeUnclampedProp = gifProperties[(NSString *)kCGImagePropertyGIFUnclampedDelayTime];
    if (delayTimeUnclampedProp) {
        frameDuration = [delayTimeUnclampedProp floatValue];
    }
    else {
        NSNumber *delayTimeProp = gifProperties[(NSString *)kCGImagePropertyGIFDelayTime];
        if (delayTimeProp) {
            frameDuration = [delayTimeProp floatValue];
        }
    }
    if (frameDuration < 0.011f) {
        frameDuration = 0.100f;
    }
    CFRelease(cfFrameProperties);
    return frameDuration;
}
@end
