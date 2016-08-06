Pod::Spec.new do |s|
  s.name         = "CustomKeyboardTextField"
  s.version      = "0.1"
  s.summary      = "Provides easy way to make TextField with custom keyboards."

  s.description  = <<-DESC
CustomKeyboardTextField provides easy way to make TextField with custom keyboards.
 type-safed with Swift feature.
                   DESC

  s.homepage     = "https://github.com/giginet/CustomKeyboardTextField"
  s.screenshots  = "https://raw.githubusercontent.com/giginet/CustomKeyboardTextField/master/Documentation/Image/demo.gif"
  s.license      = { :type => "MIT", :file => "LICENSE.md" }

  s.author             = { "giginet" => "giginet.net@gmail.com" }
  s.social_media_url   = "http://twitter.com/giginet"
  s.platform     = :ios
  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/giginet/CustomKeyboardTextField.git", :tag => "#{s.version}" }

  s.source_files  = "Sources", "Sources/**/*.{h,swift}"

  s.public_header_files = "Sources/**/*.h"

  s.requires_arc = true
end
