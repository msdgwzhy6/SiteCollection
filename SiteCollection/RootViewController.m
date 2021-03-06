//
//  RootViewController.m
//  SiteCollection
//
//  Created by WangZhengHong on 15/10/13.
//  Copyright © 2015年 WangZhengHong. All rights reserved.
//

#import "RootViewController.h"
#import "SharedDataBaseManager.h"
#import "FMDB.h"
#import "AFNetworking.h"
#import "WebViewController.h"
#import "TouchTableView.h"
@interface RootViewController ()
{
    NSMutableArray *titleArray;//标题
    NSMutableArray *idArray;//id
    NSMutableArray *urlArray;//URL
    
    UIImageView * msgView ;
    SysData initValues;
    NSString * url;
}

@property (nonatomic,strong) TouchTableView * tableView;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGRect bounds = self.view.frame;  //获取界面区域
    
    
    titleArray =[NSMutableArray array];
    idArray  =[NSMutableArray array];
    urlArray   =[NSMutableArray array];
    
    
    self.navigationItem.title=@"热门网址";
    
    self.tableView =[[TouchTableView alloc]initWithFrame:CGRectMake(0, 0+20, bounds.size.width, bounds.size.height) style:UITableViewStylePlain];
    
    [self.view addSubview:self.tableView];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    [self loadData];
    
    msgView =[[UIImageView alloc]initWithFrame:CGRectMake((bounds.size.width-bounds.origin.x)/2-110, 200, 220, 60)];
    
    //9.0以下不执行
    if ([self respondsToSelector:@selector(registerForPreviewingWithDelegate:sourceView:)])
       [self registerForPreviewingWithDelegate:self sourceView:self.view];
    
    
    
    //给cell加长按手势
//    UILongPressGestureRecognizer *gestureLongPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(gestureLongPress:)];
//    gestureLongPress.minimumPressDuration =0.2;
//    [self.tableView addGestureRecognizer:gestureLongPress];
    
    
    
}

//- (void)gestureLongPress:(UILongPressGestureRecognizer *)gestureRecognizer
//{
//    CGPoint tmpPointTouch = [gestureRecognizer locationInView:self.tableView];
//    if (gestureRecognizer.state ==UIGestureRecognizerStateBegan) {
//        NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:tmpPointTouch];
//        if (indexPath == nil) {
//            NSLog(@"not tableView");
//        }else{
//            NSLog(@"%ld",[indexPath row]);
//            
//            
//        }
//    }
//}



// 控制器即将显示的时候调用
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    //NSLog(@"%@ -  控制器即将显示", [self class]);
    initValues =[[SharedDataBaseManager sharedManager]returnInitValues];
    [self.tableView reloadData];
    
}

// 控制器完全显示的时候调用
//- (void)viewDidAppear:(BOOL)animated
//{
//         [super viewDidAppear:animated];
//        NSLog(@"%@ -  控制器完全显示", [self class]);
//}

// 控制器即将消失的时候调用
// - (void)viewWillDisappear:(BOOL)animated
// {
//         [super viewWillDisappear:animated];
//         NSLog(@"%@ -  控制器即将消失", [self class]);
//}
// // 控制器完全消失的时候调用
// - (void)viewDidDisappear:(BOOL)animated
// {
//         [super viewDidDisappear:animated];
//         NSLog(@"%@ -  控制器完全消失", [self class]);
//}
// - (void)viewWillUnload
//
//{
//         [super viewWillUnload];
//        NSLog(@"%@ -  view即将被销毁", [self class]);
//}
-(void)loadData{
    
    FMDatabase *db=[[SharedDataBaseManager sharedManager] returnShareDb];
    initValues =[[SharedDataBaseManager sharedManager]returnInitValues];
    
    NSString *sql=@"SELECT * FROM URL";
    if (1==initValues.sort_status) {
        sql=@"SELECT * FROM URL ORDER BY HITS DESC";
    }
    
    FMResultSet *rs=[db executeQuery:sql];
    while ([rs next]){
        //NSLog(@"%@ %@",[rs stringForColumn:@"url"],[rs stringForColumn:@"url_txt"]);
        
        [titleArray addObject:[rs stringForColumn:@"url_txt"]];
        [urlArray addObject:[rs stringForColumn:@"url"]];
        
        [idArray addObject:[rs stringForColumn:@"id"]];
        
        
        
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (initValues.row_height<=5) {
        return 30;
    }
    return initValues.row_height;
}
-(void)addData{
    
    
    [self.tableView reloadData];
    
    
    
}

-(void)editData{
    //NSLog(@"edit data...");
    [self.tableView setEditing:YES animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [titleArray count];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //    if (indexPath.row==5) {
    //        return NO;
    //    }
    return YES;
}

//打开编辑模式后，默认情况下每行左边会出现红的删除按钮，这个方法就是关闭这些按钮的
//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView
//           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return UITableViewCellEditingStyleInsert;
//}

//这个方法用来告诉表格 这一行是否可以移动
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

////这个方法就是执行移动操作的
//- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)
//sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
//    NSUInteger fromRow = [sourceIndexPath row];
//    NSUInteger toRow = [destinationIndexPath row];
//
//    id object = [list objectAtIndex:fromRow];
//    [list removeObjectAtIndex:fromRow];
//    [list insertObject:object atIndex:toRow];
//}

//这个方法根据参数editingStyle是UITableViewCellEditingStyleDelete
//还是UITableViewCellEditingStyleDelete执行删除或者插入
- (void)tableView:(UITableView *)tableView commitEditingStyle:
(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [titleArray removeObjectAtIndex:indexPath.row];
        [idArray removeObjectAtIndex:indexPath.row];
        [urlArray removeObjectAtIndex:indexPath.row];
        [self.tableView reloadData];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * CELLId = @"CELL";
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:CELLId];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CELLId];
        
    }
    NSUInteger row = [indexPath row];
    cell.textLabel.text = [titleArray objectAtIndex:row];
    if(1==initValues.show_status){
        cell.detailTextLabel.text=[urlArray objectAtIndex:row];
    }
    else{
        cell.detailTextLabel.text=@"";
        
    }
    UIFont *newFont = [UIFont fontWithName:@"Arial" size:initValues.font_size];
    //创建完字体格式之后就告诉cell
    cell.textLabel.font = newFont;
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    
    return  cell;
    
    
}

