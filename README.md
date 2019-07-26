# 轻牛手环 SDK 

SDK的运行需要appid以及配置文件，商家在接入时可先使用轻牛提供的测试appid和测试配置文件，正式发布时必须向轻牛官方获取正式appid和配置文件

## 安装方式

### cocoapods安装:
- 先安装Cocoapods；
- 通过 pod repo update 更新QNSDK的cocoapods版本；
- 在Podfile对应的target中，添加`pod 'QNBandSDK'`，并执行pod install；
- 在项目中使用CocoaPods生成的.xcworkspace运行工程；
- 在你的代码文件头引入头文件`#import <QNBandSDK/QNDeviceSDK.h>`


### 手动安装:
- 下载SDK安装包至工程
- 引入SDK路径 【TARGETS】-> 【Build Setting】->【Search Paths】->【LibrarySearch Paths】中添加SDK路径
- 配置链接器 【TARGETS】-> 【Build Setting】-> 【Linking】-> 【Other Linker Flags】中添加 `-ObjC`、`-all_load`、`-force_load [SDK路径]` 其中之一


## 注意事项
- SDK适配8.0及以上系统
- iOS10.0及以上系统必须Info.plist中配置蓝牙的使用数据，否则无法使用系统的蓝牙功能
- 必须为SDK配置链接器，否则SDK无法正常运行
