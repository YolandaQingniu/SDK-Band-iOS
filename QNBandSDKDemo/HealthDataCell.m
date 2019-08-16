//
//  HealthDataCell.m
//  QNBandSDKDemo
//
//  Created by Yolanda on 2019/7/27.
//  Copyright © 2019 Yolanda. All rights reserved.
//

#import "HealthDataCell.h"

@interface HealthDataCell ()

@property (strong, nonatomic) UISegmentedControl *dateSegControl;
@property (strong, nonatomic) UISegmentedControl *healthSegControl;
@property(nonatomic, strong) UILabel *dateLabel;
@end

@implementation HealthDataCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.dateLabel = [[UILabel alloc] init];
        self.dateLabel.text = @"锻炼类型";
        [self.contentView addSubview:self.dateLabel];
        [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView);
            make.left.mas_equalTo(20);
            make.width.mas_equalTo(70);
            make.height.mas_equalTo(40);
        }];
        self.dateSegControl = [[UISegmentedControl alloc] initWithItems:@[@"今日",@"历史"]];
        [self.dateSegControl addTarget:self action:@selector(selectDateTypedate:) forControlEvents:UIControlEventValueChanged];
        [self.contentView addSubview:self.dateSegControl];
        [self.dateSegControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(5);
            make.right.mas_equalTo(-5);
            make.left.equalTo(self.dateLabel.mas_right);
        }];
        

        self.healthSegControl = [[UISegmentedControl alloc] initWithItems:@[@"运动",@"睡眠",@"心率",@"步行",@"跑步",@"健身",@"球类",@"游泳"]];
        [self.healthSegControl addTarget:self action:@selector(selectHealthType:) forControlEvents:UIControlEventValueChanged];
        [self.contentView addSubview:self.healthSegControl];
        [self.healthSegControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.dateSegControl.mas_bottom).offset(10);
            make.bottom.right.mas_equalTo(-5);
            make.right.height.equalTo(self.dateSegControl);
            make.left.mas_equalTo(20);
        }];
    }
    return self;
}

- (void)setDataType:(QNHealthDataType)dataType {
    _dataType = dataType;
    NSInteger index = 0;
    switch (dataType) {
        case QNHealthDataTypeSleep: index = 1; break;
        case QNHealthDataTypeHeart: index = 2; break;
        case QNHealthDataTypeWalk: index = 3; break;
        case QNHealthDataTypeRunning: index = 4; break;
        case QNHealthDataTypeFitness: index = 5; break;
        case QNHealthDataTypeBall: index = 6; break;
        case QNHealthDataTypeSwim: index = 7; break;
        default:
            break;
    }
    self.healthSegControl.selectedSegmentIndex = index;
}


- (void)setIsToday:(BOOL)isToday {
    _isToday = isToday;
    self.dateSegControl.selectedSegmentIndex = isToday ? 0 : 1;
}
- (void)selectDateTypedate:(UISegmentedControl *)sender {
    if ([self.delegate respondsToSelector:@selector(healthDateTypeSelectWithToday:)]) {
        [self.delegate healthDateTypeSelectWithToday:sender.selectedSegmentIndex == 0];
    }
}

- (void)selectHealthType:(UISegmentedControl *)sender {
    QNHealthDataType type = QNHealthDataTypeSport;
    switch (sender.selectedSegmentIndex) {
        case 1: type = QNHealthDataTypeSleep; break;
        case 2: type = QNHealthDataTypeHeart; break;
        case 3: type = QNHealthDataTypeWalk; break;
        case 4: type = QNHealthDataTypeRunning; break;
        case 5: type = QNHealthDataTypeFitness; break;
        case 6: type = QNHealthDataTypeBall; break;
        case 7: type = QNHealthDataTypeSwim; break;
        default:
            break;
    }
    
    if ([self.delegate respondsToSelector:@selector(healthDataTypeSelect:)]) {
        [self.delegate healthDataTypeSelect:type];
    }
}

@end
