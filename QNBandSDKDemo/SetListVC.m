//
//  SetListVC.m
//  QNBandSDKDemo
//
//  Created by donyau on 2019/7/26.
//  Copyright © 2019 Yolanda. All rights reserved.
//

#import "SetListVC.h"
#import "MBProgressHUD.h"
#import "ScanVC.h"
#import "ExerciseModeCell.h"
#import "HealthDataCell.h"

#define QNCellTitle @"title"
#define QNCellType @"type"

#define QNUserId @"1234567"

typedef NS_ENUM(NSUInteger, QNBandSetType) {
    
    QNBandSetBind = 0,
    QNBandSetCancelBind,
    QNBandSetCheckMac,
    QNBandSetVersionElectric,
    
    QNBandSetSynTime,
    QNBandSetAlarm,
    QNBandSetGoal,
    QNBandSetUser,
    QNBandSetUnit,
    QNBandSetSitRemind,
    QNBandSetAutoHeartRate,
    QNBandSetFindPhone,
    QNBandSetHandRecognize,
    QNBandSetThirdRemind,
    QNBandSetConvenienceSet,
    QNBandSetHeartRateRemind,
    QNBandSetTakePhoto,
    QNBandSetClean,
    QNBandSetRestart,
    QNBandSetRealTimeHealthData,
    
    QNBandSetExercise,
    QNBandSetExerciseData,
    QNBandSetHealthData
};

@interface SetListVC ()<UITableViewDelegate,UITableViewDataSource,QNBleDeviceDiscoveryListener,QNBleConnectionChangeListener,ExerciseModeCellDelegate,HealthDataCellDelegate,QNBandEventListener>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;
@property(nonatomic, strong) NSArray<NSDictionary *> *dataSource;
@property(nonatomic, strong) QNBleDevice *currentBand;

@property(nonatomic, assign) QNExerciseStatus exerciseStatus;
@property(nonatomic, assign) QNBandExerciseType exerciseType;

@property(nonatomic, assign) BOOL isTodayData;
@property(nonatomic, assign) QNHealthDataType healthType;
@end

@implementation SetListVC

#define SetListCellIdentifier @"setListCellIdentifier"
#define SetListExerciseModeCellIdentifier @"setListExerciseModeCellIdentifier"
#define SetListHealthDataCellIdentifier @"setListHealthDataCellIdentifier"

- (void)viewDidLoad {
    [super viewDidLoad];
    self.topConstraint.constant = QNMinTopOffset;
    
    self.dataSource = @[@{QNCellTitle:@"绑定", QNCellType: @(QNBandSetBind)},
                        @{QNCellTitle:@"取消绑定", QNCellType: @(QNBandSetCancelBind)},
                        @{QNCellTitle:@"检测是否同一台手机连接", QNCellType: @(QNBandSetCheckMac)},
                        @{QNCellTitle:@"手环相关信息", QNCellType: @(QNBandSetVersionElectric)},
                        @{QNCellTitle:@"同步时间", QNCellType: @(QNBandSetSynTime)},
                        @{QNCellTitle:@"闹钟", QNCellType: @(QNBandSetAlarm)},
                        @{QNCellTitle:@"用户信息", QNCellType: @(QNBandSetUser)},
                        @{QNCellTitle:@"单位、语言、时间格式", QNCellType: @(QNBandSetUnit)},
                        @{QNCellTitle:@"久坐提醒", QNCellType: @(QNBandSetSitRemind)},
                        @{QNCellTitle:@"心率检测及间隔时间", QNCellType: @(QNBandSetAutoHeartRate)},
                        @{QNCellTitle:@"查找手机", QNCellType: @(QNBandSetFindPhone)},
                        @{QNCellTitle:@"抬腕识别", QNCellType: @(QNBandSetHandRecognize)},
                        @{QNCellTitle:@"第三方提醒", QNCellType: @(QNBandSetThirdRemind)},
                        @{QNCellTitle:@"便捷设置", QNCellType: @(QNBandSetConvenienceSet)},
                        @{QNCellTitle:@"心率提醒", QNCellType: @(QNBandSetHeartRateRemind)},
                        @{QNCellTitle:@"拍照模式", QNCellType: @(QNBandSetTakePhoto)},
                        @{QNCellTitle:@"清除设置", QNCellType: @(QNBandSetClean)},
                        @{QNCellTitle:@"重启", QNCellType: @(QNBandSetRestart)},
                        @{QNCellTitle:@"实时获取心率", QNCellType: @(QNBandSetRealTimeHealthData)},
                        @{QNCellTitle:@"锻炼模式", QNCellType: @(QNBandSetExercise)},
                        @{QNCellTitle:@"更新锻炼数据(锻炼类型由上一列选择)", QNCellType: @(QNBandSetExerciseData)},
                        @{QNCellTitle:@"健康数据", QNCellType: @(QNBandSetHealthData)},
                        ];
    
    [QNBleApi sharedBleApi].discoveryListener = self;
    [QNBleApi sharedBleApi].connectionChangeListener = self;
    
    [QNBleApi sharedBleApi].getBandManager.bandEventListener = self;
    
    self.exerciseStatus = QNExerciseStatusFinish;
    self.exerciseType = QNBandExerciseWalk;

    self.isTodayData = YES;
    self.healthType = QNHealthDataTypeSport;
    
    self.titleLabel.text = @"正在扫描设备";
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self startScan];
    });
}

