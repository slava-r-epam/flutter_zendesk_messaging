#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint ada_chat_flutter.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'ada_chat_flutter'
  s.version          = '0.0.1'
  s.summary          = 'Ada chat flutter plugin'
  s.description      = <<-DESC
Ada chat flutter plugin implementation for Flutter
                       DESC
  s.homepage         = 'http://headspace.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'help@headspace.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'AdaEmbedFramework', '1.8.0'
  s.platform = :ios, '10.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
