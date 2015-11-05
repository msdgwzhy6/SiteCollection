//
//  TouchTableView.m
//  SiteCollection
//
//  Created by WangZhengHong on 15/11/4.
//  Copyright © 2015年 WangZhengHong. All rights reserved.
//

#import "TouchTableView.h"

@implementation TouchTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(NSIndexPath*)  getTableViewCellindexPath{
    NSIndexPath *indexPath = [self indexPathForRowAtPoint:_point];
    
    return indexPath;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    _point=touchPoint;
    
    [super touchesBegan:touches withEvent:event];

}
-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesCancelled:touches withEvent:event];
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
}
@end