- (void)startScan {
    NSString *mac = [[NSUserDefaults standardUserDefaults] objectForKey:QNBandBindMac];
    NSString *modeId = [[NSUserDefaults standardUserDefaults] objectForKey:QNBandBindModeId];
    NSString *UUID = [[NSUserDefaults standardUserDefaults] objectForKey:QNBandBindUUID];
    
    self.titleLabel.text = @"正在连接";
    [[QNBleApi sharedBleApi] startBleDeviceDiscovery:^(NSError *error) {
        
    }];
    
    //已经和系统配对的设置，需要从系统蓝牙列表中获取
    [[QNBleApi sharedBleApi] findPairBandWithMac:mac modeId:modeId uuidIdentifier:UUID callback:^(NSError *error) {
        
    }];
}

- (void)onDeviceDiscover:(QNBleDevice *)device {
    NSString *mac = [[NSUserDefaults standardUserDefaults] objectForKey:QNBandBindMac];
    if ([device.mac isEqualToString:mac] == NO) return;
    self.currentBand = device;
    QNUser *user = [[QNUser alloc] init];
    user.userId = QNUserId;
    user.height = 170;
    user.gender = @"female";
    user.birthday = [NSDate dateWithTimeIntervalSince1970:649043924];
    
    [[QNBleApi sharedBleApi] stopBleDeviceDiscorvery:^(NSError *error) {
        
    }];
    [[QNBleApi sharedBleApi] connectDevice:device user:user callback:^(NSError *error) {
        
    }];
}

- (void)onDeviceStateChange:(QNBleDevice *)device scaleState:(QNDeviceState)state {
    NSString *mac = [[NSUserDefaults standardUserDefaults] objectForKey:QNBandBindMac];
    if ([device.mac isEqualToString:mac] == NO) return;
    
    if (state == QNDeviceStateConnected) {
        self.titleLabel.text = @"连接成功";
        self.currentBand = device;
    }
    
    if (state == QNDeviceStateDisconnected || state == QNDeviceStateLinkLoss) {
        self.currentBand = nil;
        self.titleLabel.text = @"正在扫描设备";
        [self startScan];
    }
}

#pragma mark -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QNBandSetType type = [self.dataSource[indexPath.row][QNCellType] unsignedIntegerValue];
    if (type == QNBandSetExercise) {
        ExerciseModeCell *cell = [tableView dequeueReusableCellWithIdentifier:SetListExerciseModeCellIdentifier];
        if (cell == nil) {
            cell = [[ExerciseModeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SetListExerciseModeCellIdentifier];
        }
        cell.delegate = self;
        cell.status = self.exerciseStatus;
        cell.type = self.exerciseType;
        return cell;
    }else if (type == QNBandSetHealthData) {
        HealthDataCell *cell = [tableView dequeueReusableCellWithIdentifier:SetListHealthDataCellIdentifier];
        if (cell == nil) {
            cell = [[HealthDataCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SetListExerciseModeCellIdentifier];
        }
        cell.delegate = self;
        cell.dataType = self.healthType;
        cell.isToday = self.isTodayData;
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SetListCellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SetListCellIdentifier];
        }
        cell.textLabel.text = self.dataSource[indexPath.row][QNCellTitle];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    QNBandSetType type = [self.dataSource[indexPath.row][QNCellType] unsignedIntegerValue];
    if (type == QNBandSetExercise || type == QNBandSetHealthData) {
        return 80;
    }
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self setBandWithIndexPath:indexPath];
}

