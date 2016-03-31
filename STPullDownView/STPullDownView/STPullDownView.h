//
//  STPullDownView.h
//  STPullDownView
//
//  Created by fancy on 16/3/29.
//  Copyright © 2016年 孙婷婷-Ocean. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  tableView 的行高
 */
static const CGFloat kSTTableViewHight = 45.0f;

/**
 *  tableView 的header的高度
 */
static const CGFloat kSTTableViewHeaderHeight = 45.0f;

/**pullDown的高度*/
static const CGFloat kSTPullDownViewHeight = 45.0f;



@protocol STPullDownViewDelegate <NSObject>

#define  titleColor  [UIColor lightGrayColor]
/**pullDownView 点击了下拉菜单的index行时候的代理方法*/
-(void)pullDownViewDidClickIndex:(NSInteger )index;


@end


@interface STPullDownView : UIView

@property (nonatomic ,strong) NSArray *dataArray;

@property (nonatomic ,weak) id <STPullDownViewDelegate> delegate;

@end
