//
//  ScanCell.m
//  QNBandSDKDemo
//
//  Created by donyau on 2019/7/26.
//  Copyright © 2019 Yolanda. All rights reserved.
//

#import "ScanCell.h"

@interface ScanCell ()
@property (strong, nonatomic) UILabel *bleLabel;
@property (strong, nonatomic) UILabel *rssiLabel;
@property (strong, nonatomic) UILabel *macLabel;
@property (strong, nonatomic) UILabel *modeIdLabel;

@end

@implementation ScanCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.bleLabel = [[UILabel alloc] init];
        self.rssiLabel = [[UILabel alloc] init];
        self.macLabel.textAlignment = NSTextAlignmentCenter;
        self.macLabel = [[UILabel alloc] init];
        self.macLabel.textAlignment = NSTextAlignmentCenter;
        self.macLabel.textAlignment = NSTextAlignmentRight;
        self.modeIdLabel = [[UILabel alloc] init];
        
        [self.contentView addSubview:self.bleLabel];
        [self.contentView addSubview:self.rssiLabel];
        [self.contentView addSubview:self.macLabel];
        [self.contentView addSubview:self.modeIdLabel];

        [self.bleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(5);
            make.top.bottom.equalTo(self.contentView);
            make.width.mas_equalTo(100);
        }];
        
        [self.rssiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bleLabel.mas_right);
            make.top.equalTo(self.contentView);
            make.width.mas_equalTo(45);
        }];
        
        [self.modeIdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bleLabel.mas_right);
            make.bottom.equalTo(self.contentView);
            make.width.mas_equalTo(45);
            make.height.equalTo(self.rssiLabel);
        }];
        
        [self.macLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.rssiLabel.mas_right);
            make.top.bottom.equalTo(self.contentView);
            make.right.equalTo(self.contentView).offset(-10);
        }];

    }
    return self;
}



- (void)setDevice:(QNBleDevice *)device {
    _device = device;
    self.bleLabel.text = device.bluetoothName;
    self.rssiLabel.text = [NSString stringWithFormat:@"%@",device.RSSI];
    self.modeIdLabel.text = device.modeId;
    self.macLabel.text = device.mac;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
