//
//  LogIO.m
//  logio
//
//  Created by 孙继刚 on 2019/5/16.
//

#import "LogIO.h"
#import <CocoaAsyncSocket/GCDAsyncSocket.h>

#define kREGIST @"+node|%@|%@\r\n"
#define kFORMAT @"+log|%@|%@|%@|%@\r\n"

@interface LogIO () <GCDAsyncSocketDelegate> {
    GCDAsyncSocket *_socket;
    NSUInteger _msgTag;
    NSString *_node;
    NSString *_stream;
}
@end

@implementation LogIO

+ (LogIO *)shared {
    static LogIO *shared;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [self new];
    });
    return shared;
}
- (NSString *)node {
    if (_node != nil) { return _node; }
    NSString *node = [NSUserDefaults.standardUserDefaults stringForKey:@"logio.node"];
    if (node == nil || node.length == 0) {
        node = [NSString stringWithFormat:@"0x%lX", (long)@(NSDate.date.timeIntervalSince1970 * 1000).integerValue];
        [NSUserDefaults.standardUserDefaults setObject:node forKey:@"logio.node"];
    }
    _node = node;
    return _node;
}
- (void)close {
    [_socket disconnectAfterWriting];
}
- (BOOL)isDisconnected { return _socket == nil || _socket.isDisconnected; }
- (BOOL)isConnected { return _socket.isConnected; }
- (NSError *)contentHost:(NSString *)host port:(NSUInteger)port {
    return [self contentHost:host port:port node:self.node];
}
- (NSError *)contentHost:(NSString *)host port:(NSUInteger)port node:(NSString*)node {
    _socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    NSError *err;
    [_socket connectToHost:host onPort:port error:&err];
    if (err == nil) {
        _msgTag = 0;
        _node = node ?: UIDevice.currentDevice.name;
        _stream = NSBundle.mainBundle.infoDictionary[@"CFBundleDisplayName"] ?: NSBundle.mainBundle.infoDictionary[@"CFBundleName"];
        [self sendMsg:[NSString stringWithFormat:kREGIST, _node, _stream]];
    }
    return err;
}

- (void)logMessage:(DDLogMessage *)logMessage {
    [super logMessage:logMessage];
    NSString *log = _logFormatter ? [_logFormatter formatLogMessage:logMessage] : logMessage.message;
    if (log == nil) { return; }

    [self sendMsg:[NSString stringWithFormat:kFORMAT, _stream, _node, @(logMessage.level), log]];
}

- (void)sendMsg:(NSString *)msg {
    NSAssert(_socket != nil, @"*** MUST SET [LogIO.shared contentHost:port:] ***");

    [_socket writeData:[msg dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:_msgTag];
    _msgTag += 1;
}

- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port {
    NSLog(@"logio: socket did content to url: tcp://%@:%@", host, @(port));
}
- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err {
    NSLog(@"logio: socket did disconnect: %@", err);
}
- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag {
    NSLog(@"logio: message [%@] sent.", @(tag));
}

@end
