#
#  Be sure to run `pod spec lint EXLaunchAdvert.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  spec.name         = "EXLaunchAdvert"
  spec.version      = "0.0.1"
  spec.summary      = "开屏广告."
  spec.description  = <<-DESC
			APP启动时显示开屏广告的库
                   DESC

  spec.homepage     = "https://github.com/MiaoShichang/EXLaunchAdvert"
  spec.license      = "MIT"
  spec.author             = { "MiaoShichang" => "miaoshichang@126.com" }
  spec.platform     = :ios
  spec.source       = { :git => "https://github.com/MiaoShichang/EXLaunchAdvert.git", :tag => "#{spec.version}" }
  spec.source_files  = "EXLaunchAdvert", "EXLaunchAdvert/**/*.{h,m}"


end
