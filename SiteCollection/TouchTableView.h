//
//  TouchTableView.h
//  SiteCollection
//
//  Created by WangZhengHong on 15/11/4.
//  Copyright © 2015年 WangZhengHong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TouchTableView : UITableView

@property (nonatomic,assign) CGPoint point;
-(NSIndexPath*)  getTableViewCellindexPath;
@end
