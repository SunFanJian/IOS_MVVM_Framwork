//
//  SFJSimpleButton.m
//  SimpleShoppingMall
//
//  Created by Experimental Computer on 2018/8/2.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import "SFJSimpleButton.h"

@implementation SFJSimpleButton

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.imageView.image == nil) {
        self.titleLabel.centerX = self.width * 0.5;
    }else if (self.titleLabel.text.length == 0){
        self.imageView.centerX = self.width * 0.5;
    }else{
        [self.titleLabel sizeToFit];        //sizeToFit   计算出最优size, 并且改变UIView的size
        [self.imageView sizeToFit];
        
        if (self.buttonStyle == 0) {
            // 图片在上 文字在下
            self.imageView.y = self.height * 0.12;
            self.imageView.centerX = self.width * 0.5;

            
            self.titleLabel.y = self.imageView.bottomY + self.height * 0.12;
            self.titleLabel.centerX = self.width * 0.5;
           
        }
        
        if(self.buttonStyle == 1){
            //图片在左 文字在右
            self.imageView.x = self.height * 0.12;
            self.imageView.centerY = self.height * 0.5;
            
            self.titleLabel.x = CGRectGetMaxX(self.imageView.frame) + 5;
            self.titleLabel.centerY = self.height * 0.5;
            
        }
        
        if(self.buttonStyle == 2){
            //图片在下 文字在上
            self.titleLabel.y = self.height * 0.12;;
            self.titleLabel.centerX = self.width * 0.5;
            
            self.imageView.y = CGRectGetMaxY(self.titleLabel.frame) + self.height * 0.12;
            self.imageView.centerX = self.width * 0.5;
        }
        
        if (self.buttonStyle == 3) {
            //图片在右 文字在左
            //设置lable
          //  self.titleLabel.x = self.height * 0.12;
            self.titleLabel.centerX = self.width * 0.5 - 5;
            self.titleLabel.centerY = self.height * 0.5;
            
            //设置图片位置
            self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + 5;
            self.imageView.centerY = self.height * 0.5;
        }
    }
}

-(void)setButtonStyle:(ButtonImageStyle)buttonStyle
{
    _buttonStyle = buttonStyle;
}
@end
