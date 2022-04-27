//
//  CouchBaseTools.h
//  CouchBase-OC
//
//  Created by zxc on 2022/4/26.
//

#import <Foundation/Foundation.h>
#include <CouchbaseLite/CouchbaseLite.h>

NS_ASSUME_NONNULL_BEGIN
@class VersionInfo;

@interface CouchBaseTools : NSObject
//创建数据库
+(void)createDatabase;
//添加数据
+(void)insertVersionInfo:(VersionInfo *)versionInfo;
//查询数据
+(NSMutableArray*)queryTable;
//更新数据
+(void)updateVersionInfo:(VersionInfo *)versionInfo;

//删除数据库
+(void)deleteTable;
@end

NS_ASSUME_NONNULL_END