#pragma mark -
- (void)exerciseModeCellSelect:(QNExerciseStatus)status {
    self.exerciseStatus = status;
    [[[QNBleApi sharedBleApi] getBandManager] setExerciseStatus:status exerciseType:self.exerciseType callback:^(NSError *error) {
        [self alertError:error];
    }];
}

- (void)exerciseTypeCellSelect:(QNBandExerciseType)type {
//    if (self.exerciseStatus != QNExerciseStatusFinish) {
//        [self alertMessage:@"先结束上一锻炼模式"];
//        [self.tableView reloadData];
//        return;
//    }
    self.exerciseType = type;
    [self exerciseModeCellSelect:self.exerciseStatus];

}

- (void)healthDateTypeSelectWithToday:(BOOL)isToday {
    self.isTodayData = isToday;
    [self synHealthData];
}

- (void)healthDataTypeSelect:(QNHealthDataType)dataType {
    self.healthType = dataType;
    [self synHealthData];
}

- (void)synHealthData {
    if (self.isTodayData) {
        [[QNBleApi sharedBleApi].getBandManager syncTodayHealthDataWithHealthDataType:self.healthType callblock:^(id obj, NSError *error) {
            [self alertError:error];
        }];
    }else {
        [[QNBleApi sharedBleApi].getBandManager syncHistoryHealthDataWithHealthDataType:self.healthType callblock:^(id obj, NSError *error) {
            [self alertError:error];
        }];
    }
}


