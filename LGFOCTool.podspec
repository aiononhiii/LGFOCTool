
Pod::Spec.new do |s|

s.name        = "LGFOCTool"
s.version     = "0.0.9"
s.summary     = "LGFOCTool"
s.homepage    = "https://github.com/aiononhiii/LGFOCTool.git"
s.license     = { :type => 'MIT', :file => 'LICENSE' }
s.authors     = { "aiononhiii" => "452354033@qq.com" }

s.requires_arc = true
s.platform     = :ios
s.platform     = :ios, "8.0"
s.source   = { :git => "https://github.com/aiononhiii/LGFOCTool.git", :tag => s.version }
s.framework  = "Foundation", "UIKit", "QuartzCore", "AssetsLibrary", "AVFoundation", "CoreGraphics", "CoreVideo", "CoreMedia", "CoreImage", "CoreLocation"
s.source_files = "LGFOCTool, LGFOCTool/LGFView/LGFPopMenu/*.{h,m}, LGFOCTool/LGFView/LGFCountDownButton/*.{h,m}, LGFOCTool/UIButton+LGFCategory/*.{h,m}, LGFOCTool/UIDevice+LGFCategory/*.{h,m}, LGFOCTool/UIFont+LGFCategory/*.{h,m}, LGFOCTool/UIWindow+LGFCategory/*.{h,m}, LGFOCTool/UIView+LGFCategory/*.{h,m}, LGFOCTool/UIViewController+LGFCategory/*.{h,m}, LGFOCTool/UIImageView+LGFCategory/*.{h,m}, LGFOCTool/UIImage+LGFCategory/*.{h,m}, LGFOCTool/UITextField+LGFCategory/*.{h,m}, LGFOCTool/UITextView+LGFCategory/*.{h,m}, LGFOCTool/UIColor+LGFCategory/*.{h,m}, LGFOCTool/NSDate+LGFCategory/*.{h,m}, LGFOCTool/NSData+LGFCategory/*.{h,m}, LGFOCTool/NSString+LGFCategory/*.{h,m}"
end
