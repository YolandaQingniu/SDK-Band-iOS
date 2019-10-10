【 1.0.2 】 2019-10-10
1. 增加跑步、步行的运动时间

【 1.0.1 】 2019-09-23
1. 取消OTA升级的j条件限制

【 1.0.0 】 2019-09-19
1. 适配iOS13

【 1.0.0-beta.17 】 2019-09-10
1. 修复未开启蓝牙时，发送指令的错误回调

【 1.0.0-beta.16 】 2019-09-10
1.  增加绑定状态 QNBandBindStatusBeginTouchBind、QNBandBindStatusStopTouchBind
2. 增加中断绑定的方法 cancelBindBand
3. 修复步行、跑步解析错误的缺陷
4. 变更【syncTodayHealthDataWithHealthDataType:callblock:】方法为【syncTodayHealthDataWithHealthDataType:callback:】

【 1.0.0-beta.15 】 2019-09-05
1.  优化手环连接方式

【 1.0.0-beta.14 】 2019-09-04
1.  删除OTA写入数据方法 writeOTAData
2.  删除读取OTA数据状态方法 readOTAStatus
3.  删除OTA数据回复监听反复 receiveOTAData
4. 增加OTA升级方法 startDfu

【 1.0.0-beta.13 】 2019-09-01
1.  修改同步数据时CPU使用率过高的情况

【 1.0.0-beta.12 】 2019-08-28
1.  增加OTA写入数据方法 writeOTAData
2.  增加读取OTA数据状态方法 readOTAStatus
3.  增加OTA数据回复监听反复 receiveOTAData
4.  增加QNExerciseItem类中 minHeartRate 
5.  增加QNExerciseItem类中 aveHeartRate 

【 1.0.0-beta.11 】 2019-08-20
1.  修复运动模式状态返回错误的缺陷

【 1.0.0-beta.10 】 2019-08-19
1.  修复运动模式的切换问题

【 1.0.0-beta.9 】 2019-08-15
1.  实时数据中添加的睡眠时间的属性
2.  修复睡眠时间的问题

【 1.0.0-beta.8 】 2019-08-08
1.  修改取消绑定API
1.  修改获取实时数据API
1.  修改心率数据的时间间隔问题

【 1.0.0-beta.7 】 2019-07-29
1.  修复由于系统配对框问题造成的cpu开销

【 1.0.0-beta.6 】 2019-07-29
1.  修复锻炼模式发送数据的问题

【 1.0.0-beta.5 】 2019-07-27
1. 修复锻炼模式切换缺陷

【 1.0.0-beta.4 】 2019-07-26
1. 手环SDK测试版 
2. 增加心率监听模式方法 syncHeartRateObserverMode 
3. 修改绑定命令方法 bindBand 
4. 修改同步今日数据方法 syncTodayHealthData 
5. 修改同步历史数据方法 syncHistoryHealthData 
6. 增加确认手环修改运动状态方法 confirmBandModifyExerciseStatus 
7. 增加发送运动数据方法 sendExerciseDatas 
8. 增加设置心率提醒方法 setHeartRemind 
9. 增加错误类型 QNBleErrorCodeData QNBleErrorCodeUnbindDevice
