//
//  HealthDataCell.h
//  QNBandSDKDemo
//
//  Created by Yolanda on 2019/7/27.
//  Copyright © 2019 Yolanda. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol HealthDataCellDelegate <NSObject>

- (void)healthDateTypeSelectWithToday:(BOOL)isToday;
- (void)healthDataTypeSelect:(QNHealthDataType)dataType;

@end
@interface HealthDataCell : UITableViewCell
@property(nonatomic, weak) id<HealthDataCellDelegate> delegate;

@property(nonatomic, assign) QNHealthDataType dataType;

@property(nonatomic, assign) BOOL isToday;
@end

NS_ASSUME_NONNULL_END
