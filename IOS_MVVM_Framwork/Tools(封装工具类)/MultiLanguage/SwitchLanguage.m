//
//  SwitchLanguage.m
//  HK_Sensor
//
//  Created by Experimental Computer on 2018/4/4.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import "SwitchLanguage.h"

static NSString *LocalLanguageKey = @"Localizable";

@implementation SwitchLanguage

static NSBundle *bundle = nil;

+(NSBundle *)bundle{
    return bundle;
}

//首次加载时检测语言是否存在
//初始化语言文件
+(void)initUserLanguage
{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *curLanguage = [def valueForKey:LocalLanguageKey];  //从plist中读取当前语言
    
    if(!curLanguage){
        NSArray *preferredLanguages = [NSLocale preferredLanguages];
        curLanguage = preferredLanguages[0];
        
        if([curLanguage hasPrefix:@"en"]){
            curLanguage  = @"en";   //英文
        }
        else if ([curLanguage hasSuffix:@"Hant"]){
            curLanguage = @"zh-Hant";   //繁体
                 }
        else
            curLanguage = @"zh-Hans";   //简体
        
        [def setValue:curLanguage forKey:LocalLanguageKey]; //设置当前语言(写入到plist文件中)
        [def synchronize];  //同步到文件里，避免数据的丢失
    }
    //获取文件路径
    NSString *path = [[NSBundle mainBundle]pathForResource:curLanguage ofType:@"lproj"];
    bundle = [NSBundle bundleWithPath:path];    //生成bundle目录
}

/**
 获取当前语言
 **/
+(NSString *)userLanguage
{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *language = [def valueForKey:LocalLanguageKey];
    return language;
}

//设置语言
+(void)setUserLanguage:(NSString *)language
{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *currLanguage = [def valueForKey:LocalLanguageKey];    //获取当前语言
    
    if([currLanguage isEqualToString:language])
    {
        return;
    }
    
    [def setValue:language forKey:LocalLanguageKey];    //设置语言
    [def synchronize];
    
    NSString *path = [[NSBundle mainBundle]pathForResource:language ofType:@"lproj"];
    bundle = [NSBundle bundleWithPath:path];    //生成bundle目录
}
@end
