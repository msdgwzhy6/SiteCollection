//
//  SetViewController.m
//  SiteCollection
//
//  Created by WangZhengHong on 15/10/13.
//  Copyright © 2015年 WangZhengHong. All rights reserved.
//

#import "SetViewController.h"
#import "SharedDataBaseManager.h"

@interface SetViewController ()
{
    SysData initValues;
    UISlider * fontSize ;
    UILabel * fontSizeLabel;
    
    UISlider * rowHeight ;
    UILabel * rowHeightLabel;
    
    
    UISwitch * sort_switch;
    UISwitch * open_switch;
    UISwitch *show_switch;
}
@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITableView *myTableView =  [[UITableView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+2, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    myTableView.delegate=self;
    myTableView.dataSource=self;
    
    [self.view addSubview:myTableView];
    //myTableView.scrollEnabled=NO;
    self.navigationItem.title=@"设置";
    
}




//设置节段数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

//设置节段行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 5;
        
    }
    
    
    return 1;
}

//初始化行数据
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleSubtitle
                
                reuseIdentifier:CellIdentifier] ;
    }
    
    // FMDatabase *db=[[SharedDataBaseManager sharedManager] returnShareDb];
    initValues =[[SharedDataBaseManager sharedManager]returnInitValues];
    
    //NSLog(@"font_size = %f",initValues.font_size);
    if (indexPath.section==0) {
        
        if (indexPath.row==0) {
            CGRect bounds = cell.contentView.frame;  //获取界面区域
            cell.textLabel.text = @"字体大小" ;
            fontSize =[[UISlider alloc]initWithFrame:CGRectMake(bounds.origin.x+150, (bounds.size.height-8)/2, 100, 8)];
            [cell.contentView addSubview:fontSize];
            [fontSize setTag:1001];
            [fontSize setMaximumValue:80.0];
            [fontSize setMinimumValue:9.0];
            [fontSize setValue:initValues.font_size];
            fontSize.continuous=NO;
            [fontSize addTarget:self action:@selector(fontSizeChanged) forControlEvents:UIControlEventValueChanged];
            
            
            fontSizeLabel=[[UILabel alloc]initWithFrame:CGRectMake(bounds.origin.x+150+100+10, (bounds.size.height-20)/2, 80, 20)];
            NSString * str=[NSString stringWithFormat:@"%.0f",floor(initValues.font_size)];
            [fontSizeLabel setText:str];
            [cell.contentView addSubview:fontSizeLabel];
            
            
            //[fontSize addTarget:self action:@selector(fontSizeChanged2) forControlEvents:UIControlEventEditingDidEnd];
            //            cell.imageView.image=[UIImage imageNamed:@"btn_self_check_selected@2x.png"];
        }
        if (indexPath.row==1) {
            CGRect bounds = cell.contentView.frame;  //获取界面区域
            cell.textLabel.text = @"表格行高" ;
            rowHeight =[[UISlider alloc]initWithFrame:CGRectMake(bounds.origin.x+150, (bounds.size.height-8)/2, 100, 8)];
            [cell.contentView addSubview:rowHeight];
            [rowHeight setTag:1001];
            [rowHeight setMaximumValue:100.0];
            [rowHeight setMinimumValue:20.0];
            [rowHeight setValue:initValues.row_height];
            rowHeight.continuous=NO;
            [rowHeight addTarget:self action:@selector(rowHeightChanged) forControlEvents:UIControlEventValueChanged];
            
            
            rowHeightLabel=[[UILabel alloc]initWithFrame:CGRectMake(bounds.origin.x+150+100+10, (bounds.size.height-20)/2, 80, 20)];
            NSString * str=[NSString stringWithFormat:@"%d",initValues.row_height];
            [rowHeightLabel setText:str];
            [cell.contentView addSubview:rowHeightLabel];
            
            
            //[fontSize addTarget:self action:@selector(fontSizeChanged2) forControlEvents:UIControlEventEditingDidEnd];
            //            cell.imageView.image=[UIImage imageNamed:@"btn_self_check_selected@2x.png"];
        }
        if (indexPath.row==2) {
            cell.textLabel.text = @"按点击频率排序" ;
            CGRect bounds = cell.contentView.frame;  //获取界面区域
            sort_switch=[[UISwitch alloc]initWithFrame:CGRectMake(bounds.origin.x+200, (bounds.size.height-30)/2, 50, 30)];
            [cell.contentView addSubview:sort_switch];
            if (1==initValues.sort_status) {
                sort_switch.on=YES;
            }
            else{
                sort_switch.on=NO;
            }
            [sort_switch addTarget:self action:@selector(sort_switch_changed) forControlEvents:UIControlEventValueChanged];
            
        }
        if (indexPath.row==3) {
            cell.textLabel.text = @"使用外部浏览器" ;
            CGRect bounds = cell.contentView.frame;  //获取界面区域
            open_switch=[[UISwitch alloc]initWithFrame:CGRectMake(bounds.origin.x+200, (bounds.size.height-30)/2, 50, 30)];
            [cell.contentView addSubview:open_switch];
            
            if (1==initValues.open_stuts) {
                open_switch.on=YES;
            }
            else{
                open_switch.on=NO;
            }
            [open_switch addTarget:self action:@selector(open_switch_changed) forControlEvents:UIControlEventValueChanged];
            
            //            cell.imageView.image=[UIImage imageNamed:@"health_data_600.png"];
        }
        
        if (indexPath.row==4) {
            cell.textLabel.text = @"显示详细网址 " ;
            CGRect bounds = cell.contentView.frame;  //获取界面区域
            show_switch=[[UISwitch alloc]initWithFrame:CGRectMake(bounds.origin.x+200, (bounds.size.height-30)/2, 50, 30)];
            [cell.contentView addSubview:show_switch];
            
            if (1==initValues.show_status) {
                show_switch.on=YES;
            }
            else{
                show_switch.on=NO;
            }
            [show_switch addTarget:self action:@selector(show_switch_changed) forControlEvents:UIControlEventValueChanged];
            
            //            cell.imageView.image=[UIImage imageNamed:@"health_data_600.png"];
        }
        
        
        // cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    
    
    if (indexPath.section==1) {
        
        cell.textLabel.text=@"还原初始数据";
        
        
    }
    
    
    
    return cell;
    
}

