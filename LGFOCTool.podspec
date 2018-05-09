
Pod::Spec.new do |s|

s.name        = "LGFOCTool"
s.version     = "0.0.1"
s.summary     = "LGFOCTool"
s.homepage    = "https://github.com/aiononhiii/LGFOCTool.git"
s.license     = { :type => 'MIT', :file => 'LICENSE' }
s.authors     = { "aiononhiii" => "452354033@qq.com" }

s.requires_arc = true
s.platform     = :ios
s.platform     = :ios, "8.0"
s.source   = { :git => "https://github.com/aiononhiii/LGFOCTool.git", :tag => s.version }
s.framework  = "SomeFramework", "AnotherFramework"
s.source_files = "LGFOCTool/**/*.{h,m}"
end
