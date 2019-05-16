//
//  LogIO.h
//  logio
//
//  Created by 孙继刚 on 2019/5/16.
//

#import <Foundation/Foundation.h>
#import <CocoaLumberjack/CocoaLumberjack.h>

NS_ASSUME_NONNULL_BEGIN

@interface LogIO: DDAbstractLogger

@property (class, readonly, strong) LogIO *shared;

/**
 Content to LogIO server.

 @param host server host
 @param port server port
 @return [GCDAsyncSocket connectToHost:onPort:error:] -> error
 */
- (NSError *)contentHost:(NSString *)host port:(NSUInteger)port NS_SWIFT_NAME(content(host:port:));

@end

NS_ASSUME_NONNULL_END