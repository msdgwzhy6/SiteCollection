//
//  DataValues.h
//  刷新表格数据协议
//  SiteCollection
//
//  Created by WangZhengHong on 15/10/15.
//  Copyright © 2015年 WangZhengHong. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DataValues <NSObject>
@optional
#pragma 刷新表格数据
-(void)reLoadData;
@end
