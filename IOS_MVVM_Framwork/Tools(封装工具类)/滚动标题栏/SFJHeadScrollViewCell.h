//
//  SFJHeadScrollViewCell.h
//  SimpleShoppingMall
//
//  Created by Experimental Computer on 2018/8/6.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFJSimpleButton.h"

@interface SFJHeadScrollViewCell : UICollectionViewCell

@property(nonatomic , copy)NSString *title;
@property(nonatomic , copy)NSString *titleImgName;

@property (strong , nonatomic)SFJSimpleButton *titleBtn;

@property (strong , nonatomic)UIView *bottomLineView;
@end
