//
//  PersonViewController.m
//  SiteCollection
//
//  Created by WangZhengHong on 15/10/13.
//  Copyright © 2015年 WangZhengHong. All rights reserved.
//

#import "PersonViewController.h"
#import "SharedDataBaseManager.h"
#import "FMDB.h"
#import "AFNetworking.h"
#import "WebViewController.h"
#import "AddSiteViewController.h"

@interface PersonViewController ()
{
    
    NSMutableArray *titleArray;//标题
    NSMutableArray *idArray;//id
    NSMutableArray *urlArray;//URL
    UIImageView * msgView ;
    SysData initValues;
    
    UIBarButtonItem *leftButton;
    UIBarButtonItem *rightButton;


}
@property (nonatomic,strong) UITableView * MytableView;
@end

@implementation PersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGRect bounds = self.view.frame;  //获取界面区域
    UINavigationBar *bar = [self.navigationController navigationBar];
    CGFloat navBarHeight = 35.0f;
    CGRect frame = CGRectMake(0.0f, 20.0f, 320.0f, navBarHeight);
    [bar setFrame:frame];
    
    
    titleArray =[NSMutableArray array];
    idArray  =[NSMutableArray array];
    urlArray   =[NSMutableArray array];

    self.navigationItem.title=@"个人收藏";
    
    _MytableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0+20, bounds.size.width, bounds.size.height) style:UITableViewStylePlain];
    
    [self.view addSubview:_MytableView];
    
    
    
    self.MytableView.dataSource=self;
    self.MytableView.delegate=self;
    [self loadData];
    
    
    
    
    //btnAdd =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 22, 22)];
 //   btnAdd =[UIButton buttonWithType:UIButtonTypeContactAdd];
//   UIImage * img =[UIImage imageNamed:@"Add@2x"];
//    btnAdd.imageView.image=img;
 //   [btnAdd addTarget:self action:@selector(addData) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem * barAddItem =[[UIBarButtonItem alloc]initWithCustomView:btnAdd];
//    self.navigationItem.leftBarButtonItem=barAddItem;

    leftButton = [[UIBarButtonItem alloc] initWithTitle:@"增加"
                                                                    style:UIBarButtonItemStyleDone target:self action:@selector(addData)];
    
    self.navigationItem.leftBarButtonItem=leftButton;


    
    rightButton = [[UIBarButtonItem alloc] initWithTitle:@"编辑"
                                                                    style:UIBarButtonItemStyleDone target:self action:@selector(editData)];
    
    self.navigationItem.rightBarButtonItem=rightButton;
    
    
    
    msgView =[[UIImageView alloc]initWithFrame:CGRectMake((bounds.size.width-bounds.origin.x)/2-110, 200, 220, 60)];
    
}



// 控制器即将显示的时候调用
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    //NSLog(@"%@ -  控制器即将显示", [self class]);
    initValues =[[SharedDataBaseManager sharedManager]returnInitValues];
    [self.MytableView reloadData];
    
}

// 控制器完全显示的时候调用
//- (void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    NSLog(@"%@ -  控制器完全显示", [self class]);
//}

