//
//  STButton.m
//  STPullDownView
//
//  Created by fancy on 16/3/30.
//  Copyright © 2016年 孙婷婷-Ocean. All rights reserved.
//

#import "STButton.h"
#import "UIView+Extension.h"
@implementation STButton

-(instancetype)init
{
    if (self = [super init]) {
        // 当文字长度过长的时候设置文字的阶段格式
        self.titleLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
        
    }return  self;
}

-(void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    [self.titleLabel sizeToFit];
}

-(void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    [self.imageView sizeToFit];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    if (self.currentTitle == nil) {
        return;
    }
    self.titleLabel.x = self.imageView.x;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame);
}


@end
