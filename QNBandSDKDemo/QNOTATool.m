//
//  QNOTATool.m
//  QNBandSDKDemo
//
//  Created by Yolanda on 2019/8/28.
//  Copyright © 2019 Yolanda. All rights reserved.
//

#import "QNOTATool.h"

#define QNPhaseSize 4096 //每个阶段的预期大小
#define QNPackTimeInterval 20 //每包发送间隔时间，目前测试20ms是比较理想的间隔时间，小于20ms失败率较高，可以根据情况适当的调大间隔
#define QNPhaseAllowFailNum 3 //每阶段允许的失败次数

@interface QNOTATool ()
@property(nonatomic, strong) NSData *data;
@property(nonatomic, assign) NSInteger sendDataSize; //已经发送的大小
@property(nonatomic, assign) NSInteger currentPhaseSize; //当前阶段数据大小
@property(nonatomic, assign) NSInteger currentPhaseCheckSum; //当前阶段校验
@property(nonatomic, assign) NSInteger failNum; //失败的次数
@property(nonatomic, strong) void (^progressCallback)(NSInteger progress);
@property(nonatomic, strong) void (^resultCallback)(BOOL success);

@end

@implementation QNOTATool

- (instancetype)initWithOTAData:(NSData *)data progressCallback:(void (^)(NSInteger))progressCallback resultCallback:(void (^)(BOOL))resultCallback {
    if (self = [super init]) {
        self.data = data;
        self.progressCallback = progressCallback;
        self.resultCallback = resultCallback;
        [self startUpdate];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self writePhaseMessage];
        });
    }
    return self;
}

- (void)setSendDataSize:(NSInteger)sendDataSize {
    _sendDataSize = sendDataSize;
    !self.progressCallback ?: self.progressCallback(sendDataSize / ((double)self.data.length));
}

- (void)receiveBandOTAData:(NSData *)data {
    if (data.length < 2) return;
    const Byte *bytes = data.bytes;
    NSString *headerStr = [[NSString stringWithFormat:@"%02x%02x",bytes[0],bytes[1]] uppercaseString];
    if ([headerStr isEqualToString:@"0E06"] == NO) return;
    
    BOOL successFlag = bytes[3] == 0x00;
    if (successFlag == NO) {
        self.failNum += 1;
        if (self.failNum >= QNPhaseAllowFailNum) {
            !self.resultCallback ?: self.resultCallback(NO);
            return;
        }
        //重新发送当前阶段数据
        self.sendDataSize = self.sendDataSize - self.currentPhaseSize;
        [self writePhaseMessage];
        return;
    }
    
    //继续发送下一阶段数据
    if (self.data.length > self.sendDataSize) {
        self.failNum = 0;
        [self writePhaseMessage];
        return;
    }
    
    BOOL gradeSuccess = [self updateGrade];
    if (gradeSuccess == NO) {
        !self.resultCallback ?: self.resultCallback(NO);
        return;
    };
    !self.resultCallback ?: self.resultCallback(YES);
}


#pragma mark - 开始升级 0x16
- (BOOL)startUpdate {
    NSUInteger dataLength = 2;
    Byte sendByte[dataLength];
    sendByte[0] = 0x16;
    sendByte[1] = 0x00;
    NSData *data = [NSData dataWithBytes:sendByte length:dataLength];
    return [[QNBleApi sharedBleApi].getBandManager writeOTAData:data];
}