- (void)setBandWithIndexPath:(NSIndexPath *)indexPath {
    QNBandSetType type = [self.dataSource[indexPath.row][QNCellType] unsignedIntegerValue];
    QNBandManager *bandManager = [QNBleApi sharedBleApi].getBandManager;
    switch (type) {
        case QNBandSetBind:
        {
            //当回复被其他人绑定后手环端会自动断开
            [bandManager bindBandWithUserId:QNUserId onConfirmBind:^{
                [self alertMessage:@"请在手环上确认绑定"];
            } onStatusResult:^(QNBandBindStatus bindStatus, NSError *error) {
                if (bindStatus != QNBandBindStatusUnknow) {
                    switch (bindStatus) {
                        case QNBandBindStatusNewUser:
                            [self alertMessage:@"绑定新用户成功"];
                            break;
                        case QNBandBindStatusOtherUser:
                            [self alertMessage:@"该手环已被其他用户绑定"];
                            break;
                        case QNBandBindStatusSameUser:
                            [self alertMessage:@"绑定用户成功"];
                            break;
                            
                        default:
                            break;
                    }
                }else {
                    [self alertError:error];
                }
            }];
            break;
        }
            
        case QNBandSetCancelBind:
        {
            [bandManager cancelBindWithUserId:QNUserId callback:^(id obj, NSError *error) {
                if ([obj boolValue] == NO) {
                    [self alertMessage:@"解绑失败"];
                }else {
                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:QNBandBindMac];
                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:QNBandBindModeId];
                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:QNBandBindUUID];
                    if (self.currentBand) {
                        [[QNBleApi sharedBleApi] disconnectDevice:self.currentBand callback:^(NSError *error) {
                            
                        }];
                    }
                    [UIApplication sharedApplication].keyWindow.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[ScanVC alloc] init]];
                }
            }];
            break;
        }
            
        case QNBandSetCheckMac:
        {
            [bandManager checkSameBindPhone:^(id obj, NSError *error) {
                if (error) {
                    [self alertError:error];
                }else {
                    [self alertMessage:[obj boolValue] ? @"与上次连接的手机相同" : @"与上次连接的手机不同"];
                }
            }];
            break;
        }
            
        case QNBandSetVersionElectric:
        {
            [bandManager fetchBandInfo:^(id obj, NSError *error) {
                if (error) {
                    [self alertError:error];
                }else {
                    QNBandInfo *info = (QNBandInfo *)obj;
                    [self alertMessage:[NSString stringWithFormat:@"固件版本: %d\n软件版本: %d\n电量: %d",info.hardwareVer,info.firmwareVer,info.electric]];
                }
            }];
            break;
        }
            
        case QNBandSetSynTime:
        {
            [bandManager syncBandTimeWithDate:[NSDate date] callback:^(NSError *error) {
                [self alertError:error];
            }];
            break;
        }
            
        case QNBandSetAlarm:
        {
            QNWeek *week = [[QNWeek alloc] init];
            week.sun = YES;
            //设置闹铃时，其提醒周期必须有打开状态的，若周期提醒没有任何选项开启，则闹钟不会有提醒
            QNAlarm *alarm = [[QNAlarm alloc] init];
            alarm.alarmId = 1;
            alarm.openFlag = YES;
            alarm.hour = 8;
            alarm.minture = 0;
            alarm.week = week;
            
            [bandManager syncAlarm:alarm callback:^(NSError *error) {
                [self alertError:error];
            }];
            break;
        }
            
        case QNBandSetGoal:
        {
            [bandManager syncGoal:5000 callback:^(NSError *error) {
                [self alertError:error];
            }];
            break;
        }
            
        case QNBandSetUser:
        {
            QNUser *user = [[QNUser alloc] init];
            user.userId = QNUserId;
            user.height = 170;
            user.weight = 60;
            user.gender = @"female";
            user.birthday = [NSDate dateWithTimeIntervalSince1970:649043924];
            [bandManager syncUser:user callback:^(NSError *error) {
                [self alertError:error];
            }];
            break;
        }
            
        case QNBandSetUnit:
        {
            QNBandMetrics *metrics = [[QNBandMetrics alloc] init];
            [bandManager syncMetrics:metrics callback:^(NSError *error) {
                [self alertError:error];
            }];
            break;
        }
            
        case QNBandSetSitRemind:
        {
            QNWeek *week = [[QNWeek alloc] init];
            week.mon = YES;
            week.tues = YES;
            week.wed = YES;
            week.thur = YES;
            week.fri = YES;
            
            QNSitRemind *remind = [[QNSitRemind alloc] init];
            remind.openFlag = true;
            remind.startHour = 8;
            remind.startMinture = 30;
            remind.endHour = 18;
            remind.endMinture = 0;
            remind.timeInterval = 40;
            remind.week = week;
            
            [bandManager syncSitRemind:remind callback:^(NSError *error) {
                [self alertError:error];
            }];
            break;
        };
            
        case QNBandSetAutoHeartRate:
        {
            QNBandMetrics *metrics = [[QNBandMetrics alloc] init];
            [bandManager syncMetrics:metrics callback:^(NSError *error) {
                [self alertError:error];
            }];
            break;
        }
            
        case QNBandSetFindPhone:
        {
            [bandManager syncFindPhoneWithOpenFlag:YES callback:^(NSError *error) {
                [self alertError:error];
            }];
            break;
        };
            
        case QNBandSetHandRecognize:
        {
            [bandManager syncHandRecognizeModeWithOpenFlag:YES callback:^(NSError *error) {
                [self alertError:error];
            }];
            break;
        };
            
        case QNBandSetThirdRemind:
        {
            QNThirdRemind *remind = [[QNThirdRemind alloc] init];
            remind.call = YES;
            remind.callDelay = 3;
            [bandManager setThirdRemind:remind callback:^(NSError *error) {
                [self alertError:error];
            }];
            break;
        };
            
        case QNBandSetConvenienceSet:
        {
            
            QNBandBaseConfig *config = [[QNBandBaseConfig alloc] init];
            config.heartRateObserver = YES;
            config.handRecog = YES;
            config.findPhone = YES;
            config.lostRemind = YES;
            
            QNUser *user = [[QNUser alloc] init];
            user.userId = QNUserId;
            user.height = 170;
            user.gender = @"female";
            user.birthday = [NSDate dateWithTimeIntervalSince1970:649043924];
            config.user = user;
            
            config.stepGoal = 5000;
            config.metrics = [[QNBandMetrics alloc] init];
            
            [bandManager syncFastSetting:config callback:^(NSError *error) {
                [self alertError:error];
            }];
            break;
        };
            
        case QNBandSetHeartRateRemind: {
            [bandManager setHeartRemindWithOpenFlag:YES remind:140 callback:^(NSError *error) {
                [self alertError:error];
            }];
            break;
        };
        case QNBandSetTakePhoto:
            
            break;
        case QNBandSetClean:
        {
            QNCleanInfo *info = [[QNCleanInfo alloc] init];
            info.alarm = YES;//会清除所有闹钟设置
            info.goal = YES;
            info.metrics = YES;
            info.sitRemind = YES;
            info.lossRemind = YES;
            info.heartRateObserver = YES;
            info.handRecoginze = YES;
            info.bindState = YES;
            info.thirdRemind = YES;
            
            [bandManager resetWithCleanInfo:info callback:^(NSError *error) {
                [self alertError:error];
            }];
            break;
        }
        case QNBandSetRestart:
        {
            [bandManager rebootCallback:^(NSError *error) {
                [self alertError:error];
            }];
            break;
        }
        case QNBandSetRealTimeHealthData:
        {
            [bandManager syncRealTimeDataCallback:^(id obj, NSError *error) {
                if (error) {
                    [self alertError:error];
                }else {
                    QNRealTimeData *data = (QNRealTimeData*)obj;
                    [self alertMessage:[NSString stringWithFormat:@"步数: %ld 距离:%lu 卡路里: %lu 运动时间: %lu 心率: %lu",data.step,(unsigned long)data.distance,(unsigned long)data.calories,(unsigned long)data.active,(unsigned long)data.heartRate]];
                }
            }];
            break;
        }
        case QNBandSetExerciseData:
        {
            //心率数据由手环返回
            QNExerciseData *data = [[QNExerciseData alloc] init];
            data.exerciseType = self.exerciseType;
            data.exerciseTime = 240;
            data.minkm = 3;
            if (self.exerciseType == QNBandExerciseWalk || self.exerciseType == QNBandExerciseRunning) {
                //只有步行和跑步模式支持该三项数据
                data.step = 3000;
                data.calories = 1000;
                data.distance = 1000;
            }
            
            [bandManager sendExerciseData:data callblock:^(id obj, NSError *error) {
                if (error) {
                    [self alertError:error];
                }else {
                    QNExerciseData *receiveData = obj;
                    if (self.exerciseType == QNBandExerciseWalk || self.exerciseType == QNBandExerciseRunning) {
                        [self alertMessage:[NSString stringWithFormat:@"步数 %ld\n卡路里: %ld\n距离: %ld\n运动时长: %ld\n配速: %ld\n心率: %ld",receiveData.step,receiveData.calories,receiveData.distance,receiveData.exerciseTime,receiveData.minkm,receiveData.heartRate]];
                    }else {
                        [self alertMessage:[NSString stringWithFormat:@"卡路里: %ld\n运动时长: %ld\n心率: %ld",receiveData.calories,receiveData.exerciseTime,receiveData.heartRate]];
                    }
                }
            }];
            break;
        }

        default: break;
    }
}

