//
//  QNHealthData.h
//  QNDeviceSDK
//
//  Created by Yolanda on 2019/1/3.
//  Copyright © 2019 Yolanda. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, QNHealthDataType) {
    QNHealthDataTypeSport = 300, //运动数据
    QNHealthDataTypeSleep = 301, //睡眠数据
    QNHealthDataTypeHeart = 302, //心率数据
    QNHealthDataTypeWalk = 303, //行走数据
    QNHealthDataTypeRunning = 304, //跑步数据
    QNHealthDataTypeFitness = 305, //健身数据
    QNHealthDataTypeBall = 306, //球类运动数据
    QNHealthDataTypeSwim = 307, //游泳运动数据
};

typedef NS_ENUM(NSUInteger, QNBandExerciseType) {
    QNBandExerciseWalk = 1, //行走
    QNBandExerciseRunning = 2, //跑步
    QNBandExerciseFitness = 3, //健身
    QNBandExerciseBall = 4, //球类
    QNBandExerciseSwim = 5, //游泳
};

typedef NS_ENUM(NSUInteger, QNSleepStype) {
    QNSleepSober = 1, //清醒
    QNSleepLight, //浅睡
    QNSleepDeep, //深睡
    QNSleepSport, //运动
};

#pragma mark -
@interface QNSportItem : NSObject
/** 当前序号 */
@property (nonatomic, assign) NSUInteger curCNT;
/** 开始时间 */
@property (nonatomic, strong) NSDate *startDate;
/** 结束时间 */
@property (nonatomic, strong) NSDate *endDate;
/** 运动步数 */
@property (nonatomic, assign) NSUInteger step;
/** 运动时间 */
@property (nonatomic, assign) NSUInteger activeTime;
/** 卡路里 */
@property (nonatomic, assign) NSUInteger calories;
/** 距离 */
@property (nonatomic, assign) NSUInteger distance;
@end

@interface QNSport : NSObject
/** 记录时间 */
@property (nonatomic, strong) NSDate *date;
/** 当天总步数 */
@property (nonatomic, assign) NSUInteger sumStep;
/** 当天卡路里 */
@property (nonatomic, assign) NSUInteger sumCalories;
/** 当天总运动距离 */
@property (nonatomic, assign) NSUInteger sumDistance;
/** 当天运动时间 */
@property (nonatomic, assign) NSUInteger sumActiveTime;
/** 运动详情 */
@property (nonatomic, strong, nullable) NSMutableArray<QNSportItem *> *sportItems;
@end

#pragma mark -
@interface QNSleepItem : NSObject
/** 当前序号 */
@property (nonatomic, assign) NSUInteger curCNT;
/** 开始时间 */
@property (nonatomic, strong) NSDate *startDate;
/** 结束时间 */
@property (nonatomic, strong) NSDate *endDate;
/** 睡眠类型 */
@property (nonatomic, assign) QNSleepStype sleepType;
/** 睡眠时间 */
@property (nonatomic, assign) NSUInteger sleepTime;

@end

@interface QNSleep : NSObject
/** 记录时间 */
@property (nonatomic, strong) NSDate *date;
/** 总睡眠时间(minture) */
@property (nonatomic, assign) NSUInteger sumSleepMinute;
/** 深睡时间(minture) */
@property (nonatomic, assign) NSUInteger sumDeepSleepMinute;
/** 浅睡时间(minture) */
@property (nonatomic, assign) NSUInteger sumLightSleepMinute;
/** 清醒时间(minture) */
@property (nonatomic, assign) NSUInteger sumSoberMinute;
/** 运动时间(minture) */
@property (nonatomic, assign) NSUInteger sumSportMinute;
/** 睡眠详情 */
@property (nonatomic, strong, nullable) NSMutableArray<QNSleepItem *> *sleepItems;
@end

#pragma mark -
@interface QNHeartRateItem : NSObject
/** 当前序号 */
@property (nonatomic, assign) NSUInteger curCNT;
/** 测量时间 */
@property (nonatomic, strong) NSDate *date;
/** 心率值 */
@property (nonatomic, assign) NSUInteger heartRate;

@end

@interface QNHeartRate : NSObject
/** 记录时间 */
@property (nonatomic, strong) NSDate *date;
/** 平稳心率 */
@property (nonatomic, assign) NSUInteger slientHeartRate;
/** 脂肪燃烧 */
@property (nonatomic, assign) NSUInteger burnFatThreshold;
/** 有氧锻炼 */
@property (nonatomic, assign) NSUInteger aerobicThreshold;
/** 极限锻炼 */
@property (nonatomic, assign) NSUInteger limitThreshold;
/** 心率详情 */
@property (nonatomic, strong, nullable) NSMutableArray<QNHeartRateItem *> *heartRateItems;

@end

@interface QNExerciseItem : NSObject
/** 开始时间 */
@property (nonatomic, strong) NSDate *startDate;
/** 结束时间 */
@property (nonatomic, strong) NSDate *endDate;
/** 步数 */
@property (nonatomic, assign) NSUInteger step;
/** 消耗卡路里 */
@property (nonatomic, assign) NSUInteger calories;
/** 距离 (米) */
@property (nonatomic, assign) NSUInteger distance;
/** 运动时长（秒） */
@property (nonatomic, assign) NSUInteger exerciseTime;
/** 配速(秒) */
@property (nonatomic, assign) NSUInteger minkm;
/** 心率 */
@property (nonatomic, assign) NSUInteger heartRate;
@end

@interface QNExercise : NSObject
/** 锻炼类型*/
@property(nonatomic, assign) QNBandExerciseType exerciseType;
/** 记录时间 */
@property (nonatomic, strong) NSDate *date;
/** 心率详情 */
@property (nonatomic, strong, nullable) NSMutableArray<QNExerciseItem *> *exerciseItems;
@end


@interface QNExerciseData : NSObject
/** 锻炼类型*/
@property(nonatomic, assign) QNBandExerciseType exerciseType;
/** 步数 */
@property (nonatomic, assign) NSUInteger step;
/** 消耗卡路里 */
@property (nonatomic, assign) NSUInteger calories;
/** 距离 (米) */
@property (nonatomic, assign) NSUInteger distance;
/** 运动时长（秒） */
@property (nonatomic, assign) NSUInteger exerciseTime;
/** 配速(秒) */
@property (nonatomic, assign) NSUInteger minkm;
/** 心率 */
@property (nonatomic, assign) NSUInteger heartRate;
@end


NS_ASSUME_NONNULL_END