#pragma mark - 升级包传输0x14
- (void)writePhaseMessage {
    
    NSInteger currentPhaseSize = QNPhaseSize;
    if (self.sendDataSize + QNPhaseSize > self.data.length) {
        currentPhaseSize = self.data.length - self.sendDataSize;
    }
    
    NSUInteger dataLength = 20;
    Byte sendByte[dataLength];
    sendByte[0] = 0x14;
    sendByte[1] = 0x13;
    sendByte[2] = (self.sendDataSize & 0x000000FF);
    sendByte[3] = (self.sendDataSize & 0x0000FF00) >> 8;
    sendByte[4] = (self.sendDataSize & 0x00FF0000) >> 16;
    sendByte[5] = (self.sendDataSize & 0xFF000000) >> 24;
    [self updatePhaseState];
    sendByte[6] = (self.currentPhaseSize & 0X00FF);
    sendByte[7] = (self.currentPhaseSize & 0XFF00) >> 8;
    
    sendByte[8] = self.currentPhaseCheckSum & 0xFF;
    sendByte[9] = (self.currentPhaseCheckSum >> 8) & 0xFF;
    
    for (int i = 10; i < 20; i ++) {
        sendByte[i] = 0x00;
    }
    
    NSData *data = [NSData dataWithBytes:sendByte length:dataLength];
    if ([[QNBleApi sharedBleApi].getBandManager writeOTAData:data]) {
        !self.resultCallback ?: self.resultCallback(NO);
        return;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(QNPackTimeInterval * NSEC_PER_MSEC)), dispatch_get_main_queue(), ^{
        [self writePack];
    });
}

- (void)writePack {
    NSInteger currentPackSize = 20;
    //当前阶段已发送
    NSInteger currentPhaseSend = self.sendDataSize % QNPhaseSize;
    if (currentPhaseSend + currentPackSize > self.currentPhaseSize) {
        currentPackSize = self.currentPhaseSize - currentPhaseSend;
    }
    
    NSData *data = [self.data subdataWithRange:NSMakeRange(self.sendDataSize, currentPackSize)];
    
    self.sendDataSize += currentPackSize;
    
    if ([[QNBleApi sharedBleApi].getBandManager writeOTAData:data]) {
        !self.resultCallback ?: self.resultCallback(NO);
        return;
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(QNPackTimeInterval * NSEC_PER_MSEC)), dispatch_get_main_queue(), ^{
        if (self.sendDataSize % QNPhaseSize == 0 || self.sendDataSize == self.data.length) {
            if ([[QNBleApi sharedBleApi].getBandManager readOTAStatus] == NO) {
                !self.resultCallback ?: self.resultCallback(NO);
                return;
            }
        }else {
            [self writePack];
        }
    });
}

- (void)updatePhaseState {
    NSInteger nextPhaseSize = QNPhaseSize;
    if (floor(self.sendDataSize / QNPhaseSize) * QNPhaseSize + QNPhaseSize > self.data.length) {
        nextPhaseSize = self.data.length % QNPhaseSize;
    }
    self.currentPhaseSize = nextPhaseSize;
    
    NSData *phaseData = [self.data subdataWithRange:NSMakeRange(self.sendDataSize, nextPhaseSize)];
    const Byte *bytes = phaseData.bytes;
    NSInteger size = 0;
    for (int i = 0; i < phaseData.length; i ++) {
        size += bytes[i];
    }
    self.currentPhaseCheckSum = size;
}

#pragma mark - 升级GRADE
- (BOOL)updateGrade {
    NSUInteger dataLength = 8;
    Byte sendByte[dataLength];
    sendByte[0] = 0x15;
    sendByte[1] = 0x04;
    
    NSInteger size = self.sendDataSize;
    sendByte[2] = size & 0x000000FF;
    sendByte[3] = (size & 0x0000FF00) >> 8;
    sendByte[4] = (size & 0x00FF0000) >> 16;
    sendByte[5] = (size & 0xFF000000) >> 24;
    
    NSInteger sum = 0;
    const Byte *bytes = self.data.bytes;
    for (int i = 0; i < self.data.length; i ++) {
        sum += bytes[i];
    }
    
    sendByte[6] = sum & 0xFF;
    sendByte[7] = (sum & 0xFF00) >> 8;
    
    NSData *data = [NSData dataWithBytes:sendByte length:dataLength];
    return ![[QNBleApi sharedBleApi].getBandManager writeOTAData:data];
}

@end
