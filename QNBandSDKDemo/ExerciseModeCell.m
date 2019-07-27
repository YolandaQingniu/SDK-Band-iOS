//
//  ExerciseModeCell.m
//  QNBandSDKDemo
//
//  Created by donyau on 2019/7/27.
//  Copyright © 2019 Yolanda. All rights reserved.
//

#import "ExerciseModeCell.h"

@interface ExerciseModeCell ()
@property (strong, nonatomic) UISegmentedControl *typeSegControl;
@property (strong, nonatomic) UISegmentedControl *statusSegControl;
@property(nonatomic, strong) UILabel *typeLabel;
@property(nonatomic, strong) UILabel *statusLabel;

@end

@implementation ExerciseModeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.typeLabel = [[UILabel alloc] init];
        self.typeLabel.text = @"锻炼类型";
        [self.contentView addSubview:self.typeLabel];
        [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView);
            make.left.mas_equalTo(20);
            make.width.mas_equalTo(70);
        }];
        self.typeSegControl = [[UISegmentedControl alloc] initWithItems:@[@"步行",@"跑步",@"健身",@"球类",@"游泳"]];
        [self.typeSegControl addTarget:self action:@selector(selectExerciseType:) forControlEvents:UIControlEventValueChanged];
        [self.contentView addSubview:self.typeSegControl];
        [self.typeSegControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(5);
            make.right.mas_equalTo(-5);
            make.left.equalTo(self.typeLabel.mas_right);
        }];
        
        self.statusLabel = [[UILabel alloc] init];
        self.statusLabel.text = @"当前状态";
        [self.contentView addSubview:self.statusLabel];
        [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.typeLabel.mas_bottom);
            make.bottom.equalTo(self.contentView);
            make.left.mas_equalTo(20);
            make.width.equalTo(self.typeLabel);
            make.height.equalTo(self.typeLabel);
        }];
        
        self.statusSegControl = [[UISegmentedControl alloc] initWithItems:@[@"结束",@"开始",@"暂停",@"继续"]];
        [self.statusSegControl addTarget:self action:@selector(selectExerciseStatus:) forControlEvents:UIControlEventValueChanged];
        [self.contentView addSubview:self.statusSegControl];
        [self.statusSegControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.typeSegControl.mas_bottom).offset(10);
            make.bottom.right.mas_equalTo(-5);
            make.left.right.height.equalTo(self.typeSegControl);
        }];
    }
    return self;
}

- (void)setStatus:(QNExerciseStatus)status {
    _status = status;
    NSInteger index = 0;
    switch (status) {
        case QNExerciseStatusStart: index = 1; break;
        case QNExerciseStatusPaush: index = 2; break;
        case QNExerciseStatusContinue: index = 3; break;
        default: index = 0; break;
    }
    self.statusSegControl.selectedSegmentIndex = index;
}

- (void)setType:(QNBandExerciseType)type {
    _type = type;
    NSInteger index = 0;
    switch (type) {
        case QNBandExerciseRunning: index = 1; break;
        case QNBandExerciseFitness: index = 2; break;
        case QNBandExerciseBall: index = 3; break;
        case QNBandExerciseSwim: index = 4; break;
        default: index = 0; break;
    }
    self.typeSegControl.selectedSegmentIndex = index;
}

- (void)selectExerciseType:(UISegmentedControl *)sender {
    if ([self.delegate respondsToSelector:@selector(exerciseModeCellSelect:)]) {
        QNBandExerciseType type = QNBandExerciseWalk;
        switch (sender.selectedSegmentIndex) {
            case 1: type = QNBandExerciseRunning; break;
            case 2: type = QNBandExerciseFitness; break;
            case 3: type = QNBandExerciseBall; break;
            case 4: type = QNBandExerciseSwim; break;
            default: type = QNBandExerciseWalk; break;
        }
        [self.delegate exerciseTypeCellSelect:type];
    }
}

- (void)selectExerciseStatus:(UISegmentedControl *)sender {
        if ([self.delegate respondsToSelector:@selector(exerciseModeCellSelect:)]) {
            QNExerciseStatus status = QNExerciseStatusStart;
            switch (sender.selectedSegmentIndex) {
                case 1: status = QNExerciseStatusStart; break;
                case 2: status = QNExerciseStatusPaush; break;
                case 3: status = QNExerciseStatusContinue; break;
                default: status = QNExerciseStatusFinish; break;
            }
            [self.delegate exerciseModeCellSelect:status];
        }
}

@end
