//
//  ViewController.m
//  CouchBase-OC
//
//  Created by zxc on 2022/4/26.
//

#import "ViewController.h"
#import "CouchBaseTools.h"
#import "VersionInfo.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)createDatabase
{
    [CouchBaseTools createDatabase];
}
//1-添加数据
- (IBAction)insertVersionInfo
{
    VersionInfo *versionInfo=[[VersionInfo alloc]init];
    NSString *version=[NSString stringWithFormat:@"%u",arc4random()%10] ;
    versionInfo.version=version;
    versionInfo.type=@"SDK";
    versionInfo.time=[self.class getCurrentTime];
    
    [CouchBaseTools  insertVersionInfo:versionInfo];
    
    
}
//查询数据
- (IBAction)queryTable
{
    NSMutableArray *results =  [CouchBaseTools queryTable];
    //NSLog(@"%@",results);
    for (VersionInfo* versionInfo in results) {
        NSLog(@"VersionInfo:type=%@,version=%@,time=%@",versionInfo.type,versionInfo.version,versionInfo.time);
    }

}
- (IBAction)updateTable
{
    NSMutableArray *results =  [CouchBaseTools queryTable];
    //NSLog(@"%@",results);

    //修改所有的VersionInfo-type
    for (VersionInfo* versionInfo in results) {
        versionInfo.type=@"App";
        [CouchBaseTools updateVersionInfo:versionInfo];
    }

    //修改第一个VersinInfo-type
//    VersionInfo *versionInfo=(VersionInfo *)results[0];
//    versionInfo.type=@"App";
//    [CouchBaseTools  updateVersionInfo:versionInfo];
    
    //查询
    //[self queryTable];
    
}
- (IBAction)deleteTable
{
    [CouchBaseTools deleteTable];
}
+(NSString *)getCurrentTime
{
    //获取标准时间
    NSDate *date = [NSDate date];
    [[NSDate date]timeIntervalSince1970];
    //使用formatter格式化后的时间
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH-mm-ss"];
    NSString *time_now = [formatter stringFromDate:date];
    return time_now;
}
@end
