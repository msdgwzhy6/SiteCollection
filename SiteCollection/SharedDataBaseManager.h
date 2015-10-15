//
//  SharedDataBaseManager.h
//  SiteCollection
//
//  Created by WangZhengHong on 15/10/13.
//  Copyright © 2015年 WangZhengHong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

@interface SharedDataBaseManager : NSObject
typedef struct {
    
    float font_size;
    
    int open_stuts;
    
    int sort_status;
    int show_status;
    int row_height;
    
}SysData;

+ (SharedDataBaseManager *)sharedManager;
-(BOOL) isTableOK:(NSString *)tableName DbName:(FMDatabase *) db2;
-(FMDatabase * )returnShareDb;
-(SysData )returnInitValues;
-(void)closeDB;

@end
