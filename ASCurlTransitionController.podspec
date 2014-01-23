Pod::Spec.new do |s|
  s.name = "ASCurlTransitionController"
  s.version = "0.1"
  s.license = 'MIT'
  s.summary = "Animate your iOS image views to fullscreen on a simple tap."
  s.authors = {
    "Philippe Converset" => "pconverset@autresphere.com"
  }
  s.homepage = "https://github.com/autresphere/ASCurlTransitionController"
  s.source = {
    :git => "https://github.com/autresphere/ASCurlTransitionController.git",
    :tag => "0.1"
  }
  s.platform = :ios, '5.0'
  s.source_files = 'ASCurlTransitionController/*.{h,m}'
  s.frameworks = 'UIKit', 'Foundation'
  s.requires_arc = true
end