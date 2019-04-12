#
# Be sure to run `pod lib lint BubbleBlurView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'BubbleBlurView'
  s.version          = '1.0.1'
  s.summary          = 'An Apple Card like background effect view'
  s.description      = <<-DESC
BubbleBlurView is a UIView that provides an Apple Card style dynamic effect.
                       DESC

  s.homepage         = 'https://github.com/wfltaylor/BubbleBlurView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'William Taylor' => 'wfltaylor@gmail.com' }
  s.source           = { :git => 'https://github.com/wfltaylor/BubbleBlurView.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'
  
  s.swift_version = '5.0'

  s.source_files = 'BubbleBlurView/Classes/**/*'
  
  # s.resource_bundles = {
  #   'BubbleBlurView' => ['BubbleBlurView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
