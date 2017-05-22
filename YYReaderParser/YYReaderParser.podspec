Pod::Spec.new do |s|
  s.name     = 'YYReaderParser'
  s.version  = '1.0.0'
  s.license  = 'MIT'
  s.summary  = 'YYReader Parser'
  s.homepage = ''
  s.authors  = { 'butcheryl' => 'butcheryl@126.com' }
  s.source   = { :git => '' }
  s.requires_arc = true
  s.ios.deployment_target = '9.0'

  s.source_files = './**/*.swift'

  # s.dependency ''
  # s.frameworks = 'MobileCoreServices', 'CoreGraphics'
  
end
