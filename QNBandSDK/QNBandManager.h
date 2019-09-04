//
//  QNBandManager.h
//  QNDeviceSDK
//
//  Created by Yolanda on 2018/12/29.
//  Copyright © 2018 Yolanda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QNBandEventProtocol.h"
#import "QNCallBackConst.h"
#import "QNBandInfo.h"
#import "QNAlarm.h"
#import "QNSitRemind.h"
#import "QNThirdRemind.h"
#import "QNCleanInfo.h"
#import "QNBandBaseConfig.h"
#import "QNHealthData.h"
#import "QNRealTimeData.h"

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSUInteger, QNExerciseStatus) {
    QNExerciseStatusStart = 81, //APP开始
    QNExerciseStatusFinish = 82, //APP结束
    QNExerciseStatusPaush = 83, //APP暂停
    QNExerciseStatusContinue = 84, //APP继续
    
};

@interface QNBandManager : NSObject

/** EventProtocol */
@property (nonatomic, weak) id<QNBandEventListener> bandEventListener;

- (instancetype)init NS_UNAVAILABLE;

/**
 绑定设备d
 
 @param userId 用户Id
 @param onConfirmBind 通知用户需要在手环上确认
 @param onStatusResult 绑定结果

 */
- (void)bindBandWithUserId:(NSString *)userId onConfirmBind:(QNBindOnConfirmCallback)onConfirmBind onStatusResult:(QNBindResultCallback)onStatusResult;

/**
 设备解绑时，需要调用该方法

 @param callblock 结果的回调 void(^QNObjCallback) (NSNumber *success, NSError *error)
 */
- (void)cancelBindWithUserId:(NSString *)userId callback:(QNObjCallback)callblock;

/**
 检测手环的上次

 @param callblock 结果的回调 void(^QNObjCallback) (NSNumber *same, NSError *error)
 */
- (void)checkSameBindPhone:(QNObjCallback)callblock;

/**
 手环的固件版本、软件版本、电量
 
 该方法不受绑定绑定的影响，即未绑定时也可以使用

 @param callblock 结果的回调 void(^QNObjCallback) (QNBandInfo *info, NSError *error)
 */
- (void)fetchBandInfo:(QNObjCallback)callblock;

/**
 设置手环时间

 @param date 时间
 @param callblock 结果的回调
 */
- (void)syncBandTimeWithDate:(NSDate *)date callback:(QNResultCallback)callblock;

/**
 设置闹钟详情
 
 目前最多支持10个闹钟

 @param alarm QNAlarm
 @param callblock 结果的回调
 */
- (void)syncAlarm:(QNAlarm *)alarm callback:(QNResultCallback)callblock;

/**
 运动目标

 @param stepGoal 运动目标
 @param callblock 结果的回调
 */
- (void)syncGoal:(int)stepGoal callback:(QNResultCallback)callblock;

/**
 用户信息

 @param user QNUser
 @param callblock 结果的回调
 */
- (void)syncUser:(QNUser *)user callback:(QNResultCallback)callblock;

/**
 设置单位、语言、时间制式

 @param metrics QNBandMetrics
 @param callblock 结果的回调
 */
- (void)syncMetrics:(QNBandMetrics *)metrics callback:(QNResultCallback)callblock;

/**
 久坐提醒

 @param sitRemind QNSitRemind
 @param callblock 结果的回调
 */
- (void)syncSitRemind:(QNSitRemind *)sitRemind callback:(QNResultCallback)callblock;

/**
 心率的监听模式

 @param autoFlag YES 自动 NO 手动
 @param interval 心率提醒间隔 (单位分钟)
 @param callblock 结果的回调
 */
- (void)syncHeartRateObserverModeWithAutoFlag:(BOOL)autoFlag interval:(int)interval callback:(QNResultCallback)callblock;


/**
 查找手机开关

 @param openFlag YES 开启 NO 关闭
 @param callblock 结果的回调
 */
- (void)syncFindPhoneWithOpenFlag:(BOOL)openFlag callback:(QNResultCallback)callblock;

/**
 相机模式

 @param openFlag YES 进入拍照模式 NO 退出拍照模式
 @param callblock 结果的回调
 */