// 控制器即将消失的时候调用
//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    NSLog(@"%@ -  控制器即将消失", [self class]);
//}
// 控制器完全消失的时候调用
//- (void)viewDidDisappear:(BOOL)animated
//{
//    [super viewDidDisappear:animated];
//    NSLog(@"%@ -  控制器完全消失", [self class]);
//}
//- (void)viewWillUnload
//
//{
//    [super viewWillUnload];
//    NSLog(@"%@ -  view即将被销毁", [self class]);
//}
-(void)loadData{
    
    FMDatabase *db=[[SharedDataBaseManager sharedManager] returnShareDb];
    initValues =[[SharedDataBaseManager sharedManager]returnInitValues];
    
    [titleArray removeAllObjects];
    [idArray removeAllObjects];
    [urlArray removeAllObjects];
    NSString *sql=@"SELECT * FROM person_url";
    if (1==initValues.sort_status) {
        sql=@"SELECT * FROM person_url ORDER BY HITS DESC";
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
#pragma 刷新表格数据，协议函数
-(void)reLoadData{
    [self loadData];
    [self.MytableView reloadData];
}
-(void)addData{
 //   NSLog(@"addData...");
    
//    [titleArray addObject:@"apple.com"];
//    [urlArray addObject:@"http://wwww.apple.com.cn"];
//    
//    [idArray addObject:@"4"];
    
    //[db executeUpdate:@"INSERT INTO url (id,url,url_txt) VALUES (?,?,?)",@"4",@"http://www.apple.com.cn",@"apple"] ;
    
    AddSiteViewController * addSiteVc = [[AddSiteViewController alloc]init];
    
    [addSiteVc SetIndex:(int)[urlArray count]];
    
    //代理，将PersonViewController传给addSiteVc 
    addSiteVc.delegate=self;
   
    
    UINavigationController * addSiteNC =  [[UINavigationController alloc]initWithRootViewController:addSiteVc];
    addSiteNC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:addSiteNC animated:YES completion:^{
        //NSLog(@"Read News....");
    }];
   // [self presentModalViewController:addSiteNC animated:YES ];

    
    //[self loadData];
    //[self.MytableView reloadData];
    
}

-(void)UpdateHits:(NSString *) indexID :(NSString * )tableName {
    FMDatabase *db=[[SharedDataBaseManager sharedManager] returnShareDb];
    
    [db executeUpdate:@"UPDATE PERSON_URL SET HITS=HITS+1 WHERE ID=?",indexID] ;

}

-(void)editData{
    //NSLog(@"edit data...");
    if([rightButton.title isEqualToString:@"编辑"])
    {
      [self.MytableView setEditing:YES animated:YES];
       rightButton.title =@"完成";
    }
    else{
        [self.MytableView setEditing:NO animated:YES];
        rightButton.title =@"编辑";
        
    }
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
        //NSUInteger *row = [indexPath row];
        //[self.list removeObjectAtIndex:row];
        //        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
        //                         withRowAnimation:UITableViewRowAnimationAutomatic];
        
       // NSLog(@"DELETE DATA");
        FMDatabase *db=[[SharedDataBaseManager sharedManager] returnShareDb];
        
        [db executeUpdate:@"DELETE FROM PERSON_URL WHERE ID=?",[idArray objectAtIndex:indexPath.row]] ;
        [titleArray removeObjectAtIndex:indexPath.row];
        [idArray removeObjectAtIndex:indexPath.row];
        [urlArray removeObjectAtIndex:indexPath.row];
        

        [self.MytableView reloadData];
    }
//    if (editingStyle== UITableViewCellEditingStyleNone) {
//        NSLog(@"edit row = %ld",indexPath.row);
//    }
}



//这个方法就是执行移动操作的
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)
sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    NSUInteger fromRow = [sourceIndexPath row];
    NSUInteger toRow = [destinationIndexPath row];
    
    id object = [titleArray objectAtIndex:fromRow];
    [titleArray removeObjectAtIndex:fromRow];
    [titleArray insertObject:object atIndex:toRow];
    
    
    object = [idArray objectAtIndex:fromRow];
    [idArray removeObjectAtIndex:fromRow];
    [idArray insertObject:object atIndex:toRow];

    
    
    object = [urlArray objectAtIndex:fromRow];
    [urlArray removeObjectAtIndex:fromRow];
    [urlArray insertObject:object atIndex:toRow];

    
    
    
    
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
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];//必须写opacity才行。
//    animation.fromValue = [NSNumber numberWithFloat:1.0f];
//    animation.toValue = [NSNumber numberWithFloat:0.0f];//这是透明度。
//    animation.autoreverses = YES;
//    animation.duration = 1.0;
//    animation.repeatCount = MAXFLOAT;
//    animation.removedOnCompletion = NO;
//    animation.fillMode = kCAFillModeForwards;
//    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];///没有的话是均匀的动画。
    
    
//    [msgView.layer addAnimation:animation forKey:@"opacity"];
    
    
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
                    [self UpdateHits:[idArray objectAtIndex:indexPath.row]:@"PERSON_URL" ];


                    [[UIApplication sharedApplication ] openURL:MISurl];
                    
                }
                else{
                    
                    
                    // NSLog(@"%@",baseURL);
                    
                    WebViewController * newsWeb = [[WebViewController alloc]init];
                    
                    
                    [newsWeb showViewUrlValue:[urlArray objectAtIndex:indexPath.row]];
                    
                    UINavigationController * webNC =  [[UINavigationController alloc]initWithRootViewController:newsWeb];
                    
                    [self presentViewController:webNC animated:YES completion:^{
                        //NSLog(@"Read News....");
                        [self UpdateHits:[idArray objectAtIndex:indexPath.row]:@"PERSON_URL"];

                    }];
                    
                }
            }
            
            
        }];
        
        
        
        
    }
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
