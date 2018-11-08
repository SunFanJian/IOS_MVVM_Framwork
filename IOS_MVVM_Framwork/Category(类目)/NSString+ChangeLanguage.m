//
//  NSString+ChangeLanguage.m
//  HK_Sensor
//
//  Created by Experimental Computer on 2018/4/4.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import "NSString+ChangeLanguage.h"

@implementation NSString (ChangeLanguage)

+(NSString *)changeLanguage:(NSString *)string
{
    NSBundle *bundle = [SwitchLanguage bundle];  //获取资源文件
    NSString *str = [bundle localizedStringForKey:string value:nil table:@"Localizable"];
    
    return str;
}

+(NSString *)changeLanguageBySystem:(NSString *)string
{
    NSString *str = NSLocalizedString(string, nil);
    return  str;
}
@end
