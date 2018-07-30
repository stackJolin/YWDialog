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
  s.source           = { :git => 'https://github.com/601584870@qq.com/YWDialog.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'YWDialog/Classes/**/*'
  
  # s.resource_bundles = {
  #   'YWDialog' => ['YWDialog/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
