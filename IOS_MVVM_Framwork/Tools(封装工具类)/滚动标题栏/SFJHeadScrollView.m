//
//  SFJHeadScrollViewController.m
//  SimpleShoppingMall
//
//  Created by Experimental Computer on 2018/8/6.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import "SFJHeadScrollView.h"
#import "SFJHeadScrollViewCell.h"

@interface SFJHeadScrollView ()<UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout>

/* scrollerVew */
@property (strong , nonatomic)UICollectionView *collectionView;

@property (strong , nonatomic)NSIndexPath *currentIndexPath;

@end

static NSString *SFJHeadScrollViewCellID = @"SFJHeadScrollViewCell";

@implementation SFJHeadScrollView

-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;     //水平滚动
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [_collectionView registerClass:[SFJHeadScrollViewCell class] forCellWithReuseIdentifier:SFJHeadScrollViewCellID];
        
        [self addSubview:_collectionView];
    }
    return _collectionView;
}

//设置选中的默认值
-(NSIndexPath* )currentIndexPath
{
    if(!_currentIndexPath)
    {
        _currentIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    }
    return _currentIndexPath;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
    }
    return self;
}

-(void)setUpUI
{
    self.backgroundColor = [UIColor whiteColor];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    _collectionView.frame = CGRectMake(0, 0, kWIGTH, self.height);
}

-(void)setTitleArray:(NSArray *)titleArray
{
    _titleArray = titleArray;
}

-(void)setImageArray:(NSArray *)imageArray
{
    _imageArray = imageArray;
}

#pragma mark - UIcollectionView Delegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _titleArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SFJHeadScrollViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SFJHeadScrollViewCellID forIndexPath:indexPath];
    cell.title = _titleArray[indexPath.row];
    cell.titleImgName = _imageArray[indexPath.row];
    cell.bottomLineView.hidden = YES;
    if(indexPath == self.currentIndexPath)
    {
        //cell.titleBtn.titleLabel.textColor = [UIColor blackColor];
        cell.bottomLineView.hidden = NO;
    }
    
    return cell;
}

#pragma mark - item宽高
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_titleArray.count <= 4) {
        return CGSizeMake(self.width / _titleArray.count, self.height);
    }else{
        return CGSizeMake(self.width / 4, self.height);
        }
}
#pragma mark - item x间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击了 第%ld 个",indexPath.row );
    
    self.currentIndexPath = indexPath;
    [collectionView reloadData];
    [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];    //水平滚动至 点击的item
    //[self didSelectHeadIndex:indexPath];
    if(self.delegate && [self.delegate respondsToSelector:@selector(header_didSelectAtIndexPath:)])
        [self.delegate header_didSelectAtIndexPath:indexPath];  //点击代理
}

-(void)didSelectHeadIndex:(void (^)(NSIndexPath *))IndexPath
{
    IndexPath(self.currentIndexPath);
}

#pragma mark -- 处理滑屏事件
//- (void)scrollCollectionItemToDesWithDesIndex:(NSInteger)index{
//    
//    NSIndexPath *desIndexpath = [NSIndexPath indexPathForRow:index inSection:0];
//    [self.mainCollectionView  scrollToItemAtIndexPath:desIndexpath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
//    self.currentIndexPath = desIndexpath;
//    [self.mainCollectionView reloadData];
//}
@end
