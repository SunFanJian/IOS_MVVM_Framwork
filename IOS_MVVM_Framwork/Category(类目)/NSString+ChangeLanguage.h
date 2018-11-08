//
//  NSString+ChangeLanguage.h
//  HK_Sensor
//
//  Created by Experimental Computer on 2018/4/4.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SwitchLanguage.h"

@interface NSString (ChangeLanguage)
/**
 手动切换
 **/
+(NSString *)changeLanguage:(NSString *)string;
/**
 系统本地切换
 **/
+(NSString *)changeLanguageBySystem:(NSString *)string;
@end
