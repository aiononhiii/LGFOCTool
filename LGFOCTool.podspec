
Pod::Spec.new do |s|

s.name        = "LGFOCTool"
s.version     = "1.2.8"
s.summary     = "LGFOCTool"
s.homepage    = "https://github.com/aiononhiii/LGFOCTool.git"
s.license     = { :type => 'MIT', :file => 'LICENSE' }
s.authors     = { "aiononhiii" => "452354033@qq.com" }

s.requires_arc = true
s.platform     = :ios, "8.0"
s.source   = { :git => "https://github.com/aiononhiii/LGFOCTool.git", :tag => s.version }
s.framework  = "Foundation", "UIKit", "QuartzCore", "AssetsLibrary", "AVFoundation", "CoreGraphics", "CoreVideo", "CoreMedia", "CoreImage", "CoreLocation", "SystemConfiguration", "Photos", "CoreTelephony", "AddressBook", "Contacts", "HealthKit", "EventKit"
s.source_files = 'LGFOCTool/**/*.{h,m}'
s.resource_bundles = {
  'LGFOCTool' => ['LGFOCTool/**/**/*.{xib,storyboard}']
}
s.dependency 'AFNetworking'
s.dependency 'MJRefresh'
s.dependency 'LGFTransition'
s.dependency 'LGFPageTitle'
s.dependency 'SDWebImage', '4.4.1'
s.dependency 'FLAnimatedImage', '~> 1.0'

s.user_target_xcconfig = { 'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES' }
end
