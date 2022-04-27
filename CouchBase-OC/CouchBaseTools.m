//
//  CouchBaseTools.m
//  CouchBase-OC
//
//  Created by zxc on 2022/4/26.
//

#import "CouchBaseTools.h"
#import "VersionInfo.h"
#include <CouchbaseLite/CouchbaseLite.h>

@implementation CouchBaseTools

static CBLDatabase *database;
NSError *error;

//使用给定名称和默认数据库配置初始化数据库对象。
//如果数据库尚不存在，将创建该数据库
+ (void)initialize{
    NSError *error;
    database = [[CBLDatabase alloc] initWithName:@"mydb" error:&error];
    if (error) {
        NSLog(@"数据库创建失败");
    }else{
        NSLog(@"数据库创建成功");
    }
}

//创建数据库
+(void)createDatabase
{
    [self initialize];
}
//添加数据
+(void)insertVersionInfo:(VersionInfo *)versionInfo
{
    // 在数据库中创建Doccument.
    //CBLMutableDocument *mutableDoc = [[CBLMutableDocument alloc] init];//此处为随机到document-id，为了方便管理，使用initWithID
    
    CBLMutableDocument *mutableDoc = [[CBLMutableDocument alloc] initWithID:versionInfo.time];
    [mutableDoc setString:versionInfo.version forKey:@"version"];
    [mutableDoc setString:versionInfo.type forKey:@"type"];
    [mutableDoc setString:versionInfo.time forKey:@"time"];

    NSError *error;
    // 保存数据
    BOOL success=  [database saveDocument:mutableDoc error:&error];
    if(success){
        NSLog(@"添加数据成功");
    }else
    {
        NSLog(@"添加数据失败");
    }
    
}
//查询数据
+(NSMutableArray*)queryTable
{
    //集合
    NSMutableArray *array = [NSMutableArray array];
    
    NSError *error;
    
    //此处为条件查找，可放到from的后面 where type
    CBLQueryExpression *type = [[CBLQueryExpression property:@"type"] equalTo:[CBLQueryExpression string:@"SDK"]];
    
    CBLQuery *query = [CBLQueryBuilder select:@[[CBLQuerySelectResult all]]
                                          from:[CBLQueryDataSource database:database]];
    // 执行查询语句
    CBLQueryResultSet *result = [query execute:&error];
    NSArray<CBLQueryResult*> *results=[result allResults];//查询结果
    
    //将查询结果转换为实体类
    for (CBLQueryResult* result in results) {
      
      NSString *type=  [[result.toDictionary allValues][0] valueForKey:@"type"];
      NSString *version=  [[result.toDictionary allValues][0] valueForKey:@"version"];
      NSString *time=  [[result.toDictionary allValues][0] valueForKey:@"time"];
        
      VersionInfo *versionInfo=[[VersionInfo alloc]init];
      versionInfo.type=type;
      versionInfo.version=version;
      versionInfo.time=time;
     //将结果添加到集合
     [array addObject:versionInfo];
    
    }
    return array;
    
}

+(void)updateVersionInfo:(VersionInfo *)versionInfo
{

    NSError *error;
    
    //CBLMutableDocument *document=  [CBLMutableDocument documentWithID:@"versionID"];
    // CBLMutableDocument *doc1= [CBLMutableDocument documentWithID:time];
    
    //CBLMutableDocument *document=  [CBLMutableDocument documentWithID:versionInfo.time];

    NSString *time=versionInfo.time;
    NSLog(@"%@",versionInfo.time);
    
    CBLMutableDocument *document=  [[database documentWithID:versionInfo.time] toMutable];

    if (document) {
        [document setString:@"App" forKey:@"type"];
        BOOL success= [database saveDocument:document error:&error];
        if (success) {
            NSLog(@"数据更新成功");
        }else{
            NSLog(@"数据更新失败");
        }
    }else{
        NSLog(@"document为空");
    }
}
//删除数据库
+(void)deleteTable
{
   NSError *error;
   BOOL success= [database delete:&error];
    if (success) {
        NSLog(@"数据库删除成功");
    }else{
        NSLog(@"数据库删除失败");
    }
}
@end
