Pod::Spec.new do |spec|

spec.name           = "Base-UI-Utils"
spec.version        = "0.0.10"
spec.summary        = "方便快速搭建项目"

spec.description    = <<-DESC
基础UI 工具类 方便快速搭建小项目
DESC

spec.homepage       = "https://github.com/Lang-FZ/Base-UI-Utils"

spec.license        = "MIT"
spec.author         = { "LangFZ" => "446003664@qq.com" }
spec.platform       = :ios, "9.0"
spec.source         = { :git => "https://github.com/Lang-FZ/Base-UI-Utils.git", :tag => "#{spec.version}" }

spec.requires_arc   = true
spec.swift_version  =  ' 4.2 '
spec.frameworks     = "UIKit"
spec.default_subspec    = "Tools","BaseController","Extension"

spec.subspec 'Tools' do |a|
a.ios.deployment_target = "9.0"
a.source_files  = "Base-UI-Utils/Tools/*.swift"
a.frameworks    = "UIKit","CoreGraphics"
end

spec.subspec 'BaseController' do |a|
a.ios.deployment_target = "9.0"
a.source_files  = "Base-UI-Utils/BaseController/*.swift"
a.dependency "Base-UI-Utils/Tools"
end

spec.subspec 'Extension' do |a|
a.ios.deployment_target = "9.0"
a.source_files = "Base-UI-Utils/Extension/*.swift"
a.dependency "Base-UI-Utils/Tools"
end

end
