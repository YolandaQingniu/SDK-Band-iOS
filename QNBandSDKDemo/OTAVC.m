//
//  OTAVC.m
//  QNBandSDKDemo
//
//  Created by Yolanda on 2019/8/28.
//  Copyright © 2019 Yolanda. All rights reserved.
//

#import "OTAVC.h"


@interface OTAVC ()<QNBandEventListener>
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *dfyLabel;
@end

@implementation OTAVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)startOTA:(UIButton *)sender {
    __weak __typeof(self)weakSelf = self;
    NSString *firewarmPath = [[NSBundle mainBundle] pathForResource:@"syd8811_band_v1.3.1" ofType:@"bin"];
    
    [[QNBleApi sharedBleApi].getBandManager startDfuWithFirmwareFilePath:firewarmPath progressCallback:^(NSUInteger progress) {
        double pro = progress / 100.0;
        weakSelf.progressView.progress = pro;
        weakSelf.dfyLabel.text = [NSString stringWithFormat:@"%.2f",pro];
    } resultCallback:^(NSError * _Nullable err) {
        weakSelf.dfyLabel.text = err == nil ? @"升级成功" : @"升级失败";
    }];
}

@end
