//
//  SFJHeadScrollViewController.h
//  SimpleShoppingMall
//
//  Created by Experimental Computer on 2018/8/6.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HeaderScrollViewDelegate<NSObject>
@required
/**
 点击头部的代理方法
 **/
-(void)header_didSelectAtIndexPath:(NSIndexPath *)IndexPath;

@end

@interface SFJHeadScrollView : UIView

@property(nonatomic , strong)NSArray *titleArray;
@property(nonatomic , strong)NSArray *imageArray;

@property(nonatomic , weak) id<HeaderScrollViewDelegate> delegate;
@end
