//
//  QNErrorCode.h
//  QNDeviceSDKDemo
//
//  Created by Yolanda on 2018/3/31.
//  Copyright © 2018年 Yolanda. All rights reserved.
//

typedef NS_ENUM(NSInteger, QNBleErrorCode) {
    QNBleErrorCodeInvalidateAppId = 1001,
    QNBleErrorCodeNotInitSDK = 1002,
    QNBleErrorCodeFirstDataFileURL = 1003,
    QNBleErrorCodePackageName = 1004,
    QNBleErrorCodeBundleID = 1005,
    QNBleErrorCodeInitFile = 1006,
    
    QNBleErrorCodeBluetoothClosed = 1101,
    QNBleErrorCodeLocationPermission = 1102,
    QNBleErrorCodeBLEError = 1103,
    QNBleErrorCodeConnectWhenConnecting = 1104,
    QNBleErrorCodeConnectWhenConnected = 1105,
    QNBleErrorCodeBluetoothUnknow = 1106,
    QNBleErrorCodeBluetoothResetting = 1107,
    QNBleErrorCodeBluetoothUnsupported = 1108,
    QNBleErrorCodeBluetoothUnauthorized = 1109,
    QNBleErrorCodeConnectFail = 1110,
    QNBleErrorCodePeripheralDisconnecting = 1111,
    QNBleErrorCodeBleNoneScan = 1112,
    QNBleErrorBleConnectOvertime = 1113,

    QNBleErrorCodeIllegalArgument = 1201,
    QNBleErrorCodeMissDiscoveryListener = 1202,
    QNBleErrorCodeMissDataListener = 1203,
    QNBleErrorCodeUserIdEmpty = 1204,
    QNBleErrorCodeUserGender = 1205,
    QNBleErrorCodeUserHeight = 1206,
    QNBleErrorCodeUserBirthday = 1207,
    QNBleErrorCodeUserAthleteType = 1209,
    QNBleErrorCodeUserShapeGoalType = 1210,
    QNBleErrorCodeDeviceType = 1211,
    QNBleErrorCodeWiFiParams = 1212,
    QNBleErrorCodeRegisterDevice = 1213,
    QNBleErrorCodeNoComoleteMeasure = 1214,
    QNBleErrorCodeNoSupportModify = 1215,

    QNBleErrorCoder = 1301,
    QNBleErrorCoderInvalid = 1302,
    
    QNBleErrorCodeResponseOverTime = 1401, //相应超时
    QNBleErrorCodeUnbindBand = 1402, //未绑定手环
    QNBleErrorCodeExerciseModeModify = 1403, //
    QNBleErrorCodeFrimwareFile = 1404, //手环固件异常
    QNBleErrorCodeDfu = 1405, //OTA失败
    QNBleErrorCodeUnconnectedDevice = 1406, //未连接设备
    QNBleErrorCodeUnsupport = 1407, //不支持使用
    QNBleErrorCodeData = 1408, //数据异常
    QNBleErrorCodeEventUnusual = 1409, //事件异常
};
