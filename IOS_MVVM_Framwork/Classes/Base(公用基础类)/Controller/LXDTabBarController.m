//
//  LXDTabBarController.m
//  LXDHRMS
//
//  Created by Experimental Computer on 2017/11/8.
//  Copyright © 2017年 Luxondata. All rights reserved.
//

#import "LXDTabBarController.h"
#import "LXDNavigationController.h"

@interface LXDTabBarController ()

@end

@implementation LXDTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加子控制器
    [self addAllChildVC];
    
}

-(void)addAllChildVC
{

}

//添加字控制器
-(void)addOneChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImageName:(NSString *)selectedImageName
{
    //标题 title属性 ==tabBarItem  navigationItem  title
    childVc.title=title;
    //图标
    childVc.tabBarItem.image=[UIImage imageNamed:image];
    //选中时的图标
    //IOS 7中会对selected图片再次进行渲染为蓝色
    UIImage *selectedImage=[UIImage imageNamed:selectedImageName];
    
    if(IOS7)
    {
        //所以要声明一直使用原图
        selectedImage=[selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];   //IOS 7之前没有该方法
        childVc.tabBarItem.selectedImage=selectedImage;
    }
    childVc.tabBarItem.selectedImage=selectedImage;
    
   
    
    
    // 设置tabBarItem的普通文字颜色
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    // 设置tabBarItem的选中文字颜色
    NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
    selectedTextAttrs[NSForegroundColorAttributeName] = [UIColor blueColor];
    [childVc.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
    

    //设置导航控制器的字控制器
    LXDNavigationController *nav=[[LXDNavigationController alloc]initWithRootViewController:childVc];

    //设置tabbar控制器的字控制器 为 导航控制器
    [self addChildViewController:nav];
}

/*
-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    //设置iPhone X 的tabler（tabbar下移）
    if (iPhoneX) {
        
        CGRect frame = self.tabBar.frame;
        frame.size.height = 49;
        frame.origin.y = self.view.frame.size.height - frame.size.height;
        self.tabBar.frame = frame;
        for (UITabBarItem *item in self.tabBar.items) {
            item.imageInsets = UIEdgeInsetsMake(15,0, -15, 0);
            [item setTitlePositionAdjustment:UIOffsetMake(0, 32)];
        }
    }
}
 */
/*
//解决iPhonex tabbar下移后 点击tabbar下面的文字无法切换 的问题
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (!iPhoneX) {
        return;
    }
    
    NSSet *allTouches = [event allTouches];    //返回与当前接收者有关的所有的触摸对象
    UITouch *touch = [allTouches anyObject];   //视图中的所有对象
    UIView *v =  [touch view];
    if (!CGRectEqualToRect(v.frame, CGRectMake(0, 0, 375, 49))) {
        return;
    }
    CGPoint point = [touch locationInView:v]; //返回触摸点在视图中的当前坐标
    int x = point.x;
    int y = point.y;
    
    if (y>49||y<0) {
        return;
    }
    
    CGFloat w = 375.0/4;
    if (x>=0&&x<=w) {
        self.selectedIndex = 0;
    }else if (x>w&&x<=w*2){
        self.selectedIndex = 1;
    }else if (x>w*2&&x<=w*3){
        self.selectedIndex = 2;
    }else if (x>w*3&&x<=w*4){
        self.selectedIndex = 3;
    }
    NSLog(@"touch (x, y) is (%d, %d) %@", x, y,[touch view] );
}
*/


@end