- (void)syncCameraModeWithEnterFlag:(BOOL)openFlag callback:(QNResultCallback)callblock;

/**
 抬腕识别模式

 @param openFlag YES 开启抬腕亮屏 NO 关闭抬腕亮屏
 @param callblock 结果的回调
 */
- (void)syncHandRecognizeModeWithOpenFlag:(BOOL)openFlag callback:(QNResultCallback)callblock;

/**
 第三方提醒

 @param thirdRemind 第三方提醒
 @param callblock 结果的回调
 */
- (void)setThirdRemind:(QNThirdRemind *)thirdRemind callback:(QNResultCallback)callblock;

/**
 清除设置

 @param cleanInfo QNCleanInfo
 @param callblock 结果的回调
 */
- (void)resetWithCleanInfo:(QNCleanInfo *)cleanInfo callback:(QNResultCallback)callblock;


/**
 恢复出厂设置
 
 回复出厂设置后，手环会自动重启

 @param callblock 结果的回调
 */
- (void)rebootCallback:(QNResultCallback)callblock;

/**
 快捷设置
 
 仅支持ID为0003且版本号12后续版本(包含12版本)

 @param baseConifg QNBandBaseConfig
 @param callblock 结果的回调
 */
- (void)syncFastSetting:(QNBandBaseConfig *)baseConifg callback:(QNResultCallback)callblock;

/**
 获取实时数据

 @param callblock 结果的回调 void(^QNObjCallback) (QNRealTimeData *data, NSError *error)
 */
- (void)syncRealTimeDataCallback:(QNObjCallback)callblock;


/**
 设置心率提醒

 @param openFlag 是否打开
 @param remind 提醒值
 @param callblock 结果的回调
 */
- (void)setHeartRemindWithOpenFlag:(BOOL)openFlag remind:(NSUInteger)remind callback:(QNResultCallback)callblock;

/**
 设置运动(锻炼)状态

 @param exerciseStatus 运动状态
 @param exerciseType 锻炼类型
 @param callblock  结果的回调
 */
- (void)setExerciseStatus:(QNExerciseStatus)exerciseStatus exerciseType:(QNBandExerciseType)exerciseType callback:(QNResultCallback)callblock;

/**
 确认是否修改锻炼状态

 @param agree 是否同意
 @param exerciseStatus 锻炼的状态
 @param exerciseType 锻炼类型
 @param callblock 结果的回调
 */
- (void)confirmBandModifyExerciseStatusWithAgree:(BOOL)agree exerciseStatus:(QNBandExerciseStatus)exerciseStatus exerciseType:(QNBandExerciseType)exerciseType callback:(QNResultCallback)callblock;

/**
 发送运动数据
 
 @param exerciseData 运动数据
 @param callback  结果的回调 (QNExerciseData *data, NSError *error)
 */
- (void)sendExerciseData:(QNExerciseData *)exerciseData callblock:(QNObjCallback)callback;


/**
 OTA升级

 @param firmwareFilePath 固件存放路径
 @param progressCallback 升级进度回调
 @param resultCallback 升级结果回调
 */
- (void)startDfuWithFirmwareFilePath:(NSString *)firmwareFilePath progressCallback:(void (^)(NSUInteger progress))progressCallback resultCallback:(void (^)(NSError * _Nullable err))resultCallback;


/**
 同步今日数据
 
 @param healthDataType 健康数据类型
 @param callback 结果的回调  运动数据 QNSport 睡眠数据 QNSleep  心率数据 QNHeartRate  锻炼的数据 QNExercise
 */
- (void)syncTodayHealthDataWithHealthDataType:(QNHealthDataType)healthDataType callblock:(QNObjCallback)callback;

/**
 同步历史数据
 
 @param healthDataType 健康数据类型
 @param callback 结果的回调  运动数据 [QNSport] 睡眠数据 [QNSleep]  心率数据 [QNHeartRate]  锻炼的数据 [QNExercise]
 */
- (void)syncHistoryHealthDataWithHealthDataType:(QNHealthDataType)healthDataType callblock:(QNObjCallback)callback;

@end

NS_ASSUME_NONNULL_END
