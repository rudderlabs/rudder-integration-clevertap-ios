Pod::Spec.new do |s|
  s.name             = 'Rudder-CleverTap'
  s.version          = '1.0.3'
  s.summary          = 'Privacy and Security focused Segment-alternative. CleverTap Native SDK integration support.'

  s.description      = <<-DESC
Rudder is a platform for collecting, storing and routing customer event data to dozens of tools. Rudder is open-source, can run in your cloud environment (AWS, GCP, Azure or even your data-centre) and provides a powerful transformation framework to process your event data on the fly.
                       DESC

  s.homepage         = 'https://github.com/rudderlabs/rudder-integration-clevertap-ios'
  s.license          = { :type => "Apache", :file => "LICENSE" }
  s.author           = { 'RudderStack' => 'venkat@rudderstack.com' }
  s.source           = { :git => 'https://github.com/rudderlabs/rudder-integration-clevertap-ios.git', :tag => 'v1.0.3' }
  s.platform         = :ios, "9.0"

  ## Ref: https://github.com/CocoaPods/CocoaPods/issues/10065
  s.pod_target_xcconfig = {
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64'
  }
  s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }

  s.source_files = 'Rudder-CleverTap/Classes/**/*'

  s.static_framework = true

  s.dependency 'Rudder', '~>1.0'
  s.dependency 'CleverTap-iOS-SDK', '~>3.0'
end
