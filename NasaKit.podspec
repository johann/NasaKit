Pod::Spec.new do |s|
 
  # 1
  s.platform = :ios
  s.ios.deployment_target = '8.0'
  s.name = "NasaKit"
  s.summary = "NasaKit lets a user query information from NASA's Near Earth Object Web Service (NEOWS)"
  s.requires_arc = true
  s.version = "0.1.0"
  s.license = { :type => "MIT", :file => "LICENSE" }
  s.author = { "Johann Kerr" => "johannkerr@gmail.com" }
  s.homepage = "https://github.com/johannkerr/NasaKit"
  s.source = { :git => "https://github.com/johannkerr/NasaKit.git", :tag => "#{s.version}"}
  s.framework = "UIKit"
  s.dependency 'Alamofire', '~> 3.4'
  s.dependency 'SwiftyJSON', '>= 2.3'
  s.source_files = "NasaKit/**/*.{swift}"
  #s.resources = "NasaKit/**/*.{png,jpeg,jpg,storyboard,xib}"
end