//
//  AddSiteViewController.h
//  SiteCollection
//
//  Created by WangZhengHong on 15/10/14.
//  Copyright © 2015年 WangZhengHong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataValues.h"

@interface AddSiteViewController : UIViewController<DataValues>
-(void)SetIndex:(int)i;
-(BOOL)checkURL : (NSString *) url;
@property (nonatomic,retain)id <DataValues> delegate;
@end
