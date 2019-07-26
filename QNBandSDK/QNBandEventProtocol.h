//
//  QNBandEventProtocol.h
//  QNDeviceSDKDemo
//
//  Created by Yolanda on 2019/1/22.
//  Copyright © 2019 Yolanda. All rights reserved.
//

#import "QNBleDevice.h"
#import "QNHealthData.h"

typedef NS_ENUM(NSUInteger, QNBandExerciseStatus) {
    QNBandBindPauseExercise = 1, //设备端暂停锻炼
    QNBandBindContinueExercise = 2, //设备端继续锻炼
    QNBandBindEndExercise , //设备端结束锻炼
};


@protocol QNBandEventListener <NSObject>
@optional
/**
 拍照回调

 @param device QNBleDevice
 */
- (void)onTakePhotosWithDevice:(QNBleDevice *)device;

/**
 触发查找手机回调

 @param device QNBleDevice
 */
- (void)onFindPhoneWithDevice:(QNBleDevice *)device;

/**
 触发停止手机回调
 
 @param device QNBleDevice
 */
- (void)onStopFindPhoneWithDevice:(QNBleDevice *)device;

/**
 手环端触发锻炼状态的改变
 
 @param exerciseStatus 锻炼状态
 @param exerciseType 锻炼类型
@param device QNBleDevice
 */
- (void)onExciseStatusWithExerciseStatus:(QNBandExerciseStatus)exerciseStatus exerciseType:(QNBandExerciseType)exerciseType device:(QNBleDevice *)device;

@end
