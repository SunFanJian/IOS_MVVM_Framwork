//
//  SwitchLanguage.h
//  HK_Sensor
//
//  Created by Experimental Computer on 2018/4/4.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SwitchLanguage : NSObject

/**
获取当前资源文件
 **/
+(NSBundle *)bundle;    
/**
初始化语言文件
 **/
+(void)initUserLanguage;
/**
 获取应用当前语言
 **/
+(NSString *)userLanguage;
/**
设置当前语言
 **/
+(void)setUserLanguage:(NSString *)language;

@end
