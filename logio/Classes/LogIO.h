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

@property (nonatomic, copy, readonly) NSString *node;
@property (class, readonly, strong) LogIO *shared;

/**
 Content to LogIO server.

 @param host server host
 @param port server port
 @param node server node name
 @return [GCDAsyncSocket connectToHost:onPort:error:] -> error
 */
- (NSError *)contentHost:(NSString *)host port:(NSUInteger)port node:(NSString*)node NS_SWIFT_NAME(content(host:port:node:));
/**
 Content to LogIO server.

 @param host server host
 @param port server port
 @return [GCDAsyncSocket connectToHost:onPort:error:] -> error
 */
- (NSError *)contentHost:(NSString *)host port:(NSUInteger)port NS_SWIFT_NAME(content(host:port:));

@end

NS_ASSUME_NONNULL_END
