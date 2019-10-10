#
# Be sure to run `pod lib lint QNDeviceSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
s.name             = 'QNBandSDK'
s.version          = '1.0.2'
s.summary          = '轻牛手环SDK'

s.description      = '支持轻牛新版手环'

s.homepage         = 'https://github.com/YolandaQingniu/SDK-Band-iOS'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'service@qnniu.com' => 'service@qnniu.com' }
s.source           = { :git => 'https://github.com/YolandaQingniu/SDK-Band-iOS.git', :tag => s.version.to_s }

s.ios.deployment_target = '8.0'

s.source_files = 'QNBandSDK/**/*'
s.vendored_libraries = 'QNBandSDK/libQNDeviceSDK.a'
s.public_header_files= 'QNBandSDK/**/*.h'
s.static_framework = true
s.frameworks = 'CoreBluetooth'
s.xcconfig = {'BITCODE_GENERATION_MODE' => 'bitcode'}

end
