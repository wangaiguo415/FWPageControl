Pod::Spec.new do |s|
  s.name         = 'FWPageControl'
  s.version      = '1.0.0'
  s.license = 'MIT'
  s.homepage     = 'http://www.fanwenqing.com'
  s.authors      = { '范文青' => '23335465@qq.com'}
  s.summary      = 'a custom page control'

  
  s.platform     =  :ios, '6.0'
  s.source       =  {:git => 'https://github.com/howenis/FWPageControl.git', :tag => '1.0.0'}
  s.source_files = 'FWPageControl/src/**/*.{h,m}'
  s.requires_arc = true

end