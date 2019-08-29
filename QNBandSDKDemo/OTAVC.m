//
//  OTAVC.m
//  QNBandSDKDemo
//
//  Created by Yolanda on 2019/8/28.
//  Copyright © 2019 Yolanda. All rights reserved.
//

#import "OTAVC.h"
#import "QNOTATool.h"

#define QNWristBinStageSize 4096 //一个阶段的预期大小
#define QNWristOTABinTimeInterval 20 //单位毫秒
#define QNWristOTAMaxFailNum 3 //最大失败次数

@interface OTAVC ()<QNBandEventListener>
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property(nonatomic, strong) NSData *data; //固件包数据
@property(nonatomic, assign) NSInteger sendDataSize; //已经发送大小
@property(nonatomic, assign) NSInteger currentSize; //当前包的大小
@property(nonatomic, assign) NSInteger currentPageSize; //当前阶段数据的长度
@property(nonatomic, assign) NSInteger failNum; //已经失败的次数
@property(nonatomic, strong) QNOTATool *OTATool;
@end

@implementation OTAVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)startOTA:(UIButton *)sender {
    NSString *firewarmPath = [[NSBundle mainBundle] pathForResource:@"syd8811_band_v1.3.1" ofType:@"bin"];
    if (firewarmPath == nil) {
        NSLog(@"未找到可升级文件");
        return;
    }
    NSData *data = [NSData dataWithContentsOfFile:firewarmPath];
    
    __weak __typeof(self)weakSelf = self;
    self.OTATool = [[QNOTATool alloc] initWithOTAData:data progressCallback:^(NSInteger progress) {
        weakSelf.progressView.progress = progress / 100.0;
    } resultCallback:^(BOOL success) {
        
    }];
}

- (void)receiveOTAData:(NSData *)data device:(QNBleDevice *)device {
    [self.OTATool receiveBandOTAData:data];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [QNBleApi sharedBleApi].getBandManager.bandEventListener = self;
}

@end
