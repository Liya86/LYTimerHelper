#
#  Be sure to run `pod spec lint LYTimerHelper.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "LYTimerHelper"
  s.version      = "1.0.1"
  s.summary      = "定时简易封装"

  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  s.description  = <<-DESC
                     定时简易封装 ^-^
                   DESC

  s.homepage     = "https://github.com/Liya86/LYTimerHelper"
  s.license      = { :type => 'MIT', :text => <<-LICENSE
                   Copyright 2018
                   Permission is granted to...
                 LICENSE
               }
  s.author       = "Liya86"
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/Liya86/LYTimerHelper.git", :tag => "1.0.1" }
  s.source_files = "Source/**/*.{h,m}"
  s.frameworks   = "Foundation", "UIKit"
  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"

end
