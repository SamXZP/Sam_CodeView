#
# Be sure to run `pod lib lint Sam_CodeView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Sam_CodeView'
  s.version          = '1.0.1'
  s.summary          = '自定义验证码输入框、线条样式'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  TODO: CodeView 是一个可以高度自定义手机验证码输入的控件。
                         DESC

  s.homepage         = 'https://github.com/SamXZP/Sam_CodeView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Sam' => 'gztzxzp@gmail.com' }
  s.source           = { :git => 'https://github.com/SamXZP/Sam_CodeView.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'Sam_CodeView/Classes/**/*'
  
  # s.resource_bundles = {
  #   'Sam_CodeView' => ['Sam_CodeView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