#pragma mark -
- (void)onTakePhotosWithDevice:(QNBleDevice *)device {
    [self alertMessage:@"拍照"];
}

- (void)onFindPhoneWithDevice:(QNBleDevice *)device {
    //收到该信号后，手机作出相应的操作，通知用户
    [self alertMessage:@"寻找手机"];
}

- (void)onStopFindPhoneWithDevice:(QNBleDevice *)device {
    [self alertMessage:@"停止寻找手机"];

}

- (void)onExciseStatusWithExerciseStatus:(QNBandExerciseStatus)exerciseStatus exerciseType:(QNBandExerciseType)exerciseType device:(QNBleDevice *)device {
    //收到用户在手环上触发锻炼模式的状态变更时，可以默认直接回复同意状态的变更，或者弹框询问用户的建议，再下发
    [[[QNBleApi sharedBleApi] getBandManager] confirmBandModifyExerciseStatusWithAgree:YES exerciseStatus:exerciseStatus exerciseType:exerciseType callback:^(NSError *error) {
        [self alertError:error];
    }];
}

#pragma mark -
- (void)alertError:(NSError *)err {
    if (err == nil) {
        [self alertMessage:@"操作成功"];
    }else {
        [self alertMessage:err.userInfo[NSLocalizedFailureReasonErrorKey]];
    }
}

- (void)alertMessage:(NSString *)mesg {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.numberOfLines = 0;
    hud.label.text = mesg;
    [hud hideAnimated:YES afterDelay:2];
}

@end
