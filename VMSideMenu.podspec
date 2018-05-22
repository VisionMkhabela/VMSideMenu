
Pod::Spec.new do |s|

   s.platform = :ios
   s.ios.deployment_target = '10.7'
   s.name = "VMSideMenu"
   s.summary = "VMSideMenu lets a user select an ice cream flavor."
   s.requires_arc = true

   s.swift_version = "4.0"
   s.version = "1.2.0"

   s.license = { :type => "MIT", :file => "LICENSE" }

   s.author = { "Vision Mkhabela" => "Vision.Mkhabela@gmail.com" }

   s.homepage = "https://github.com/VisionMkhabela/VMSideMenu"

   s.source = { :git => "https://github.com/VisionMkhabela/VMSideMenu.git", :tag => "#{s.version}"}

   s.framework = "UIKit"

   s.source_files = 'VMSideMenu/**/*.{h,m,swift}'
   s.resources = 'VMSideMenu/**/*.{storyboard}'
   s.requires_arc  = false

end




