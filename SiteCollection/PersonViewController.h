//
//  PersonViewController.h
//  SiteCollection
//
//  Created by WangZhengHong on 15/10/13.
//  Copyright © 2015年 WangZhengHong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataValues.h"

@interface PersonViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,DataValues>
-(void)loadData;
@end
