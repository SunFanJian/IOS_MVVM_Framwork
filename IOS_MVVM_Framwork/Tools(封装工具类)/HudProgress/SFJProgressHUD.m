//
//  SFJJProgressHUD.m
//  HK_Sensor
//
//  Created by Experimental Computer on 2018/4/9.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import "SFJProgressHUD.h"

// 背景视图的宽度/高度
#define BGVIEW_WIDTH 100.0f
// 文字大小
#define TEXT_SIZE    16.0f

__strong static SFJProgressHUD *hud = nil ;

@implementation SFJProgressHUD

+(instancetype)sharedHUD
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       hud = [[SFJProgressHUD alloc] initWithView:[UIApplication sharedApplication].keyWindow];
    });
    return hud;
}

+(void)showStatus:(SFJProgressHUDStatus)status text:(NSString *)text
{
    SFJProgressHUD *HUD = [SFJProgressHUD sharedHUD];
    HUD.bezelView.color = [UIColor blackColor];
    HUD.contentColor=[UIColor whiteColor];
    [HUD showAnimated:YES];
    [HUD setShowNow:YES];
    //蒙版显示 YES , NO 不显示
    //        HUD.dimBackground = YES;
    HUD.label.text = text;
    HUD.label.textColor = [UIColor whiteColor];
    [HUD setRemoveFromSuperViewOnHide:YES];
    HUD.label.font = [UIFont boldSystemFontOfSize:TEXT_SIZE];
    [HUD setMinSize:CGSizeMake(BGVIEW_WIDTH, BGVIEW_WIDTH)];
    [[UIApplication sharedApplication].keyWindow addSubview:HUD];
    
   // NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"SFJProgressHUD" ofType:@"bundle"];
    
    switch (status) {
            
        case SFJProgressHUDStatusSuccess: {
            
            //NSString *sucPath = [bundlePath stringByAppendingPathComponent:@"MBHUD_Success.png"];
//            UIImage *sucImage = [UIImage imageWithContentsOfFile:sucPath];
            UIImage *sucImage = [UIImage imageNamed:@"MBHUD_Success"];
            HUD.mode = MBProgressHUDModeCustomView;
            UIImageView *sucView = [[UIImageView alloc] initWithImage:sucImage];
            HUD.customView = sucView;
            [HUD hideAnimated:YES afterDelay:2.0f];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [HUD setShowNow:NO];
            });
        }
            break;
            
        case SFJProgressHUDStatusError: {
            
//            NSString *errPath = [bundlePath stringByAppendingPathComponent:@"MBHUD_Error.png"];
//            UIImage *errImage = [UIImage imageWithContentsOfFile:errPath];
             UIImage *errImage = [UIImage imageNamed:@"MBHUD_Error"];
            HUD.mode = MBProgressHUDModeCustomView;
            UIImageView *errView = [[UIImageView alloc] initWithImage:errImage];
            HUD.customView = errView;
            [HUD hideAnimated:YES afterDelay:2.0f];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [HUD setShowNow:NO];
            });
        }
            break;
            
        case SFJProgressHUDStatusLoading: {
            HUD.mode = MBProgressHUDModeIndeterminate;
        }
            break;
            
            
        case SFJProgressHUDStatusWaitting: {
//            NSString *infoPath = [bundlePath stringByAppendingPathComponent:@"MBHUD_Warn.png"];
//            UIImage *infoImage = [UIImage imageWithContentsOfFile:infoPath];
            UIImage *infoImage = [UIImage imageNamed:@"MBHUD_Warn"];
            
            HUD.mode = MBProgressHUDModeCustomView;
            UIImageView *infoView = [[UIImageView alloc] initWithImage:infoImage];
            HUD.customView = infoView;
            [HUD hideAnimated:YES afterDelay:2.0f];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [HUD setShowNow:NO];
            });
            
        }
            break;
            
        case SFJProgressHUDStatusInfo: {
            
//            NSString *infoPath = [bundlePath stringByAppendingPathComponent:@"MBHUD_Info.png"];
//            UIImage *infoImage = [UIImage imageWithContentsOfFile:infoPath];
            UIImage *infoImage = [UIImage imageNamed:@"MBHUD_Info"];
            HUD.mode = MBProgressHUDModeCustomView;
            UIImageView *infoView = [[UIImageView alloc] initWithImage:infoImage];
            HUD.customView = infoView;
            [HUD hideAnimated:YES afterDelay:2.0f];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [HUD setShowNow:NO];
            });
        }
            break;
            
        default:
            break;
    }
}

+ (void)showMessage:(NSString *)text {
    
    SFJProgressHUD *HUD = [SFJProgressHUD sharedHUD];
    HUD.bezelView.color = [UIColor blackColor];
    [HUD showAnimated:YES];
    [HUD setShowNow:YES];
    HUD.label.text = text;
    HUD.contentColor=[UIColor whiteColor];
    [HUD setMinSize:CGSizeZero];
    [HUD setMode:MBProgressHUDModeText];
    //    HUD.dimBackground = YES;
    [HUD setRemoveFromSuperViewOnHide:YES];
    HUD.label.font = [UIFont boldSystemFontOfSize:TEXT_SIZE];
    [[UIApplication sharedApplication].keyWindow addSubview:HUD];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[SFJProgressHUD sharedHUD] setShowNow:NO];
        [[SFJProgressHUD sharedHUD] hideAnimated:YES];
    });
}

+ (void)showWaiting:(NSString *)text {
    
    [self showStatus:SFJProgressHUDStatusWaitting text:text];
}

+ (void)showError:(NSString *)text {
    
    [self showStatus:SFJProgressHUDStatusError text:text];
}

+ (void)showSuccess:(NSString *)text {
    
    [self showStatus:SFJProgressHUDStatusSuccess text:text];
}

+ (void)showLoading:(NSString *)text {
    
    [self showStatus:SFJProgressHUDStatusLoading text:text];
}

+ (void)hideHUD {
    
    [[SFJProgressHUD sharedHUD] setShowNow:NO];
    [[SFJProgressHUD sharedHUD] hideAnimated:YES];
}
@end
