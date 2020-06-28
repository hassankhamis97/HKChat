
Pod::Spec.new do |spec|
  spec.name         = "HKChat"
  spec.version      = "1.0.0"
  spec.summary      = "This is such a Chat Framework."
  spec.description  = <<-DESC
                    This is a wonderfull Chat Framework. lets try it
                   DESC
  spec.homepage     = "https://github.com/hassankhamis97/HKChat"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "Hassan Khamis" => "hassankhamis97@hotmail.com" }
  spec.platform     = :ios, "12.0"
  spec.source       = { :git => "https://github.com/hassankhamis97/HKChat.git", :tag => "1.0.0" }
  spec.source_files = "HKChat/Source/*.{swift}"
  spec.swift_version = "5.0"

  spec.static_framework = true
  spec.dependency 'Firebase'
  spec.dependency 'Firebase/Auth'
  spec.dependency 'Firebase/Storage'
  spec.dependency 'Firebase/Firestore'
  spec.dependency 'MessageKit'
end
