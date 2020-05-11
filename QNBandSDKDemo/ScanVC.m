//
//  ScanVC.m
//  QNBandSDKDemo
//
//  Created by Yolanda on 2019/7/26.
//  Copyright © 2019 Yolanda. All rights reserved.
//

#import "ScanVC.h"
#import "ScanCell.h"
#import "SetListVC.h"

@interface ScanVC ()<UITableViewDelegate,UITableViewDataSource,QNBleDeviceDiscoveryListener>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *scanBtn;

@property(nonatomic, strong) NSMutableArray<QNBleDevice *> *devices;

@end

@implementation ScanVC

#define ScanCellIdentifier @"scanCellIdentifier"

- (void)viewDidLoad {
    [super viewDidLoad];
    self.topConstraint.constant = QNMinTopOffset;
    [QNBleApi sharedBleApi].discoveryListener = self;
    self.devices = [NSMutableArray<QNBleDevice *> array];
}

- (IBAction)selectScanState:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        [[QNBleApi sharedBleApi] startBleDeviceDiscovery:^(NSError *error) {
            
        }];
    }else {
        [[QNBleApi sharedBleApi] stopBleDeviceDiscorvery:^(NSError *error) {
            
        }];
    }
}

- (void)onDeviceDiscover:(QNBleDevice *)device {
    if (device.deviceType != QNDeviceTypeBand) {
        return;
    }
    [self.devices addObject:device];
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.devices.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ScanCell *cell = [tableView dequeueReusableCellWithIdentifier:ScanCellIdentifier];
    if (cell == nil) {
        cell = [[ScanCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ScanCellIdentifier];
    }
    cell.device = self.devices[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    QNBleDevice *device = self.devices[indexPath.row];
    if (device == nil) return;
    
    [[NSUserDefaults standardUserDefaults] setValue:device.mac forKey:QNBandBindMac];
    [[NSUserDefaults standardUserDefaults] setValue:device.modeId forKey:QNBandBindModeId];
    [[NSUserDefaults standardUserDefaults] setValue:device.uuidIdentifier forKey:QNBandBindUUID];
    
    [UIApplication sharedApplication].keyWindow.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[SetListVC alloc] init]];
}


@end
