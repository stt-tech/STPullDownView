//
//  STPullDownView.m
//  STPullDownView
//
//  Created by fancy on 16/3/29.
//  Copyright © 2016年 孙婷婷-Ocean. All rights reserved.
//

#import "STPullDownView.h"
#import "STButton.h"

#define  SCRW   [UIScreen mainScreen].bounds.size.width
#define  SCRH    [UIScreen mainScreen].bounds.size.height

@interface STPullDownView () <UITableViewDataSource,UITableViewDelegate>
{
    BOOL _isFold;
    NSInteger _index;
}

@property (nonatomic ,strong)STButton    *but;

@property (nonatomic ,strong)  UIView *bgView ;
@property (nonatomic ,weak)UITableView *tableView;

@end

@implementation STPullDownView

-(UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor= [UIColor lightGrayColor];
        _bgView.alpha = 0.4;
    }return  _bgView;
}
-(STButton *)but
{
    if (!_but) {
        _but = [[STButton alloc] init];
        [_but setBackgroundColor:titleColor];
        _but.frame = CGRectMake(0, 0, SCRW, kSTPullDownViewHeight);
    }return _but;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
        
    }return self;
}

-(void)createUI
{
    self.clipsToBounds = YES;
    [self but];
    [self addSubview:_but];
    [_but addTarget:self action:@selector(showOrHiddenTableView:) forControlEvents:UIControlEventTouchUpInside];
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0 , CGRectGetMaxY(_but.frame), SCRW, 1) style:UITableViewStylePlain];
    _tableView = tableView;
    _tableView.scrollEnabled = NO;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self addSubview:tableView];
    [self bgView];
    [self addSubview:_bgView];
}
-(void)showOrHiddenTableView:(UIButton *)but
{
    but.selected = !but.selected;
    _isFold = but.selected;
    CGFloat frameX = self.frame.origin.x;
    CGFloat frameY = self.frame.origin.y;
    if (_isFold) {
         self.frame = CGRectMake(frameX, frameY, SCRW, SCRH - CGRectGetMaxY(_but.frame));
        [but setImage:[UIImage imageNamed:@"up@"] forState:UIControlStateNormal];
    }else
    {
        self.frame = CGRectMake(frameX, frameY, SCRW, kSTTableViewHeaderHeight);
        [but setImage:[UIImage imageNamed:@"dowm@3x"] forState:UIControlStateNormal];
    }
}

-(void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    if (_dataArray.count > 1) {
        [_but setImage:[UIImage imageNamed:@"dowm@3x"] forState:UIControlStateNormal];
        self.userInteractionEnabled = YES;
        _tableView.frame = CGRectMake(0, kSTTableViewHeaderHeight, SCRW, kSTTableViewHight * _dataArray.count);
        _bgView.frame = CGRectMake(0, CGRectGetMaxY(_tableView.frame), SCRW, SCRH - CGRectGetMaxY(_tableView.frame));
        [_but setTitle:[_dataArray firstObject]forState:UIControlStateNormal];
        [_tableView reloadData];
        UIView *view = [[UIView alloc] init];
        [self addSubview:view];
        
    }else
    {
        self.userInteractionEnabled = NO;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCRW, kSTPullDownViewHeight)];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = titleColor;
        label.text = [_dataArray firstObject];
        [self addSubview:label];
    }
}

#pragma mark - tableView 的代理方法
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = _dataArray[indexPath.row];
    return  cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  (_isFold == YES)?0:kSTTableViewHight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_dataArray[indexPath.row] isEqualToString:_but.currentTitle]) {
        return;
    }else{
    _isFold = NO;
    [self showOrHiddenTableView:_but];
    _index = indexPath.row;
    [_but setTitle:_dataArray[_index] forState:UIControlStateNormal];
    if ([self.delegate respondsToSelector:@selector(pullDownViewDidClickIndex:)]) {
        [self.delegate pullDownViewDidClickIndex:indexPath.row];
    }}
    
}










@end
