//
//  QNOTATool.h
//  QNBandSDKDemo
//
//  Created by Yolanda on 2019/8/28.
//  Copyright © 2019 Yolanda. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QNOTATool : NSObject

- (instancetype)initWithOTAData:(NSData *)data progressCallback:(void (^)(NSInteger progress))progressCallback resultCallback:(void (^)(BOOL success))resultCallback;

- (void)receiveBandOTAData:(NSData *)data;

@end

NS_ASSUME_NONNULL_END
