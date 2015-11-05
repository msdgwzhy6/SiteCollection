//
//  AddSiteViewController.m
//  SiteCollection
//
//  Created by WangZhengHong on 15/10/14.
//  Copyright © 2015年 WangZhengHong. All rights reserved.
//

#import "AddSiteViewController.h"
#import "SharedDataBaseManager.h"
#import "FMDB.h"


@interface AddSiteViewController ()
{
    UIBarButtonItem *leftButton;
    UIBarButtonItem *rightButton;
    UITextField * txtUrl;
    UITextField * txtTitle;
    int index;
    
    UIImageView * msgView ;
    UISwitch * add_switch;

}

@end

@implementation AddSiteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    leftButton = [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                                  style:UIBarButtonItemStyleDone target:self action:@selector(CancelData)];
    
    self.navigationItem.leftBarButtonItem=leftButton;
    
    
    
    rightButton = [[UIBarButtonItem alloc] initWithTitle:@"保存"
                                                   style:UIBarButtonItemStyleDone target:self action:@selector(SaveData)];
    
    self.navigationItem.rightBarButtonItem=rightButton;
    
    CGRect bounds= self.view.frame;
    UIImage * img =[UIImage imageNamed:@"title@2x"];
    UIColor * txtColor=[UIColor colorWithPatternImage:img];
    txtTitle =[[UITextField alloc]initWithFrame:CGRectMake((bounds.size.width-250)/2, 150, 250, 26)];
    txtTitle.backgroundColor=txtColor;
    [self.view addSubview:txtTitle];
    
    txtUrl =[[UITextField alloc]initWithFrame:CGRectMake((bounds.size.width-250)/2, 200, 250, 26)];
    img =[UIImage imageNamed:@"url@2x"];
    UIColor * urlColor=[UIColor colorWithPatternImage:img];
    txtUrl.backgroundColor=urlColor;
    [self.view addSubview:txtUrl];
    
    UILabel * msgLabel=[[UILabel alloc]initWithFrame:CGRectMake((bounds.size.width-250)/2, 300, 250, 26)];
    
    [msgLabel setText:@"注：网址须是以http(s)://开头"];
    [self.view addSubview:msgLabel];
    
    
    msgView =[[UIImageView alloc]initWithFrame:CGRectMake((bounds.size.width-bounds.origin.x)/2-110, 250, 215, 35)];
    
    add_switch = [[UISwitch alloc]initWithFrame:CGRectMake((bounds.size.width-50)/2, 360, 50, 26)];
    [self.view addSubview:add_switch];
    
}

#pragma 正则匹配URL
-(BOOL)checkURL : (NSString *) url
{
    //@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"; 邮箱
    //@"^1[3,5,8][0-9]{9}$";  手机号
    //@"http+:[^\\s]*";   OR [a-zA-z]+://[^\s]*
    NSString *pattern = @"http(s)?+://[^\\s]*[\\.][^\\s]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:url];
    return isMatch;
    
}

#pragma 是否为空
-(BOOL)checkTxt:(NSString *)txt{
    
    if ([[txt stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
        
        return YES;
        
    }
    
    return NO;
}

#pragma 传数组元素个数，用过ID + 1
-(void)SetIndex:(int) i
{
    index=i;
}
-(void)SaveData{
    

    
    if ([self checkTxt:[txtTitle text]]) {
        [self loadMsgImg:@"alterTxt@2x"];
        //NSLog(@"TXT IS  NULL");
        return ;
    }

    if ([self checkURL:[txtUrl text]]) {
       //NSLog(@"URL OK");
        
        [self dismissViewControllerAnimated:YES completion:^{
            //NSLog(@"Save Data");
            NSString * iCount =[NSString stringWithFormat:@"%d",index+1 ];
            FMDatabase *db=[[SharedDataBaseManager sharedManager] returnShareDb];
            
            [db executeUpdate:@"INSERT INTO person_url (id,url,url_txt) VALUES (?,?,?)",iCount,[txtUrl text],[txtTitle text],1,index+1] ;
            
            [_delegate reLoadData];
            
            
        }];
                             
    }   else{

        //NSLog(@"URL ERROR");
        [self loadMsgImg:@"alterNullTxt@2x"];
    }
    

}

//取消按钮事件
-(void)CancelData{
    [self dismissViewControllerAnimated:YES completion:nil];

}

-(void)loadMsgImg:(NSString * )imgName {
    //CGRect bounds = self.view.bounds;
    UIImage * msgImg =[UIImage imageNamed:imgName];
    
    
    msgView.image=msgImg;
    
    [self.view addSubview:msgView];
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];//必须写opacity才行。
//    animation.fromValue = [NSNumber numberWithFloat:1.0f];
//    animation.toValue = [NSNumber numberWithFloat:0.0f];//这是透明度。
//    animation.autoreverses = YES;
//    animation.duration = 1.0;
//    animation.repeatCount = MAXFLOAT;
//    animation.removedOnCompletion = NO;
//    animation.fillMode = kCAFillModeForwards;
//    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];///没有的话是均匀的动画。
//    
//    
//    [msgView.layer addAnimation:animation forKey:@"opacity"];
    
    
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(hidePic) userInfo:nil repeats:NO];
    
}

-(void)hidePic{
    
    [msgView removeFromSuperview];
    //return ;
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
