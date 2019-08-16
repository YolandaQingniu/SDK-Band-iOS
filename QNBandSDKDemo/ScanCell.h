//
//  ScanCell.h
//  QNBandSDKDemo
//
//  Created by Yolanda on 2019/7/26.
//  Copyright © 2019 Yolanda. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ScanCell : UITableViewCell

@property(nonatomic, strong) QNBleDevice *device;

@end

NS_ASSUME_NONNULL_END
