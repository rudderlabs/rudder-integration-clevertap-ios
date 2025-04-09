require 'json'

package = JSON.parse(File.read(File.join(__dir__, 'package.json')))

clevertap_sdk_version = '~> 7.1.1'
rudder_sdk_version = '~> 1.31'

Pod::Spec.new do |s|
  s.name             = 'Rudder-CleverTap'
  s.version          = package['version']
  s.summary          = 'Privacy and Security focused Segment-alternative. CleverTap Native SDK integration support.'

  s.description      = <<-DESC
Rudder is a platform for collecting, storing and routing customer event data to dozens of tools. Rudder is open-source, can run in your cloud environment (AWS, GCP, Azure or even your data-centre) and provides a powerful transformation framework to process your event data on the fly.
                       DESC

  s.homepage         = 'https://github.com/rudderlabs/rudder-integration-clevertap-ios'
  s.license          = { :type => "ELv2", :file => "LICENSE.md" }
  s.author           = { 'RudderStack' => 'arnab@rudderstack.com' }
  s.source           = { :git => 'https://github.com/rudderlabs/rudder-integration-clevertap-ios.git', :tag => "v#{s.version}" }
  
  s.ios.deployment_target = '9.0'

  s.source_files = 'Rudder-CleverTap/Classes/**/*'

  if defined?($CleverTapSDKVersion)
      Pod::UI.puts "#{s.name}: Using user specified Clevertap SDK version '#{$CleverTapSDKVersion}'"
      clevertap_sdk_version = $CleverTapSDKVersion
  else
      Pod::UI.puts "#{s.name}: Using default Clevertap SDK version '#{clevertap_sdk_version}'"
  end
  
  if defined?($RudderSDKVersion)
      Pod::UI.puts "#{s.name}: Using user specified Rudder SDK version '#{$RudderSDKVersion}'"
      rudder_sdk_version = $RudderSDKVersion
  else
      Pod::UI.puts "#{s.name}: Using default Rudder SDK version '#{rudder_sdk_version}'"
  end
  
  s.dependency 'Rudder', rudder_sdk_version
  s.dependency 'CleverTap-iOS-SDK', clevertap_sdk_version
end
