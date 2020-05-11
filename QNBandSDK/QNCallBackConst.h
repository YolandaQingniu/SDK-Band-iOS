
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
    QNBandBindStatusSameUser = 102, //设备和当前绑定的用户一致
    QNBandBindStatusBeginTouchBind = 201, //用户开始长按确认绑定按钮
    QNBandBindStatusStopTouchBind = 202, //用户松开长按确认绑定按钮，此时未绑定
};

typedef void(^QNResultCallback) (NSError *error);
typedef void(^QNResultCallback) (NSError *error);
typedef void(^QNObjCallback) (id obj, NSError *error);
typedef void(^QNBindResultCallback) (QNBandBindStatus bindStatus, NSError *error);
typedef void(^QNBindOnConfirmCallback) (void);
