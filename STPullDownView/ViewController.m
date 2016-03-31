//
//  ViewController.m
//  STPullDownView
//
//  Created by fancy on 16/3/29.
//  Copyright © 2016年 孙婷婷-Ocean. All rights reserved.
//

#import "ViewController.h"
#import "STPullDownView.h"

@interface ViewController () <STPullDownViewDelegate>
@property (nonatomic ,strong) STPullDownView *pullDownView;

@end

@implementation ViewController

-(STPullDownView *)pullDownView
{
    if (!_pullDownView) {
        _pullDownView = [[STPullDownView alloc] initWithFrame:CGRectMake(0, 300, self.view.frame.size.width, 45)];
    }return  _pullDownView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame = CGRectMake(100, 100, 100, 100);
    [self.view addSubview:but];
    but.backgroundColor = [UIColor redColor];
    [but addTarget:self action:@selector(butAction) forControlEvents:UIControlEventTouchUpInside];
}
-(void)butAction
{
    STPullDownView *view = [self pullDownView];
    view.delegate = self;
    view.dataArray = @[@"开心中小学第一个班级",@"听说明天不会下雨，下雨了不是一个好天气,可是下雨了风景会很美"];
    [self.view addSubview:view];
}

-(void)pullDownViewDidClickIndex:(NSInteger)index
{
    NSLog(@"代理的回调方法========----您点击了行--> %ld ",index);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
