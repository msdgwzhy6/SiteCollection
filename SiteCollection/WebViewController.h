//
//  WebViewController.h
//  SiteCollection
//
//  Created by WangZhengHong on 15/10/14.
//  Copyright © 2015年 WangZhengHong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController<UIWebViewDelegate>
- (void)showViewUrlValue:(NSString *)url;
-(void)AddBtnOfReturn;
@end
