//
//  WebViewController.m
//  SiteCollection
//
//  Created by WangZhengHong on 15/10/14.
//  Copyright © 2015年 WangZhengHong. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()
{
    UIActivityIndicatorView *acView;
    
}
@property (nonatomic,strong)NSString * webURL;
@property (nonatomic,strong)UIWebView *webView;
@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGRect bounds = self.view.frame;  //获取界面区域
    
    
    
    
    
    
    
    
    self.webView =[[UIWebView alloc]initWithFrame:CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.width, bounds.size.height)];
    
    self.webView.delegate=self;
    [self.view addSubview:self.webView];
    
    
    acView =[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake((bounds.size.height-120)/2, (bounds.size.width-120)/2,120, 120)];
    
    [acView setCenter:CGPointMake(160, 140)];//指定进度轮中心点
    
    [acView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];//设置进度轮显示类型
    //acView.backgroundColor =[UIColor blackColor];
    [acView setCenter:self.view.center];
    [acView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    
    [self.view addSubview:acView];
    [acView startAnimating];

    
       
    
    [self.webView setScalesPageToFit:YES];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_webURL]];
    [self.webView loadRequest:request];
    
    
    

}
-(void)AddBtnOfReturn
{
    UIBarButtonItem * barBtn = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(btn_click)];
    self.navigationItem.leftBarButtonItem=barBtn;

}


- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [acView stopAnimating];
    //NSLog(@"Stop");
}
- (void)showViewUrlValue:(NSString *)url
{
    
    //NSLog(@"url=%@",url);
    _webURL=url;
    
    
}

-(void)btn_click
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void)webViewDidStartLoad:(UIWebView *)webView
//{
//    [activityIndicatorView startAnimating];
//}
//-(void)webViewDidFinishLoad:(UIWebView *)webView
//{
//    [activityIndicatorView stopAnimating];
//
//}
//-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
//{
//    //[activityIndicatorView stopAnimating];
//    UIAlertView * alerView = [[UIAlertView alloc]initWithTitle:@"网络问题" message:@"请检查网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//    [self.view addSubview:alerView];
//    [alerView show];
//    
//}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
