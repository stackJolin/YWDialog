#
# Be sure to run `pod lib lint YWDialog.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'YWDialog'
  s.version          = '0.1.1'
  s.summary          = 'YuWaniOS - Alert'

  s.homepage         = 'https://github.com/stackJolin/YWDialog'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '601584870@qq.com' => '601584870@qq.com' }
  s.source           = { :git => 'https://github.com/stackJolin/YWDialog.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'YWDialog/Classes/**/*.{h,m,mm,hpp,cpp,c}'
  
  s.frameworks = 'UIKit','Foundation'
end