-(void)fontSizeChanged
{
    //NSLog(@"size = %f",initValues.font_size);
    initValues.font_size=[fontSize value];
    //NSLog(@"size2 = %f",initValues.font_size);
    NSString * str=[NSString stringWithFormat:@"%.0f",floor(initValues.font_size)];
    [fontSizeLabel setText:str];
    FMDatabase *db=[[SharedDataBaseManager sharedManager] returnShareDb];
    
    [db executeUpdate:@"UPDATE sys_values SET FONT_SIZE=?",str] ;
    
}
-(void)rowHeightChanged{
    initValues.row_height=[rowHeight value];
    //NSLog(@"size2 = %f",initValues.font_size);
    NSString * str=[NSString stringWithFormat:@"%d",initValues.row_height];
    [rowHeightLabel setText:str];
    FMDatabase *db=[[SharedDataBaseManager sharedManager] returnShareDb];
    
    [db executeUpdate:@"UPDATE sys_values SET row_h=?",str] ;
}
-(void)open_switch_changed{
    
    //NSLog(@"open_switch_changed");
    
    FMDatabase *db=[[SharedDataBaseManager sharedManager] returnShareDb];
    NSString * sON=@"0";
    
    if(YES==open_switch.on)
    {
        sON=@"1";
        initValues.open_stuts=1;
        [db executeUpdate:@"UPDATE sys_values SET open_stuts=?",sON] ;
    }
    else{
        
        sON=@"0";
        initValues.open_stuts=0;
        [db executeUpdate:@"UPDATE sys_values SET open_stuts=?",sON] ;
    }
}
-(void)sort_switch_changed{
    FMDatabase *db=[[SharedDataBaseManager sharedManager] returnShareDb];
    NSString * sON=@"0";
    if(YES==sort_switch.on)
    {
        sON=@"1";
        initValues.sort_status=1;
        [db executeUpdate:@"UPDATE sys_values SET sort_status=?",sON] ;
    }
    else{
        
        sON=@"0";
        initValues.sort_status=0;
        [db executeUpdate:@"UPDATE sys_values SET sort_status=?",sON] ;
    }
    
}

