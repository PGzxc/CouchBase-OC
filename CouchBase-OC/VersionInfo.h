//
//  VersionInfo.h
//  CouchBase-OC
//
//  Created by zxc on 2022/4/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VersionInfo : NSObject
@property(nonatomic,strong) NSString *version;
@property(nonatomic,strong) NSString *type;
@property(nonatomic,strong) NSString *time;

@end

NS_ASSUME_NONNULL_END
