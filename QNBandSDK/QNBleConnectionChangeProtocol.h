//
//  QNBleConnectionChangeProtocol.h
//  QNDeviceSDKDemo
//
//  Created by Yolanda on 2018/3/31.
//  Copyright © 2018年 Yolanda. All rights reserved.
//

#import "QNBleDevice.h"

@protocol QNBleConnectionChangeListener <NSObject>
/**
 正在连接的回调
 
 @param device QNBleDevice
 */
- (void)onConnecting:(QNBleDevice *)device;


/**
 连接成功的回调
 
 @param device QNBleDevice
 */
- (void)onConnected:(QNBleDevice *)device;


/**
 设备的服务搜索完成
 
 @param device QNBleDevice
 */
- (void)onServiceSearchComplete:(QNBleDevice *)device;


/**
 正在断开连接
 
 @param device QNBleDevice
 */
- (void)onDisconnecting:(QNBleDevice *)device;


/**
 连接错误
 
 @param device QNBleDevice
 @param error 错误代码
 */
- (void)onConnectError:(QNBleDevice *)device error:(NSError *)error;

@end