-(void)show_switch_changed{
    FMDatabase *db=[[SharedDataBaseManager sharedManager] returnShareDb];
    NSString * sON=@"0";
    if(YES==show_switch.on)
    {
        sON=@"1";
        initValues.show_status=1;
        [db executeUpdate:@"UPDATE sys_values SET show_status=?",sON] ;
    }
    else{
        
        sON=@"0";
        initValues.show_status=0;
        [db executeUpdate:@"UPDATE sys_values SET show_status=?",sON] ;
    }
    
}



//选择行
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1) {
        
        UIAlertView *alertA= [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否要还原初始化数据？" delegate:self cancelButtonTitle:@"是" otherButtonTitles: nil];
        //objectiveC开发中调用方法是用"[]" 例如: [alertA addButtonWithTitle:@"取消"];
        //如果是为方法赋值则类似java 对象.成员 例如 :textFieldA.text
        //添加了一个取消按钮
        [alertA addButtonWithTitle:@"否"];
        //将这个UIAlerView 显示出来
        [alertA show];
        //objective-C 不像java 有自己的垃圾回收机制 所以我们在编写程序中一定要注意释放内存 从一开始就养成良好习惯
        
        
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //NSString* msg = [[NSString alloc] initWithFormat:@"您按下的第%d个按钮！",(int)buttonIndex];
    //NSLog(@"%@",msg);
    if (0==buttonIndex) {
        
        
        FMDatabase *db=[[SharedDataBaseManager sharedManager] returnShareDb];
        
        
        [db executeUpdate:@"DELETE FROM URL "] ;
        [db executeUpdate:@"DELETE FROM PERSON_URL "] ;
        
        [db executeUpdate:@"INSERT INTO url (id,url,url_txt,hits,px) VALUES (?,?,?,1,1)",@"1",@"http://www.sohu.com",@"搜狐"] ;
        [db executeUpdate:@"INSERT INTO url (id,url,url_txt,hits,px) VALUES (?,?,?,1,2)",@"2",@"http://www.sina.cn",@"新浪"] ;
        
        [db executeUpdate:@"INSERT INTO url (id,url,url_txt,hits,px) VALUES (?,?,?,1,3)",@"3",@"https://m.baidu.com",@"百度"] ;
        [db executeUpdate:@"INSERT INTO url (id,url,url_txt,hits,px) VALUES (?,?,?,1,4)",@"4",@"http://www.weibo.com",@"新浪微博"] ;
        [db executeUpdate:@"INSERT INTO url (id,url,url_txt,hits,px) VALUES (?,?,?,1,5)",@"5",@"http://info.3g.qq.com",@"腾讯"] ;
        
        [db executeUpdate:@"INSERT INTO url (id,url,url_txt,hits,px) VALUES (?,?,?,1,6)",@"6",@"http://3g.163.com",@"网易"] ;
        
        
        [db executeUpdate:@"INSERT INTO person_url (id,url,url_txt,hits,px) VALUES (?,?,?,1,1)",@"1",@"http://10.229.128.25:8080/mis",@"MIS"] ;
        [db executeUpdate:@"INSERT INTO person_url (id,url,url_txt,hits,px) VALUES (?,?,?,1,2)",@"2",@"http://10.229.128.8",@"公司主页"] ;
        [db executeUpdate:@"INSERT INTO person_url (id,url,url_txt,hits,px) VALUES (?,?,?,1,3)",@"3",@"http://portalwg.shenhua.cc/oimdiy/login.jsp?appname=webcenter",@"邮箱"] ;
        
        
        [db executeUpdate:@"INSERT INTO person_url (id,url,url_txt,hits,px) VALUES (?,?,?,1,4)",@"4",@"http://www.shenhuagroup.com.cn",@"集团"] ;
        
    }
    
}

//设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==2) {
        return 68.0;
    }
    return 50;
    
}

//设置节段注脚
-(NSString * )tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if (section==0) {
        return @"";
    }
    return @"还原热门网址和个人收藏初始数据，重启后生效。";
    
}

//设置节段注头
-(NSString * )tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return @"全局参数";
    }
    return @"还原";
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