-(void)loadMsgImg:(NSString * )imgName {
    //CGRect bounds = self.view.bounds;
    UIImage * msgImg =[UIImage imageNamed:imgName];
    
    
    msgView.image=msgImg;
    
    [self.view addSubview:msgView];
    
    
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(hidePic) userInfo:nil repeats:NO];
    
}

-(void)hidePic{
    
    [msgView removeFromSuperview];
    //return ;
    
}


//选择行
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    

   
    if (indexPath.section==0) {
        
        // 如果要检测网络状态的变化,必须用检测管理器的单例的startMonitoring
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
        
        // 检测网络连接的单例,网络变化时的回调方法
        [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            //NSLog(@"AAAA %ld", status);
            if (status ==-1 || status == 0) {
                
                [self loadMsgImg:@"msg@2x"];
                msgView.hidden=NO;
                
                
                
            }else{
                msgView.hidden=YES;
                
                if (initValues.open_stuts==1) {
                    
                    //safari
                    NSURL* MISurl = [[ NSURL alloc ] initWithString :[urlArray objectAtIndex:indexPath.row] ];
                    
                    [self UpdateHits:[idArray objectAtIndex:indexPath.row]:@"URL" ];
                    
                    
                    
                    [[UIApplication sharedApplication ] openURL:MISurl];
                    
                }
                else{
                    
                    
                    // NSLog(@"%@",baseURL);
                    
                    WebViewController * newsWeb = [[WebViewController alloc]init];
                    
                    [newsWeb showViewUrlValue:[urlArray objectAtIndex:indexPath.row]];
                    [newsWeb AddBtnOfReturn];
                    
                    UINavigationController * webNC =  [[UINavigationController alloc]initWithRootViewController:newsWeb];
                    
                    [self presentViewController:webNC animated:YES completion:^{
                        //NSLog(@"Read News....");
                        
                        [self UpdateHits:[idArray objectAtIndex:indexPath.row]:@"URL" ];
                    }];
                    
                }
            }
            
            
        }];
        
        
        
        
    }
}
-(void)UpdateHits:(NSString *) indexID :(NSString * )tableName {
    
    
    FMDatabase *db=[[SharedDataBaseManager sharedManager] returnShareDb];
    
    [db executeUpdate:@"UPDATE URL SET HITS=HITS+1 WHERE ID=?",indexID] ;
}

- (UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)context viewControllerForLocation:(CGPoint) point
{
    
    
    
//    CGPoint point2 = [_tableView contentOffset];
//    CGPoint  p=point ;
//    p.x=point2.x+point.x;
//    p.y=point2.y+point.y;
//    
//    
//    NSIndexPath * urlIndex=[_tableView indexPathForRowAtPoint:p];
    
    NSIndexPath * urlIndex =[_tableView getTableViewCellindexPath];
    if (urlIndex == nil) {
      url=[urlArray objectAtIndex:0];
    }else{
      url=[urlArray objectAtIndex:urlIndex.row];
    }
        
    
    //存在的问题，长按cell时，如沿cell上部可准确取出URL,如沿cell下部则取出下一行cell值
    
    
    WebViewController * newsWeb = [[WebViewController alloc]init];
    newsWeb.preferredContentSize = CGSizeMake(0.0f,300.0f);
    
    [newsWeb showViewUrlValue:url];
    CGRect rect = CGRectMake(0, point.y -10, self.view.frame.size.width - 20,20);
    context.sourceRect = rect;
    
    return newsWeb;
    
}
- (void)previewContext:(id<UIViewControllerPreviewing>)context commitViewController:(UIViewController*)vc
{
    [self showViewController:vc sender:self];
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
