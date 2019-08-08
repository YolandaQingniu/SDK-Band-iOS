//
//  QNRealTimeData.h
//  QNDeviceSDK
//
//  Created by qiudongquan on 2019/8/8.
//  Copyright © 2019 Yolanda. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QNRealTimeData : NSObject
/// 步数
@property(nonatomic, assign) NSUInteger step;
/// 卡路里
@property(nonatomic, assign) NSUInteger calories;
/// 运动距离
@property(nonatomic, assign) NSUInteger distance;
/// 运动时间，单位分钟
@property(nonatomic, assign) NSUInteger active;
/// 心率数据
@property(nonatomic, assign) NSUInteger heartRate;
@end

NS_ASSUME_NONNULL_END
