
Pod::Spec.new do |spec|
  spec.name         = "HKChat"
  spec.version      = "1.0.0"
  spec.summary      = "This is such a Chat Framework."
  spec.description  = <<-DESC
                    This is a wonderfull Chat Framework. lets try it
                   DESC
  spec.homepage     = "https://github.com/hassankhamis97/HChat"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "Hassan Khamis" => "hassankhamis97@hotmail.com" }
  spec.platform     = :ios, "12.0"
  # spec.source       = { :http => 'file:' + __dir__ + "/" }
  spec.source       = { :git => "https://github.com/hassankhamis97/HChat.git", :tag => "1.0.0" }
  spec.source_files = "HChat/**/*.{swift}"
  spec.swift_version = "5.0"
end
