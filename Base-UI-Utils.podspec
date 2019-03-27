Pod::Spec.new do |spec|

spec.name         = "Base-UI-Utils"
spec.version      = "0.0.2"
spec.summary      = "方便快速搭建项目"

spec.description  = <<-DESC
基础UI 工具类 方便快速搭建小项目
DESC

spec.homepage     = "https://github.com/Lang-FZ/Base-UI-Utils"

spec.license      = "MIT (Base-UI-Utils)"
spec.author       = { "LangFZ" => "446003664@qq.com" }
spec.platform     = :ios, "9.0"
spec.source       = { :git => "https://github.com/Lang-FZ/Base-UI-Utils.git", :tag => "#{spec.version}" }

spec.source_files = "Base-UI-Utils/{BaseController,Extension,Tools}/*.swift"
spec.requires_arc = true



end
