
//
//  QNCallBackConst.h
//  QNDeviceSDKDemo
//
//  Created by Yolanda on 2018/3/31.
//  Copyright © 2018年 Yolanda. All rights reserved.
//


typedef NS_ENUM(NSUInteger, QNBandBindStatus) {
    QNBandBindStatusUnknow = 0,
    QNBandBindStatusNewUser = 100, //设备绑定新用户成功
    QNBandBindStatusOtherUser = 101, //设备已经被其他用户绑定
    QNBandBindStatusSameUser = 100, //设备和当前绑定的用户一致
};

typedef void(^QNResultCallback) (NSError *error);
typedef void(^QNObjCallback) (id obj, NSError *error);
typedef void(^QNBindResultCallback) (QNBandBindStatus bindStatus, NSError *error);
typedef void(^QNBindOnConfirmCallback) (void); 
