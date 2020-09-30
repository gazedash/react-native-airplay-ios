package = JSON.parse(File.read(File.join(__dir__, 'package.json')))

Pod::Spec.new do |s|
  s.name         = "RNAirplay"
  s.version        = package['version']
  s.summary        = package['description']
  s.description    = package['summary']
  s.license        = package['license']
  s.author         = package['author']
  s.homepage       = package['repository']['url']
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/author/RNAirplay.git", :tag => package['version'] }
  s.source_files  = "ios/**/*.{h,m,swift}"
  s.requires_arc = true


  s.dependency "React-Core"
  #s.dependency "others"

end

