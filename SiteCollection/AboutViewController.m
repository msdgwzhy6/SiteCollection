//
//  AboutViewController.m
//  SiteCollection
//
//  Created by WangZhengHong on 15/10/13.
//  Copyright © 2015年 WangZhengHong. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    UITableView *myTableView =  [[UITableView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+5, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    myTableView.delegate=self;
    myTableView.dataSource=self;
    
    [self.view addSubview:myTableView];
    myTableView.scrollEnabled=NO;
    self.navigationItem.title=@"关于";
}
//设置节段数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//设置节段行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    
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
    
  
    
    //NSLog(@"font_size = %f",initValues.font_size);
    if (indexPath.section==0) {
        
        if (indexPath.row==0) {
            
            cell.textLabel.text = @"  V1.0 " ;
            //cell.detailTextLabel.text=@"2015.10";

            
            
      }
    }
    
    
    return cell;
    
}
//设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 60;
    
}

//设置节段注脚
-(NSString * )tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    
    return @"  2015.10.15";
    
}

//设置节段注头
-(NSString * )tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    return @" 版本信息";
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
