//
//  ExerciseModeCell.h
//  QNBandSDKDemo
//
//  Created by donyau on 2019/7/27.
//  Copyright © 2019 Yolanda. All rights reserved.
//

#import <UIKit/UIKit.h>



NS_ASSUME_NONNULL_BEGIN

@protocol ExerciseModeCellDelegate <NSObject>

- (void)exerciseModeCellSelect:(QNExerciseStatus)status;
- (void)exerciseTypeCellSelect:(QNBandExerciseType)type;

@end


@interface ExerciseModeCell : UITableViewCell

@property(nonatomic, weak) id<ExerciseModeCellDelegate> delegate;

@property(nonatomic, assign) QNExerciseStatus status;

@property(nonatomic, assign) QNBandExerciseType type;

@end

NS_ASSUME_NONNULL_END
