#
# Be sure to run `pod lib lint BonsaiController.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'BonsaiController'
  s.version          = '4.2.0'
  s.summary          = '🌲 Bonsai makes custom frame size and transition animation to any view controller'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  Add the ability to change custom frame size with cool transition animation to any view controller.
                       DESC

  s.homepage         = 'https://github.com/rishi420/Bonsai'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Warif Akhand Rishi' => 'rishi420@gmail.com' }
  s.source           = { :git => 'https://github.com/rishi420/Bonsai.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  s.swift_version = '4.2'
  
  s.ios.deployment_target = '9.3'

  s.source_files = 'BonsaiController/Classes/**/*'
  
  # s.resource_bundles = {
  #   'BonsaiController' => ['BonsaiController/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
