
Pod::Spec.new do |s|
  s.name         = 'TXRouter'
  s.version      = '1.0.0'
  s.summary      = '轻量级组件化管理工具,让你轻轻松松添加自己的小组件.该工具原理简单、制作轻松、思路清晰等优点.'
  s.description  = <<-DESC
			轻量级组件化管理工具,让你轻轻松松添加自己的小组件.该工具原理简单、制作轻松、思路清晰等优点.
                   DESC
  s.homepage     = 'https://github.com/xtzPioneer/TXRouter'
  s.license      = 'MIT'
  s.author       = { 'zhangxiong' => 'xtz_pioneer@163.com' }
  s.platform     = :ios, '8.0'
  s.source       = { :git => 'https://github.com/xtzPioneer/TXRouter.git', :tag => s.version.to_s }
  s.source_files = 'TXRouter/**/*.{h,m}'
  s.requires_arc = true  
end