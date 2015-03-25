#
# Be sure to run `pod lib lint Swizzler.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "Swizzler"
  s.version          = "0.1.0"
  s.summary          = "Swizzling done right"
  s.description      = <<-DESC
                       Swizzling done right:

                       * Swizzling done right
                       * Blocks API
                       * Original implementation on your fingertips
                       DESC
  s.homepage         = "https://github.com/Wondermall/Swizzler"
  s.license          = 'MIT'
  s.author           = { "Sash Zats" => "sash@zats.io" }
  s.source           = { :git => "https://github.com/Wondermall/Swizzler.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/zats'

  s.ios.platform     = '7.0'
  s.osx.platform     = '10.7'
  s.requires_arc = true

  s.source_files = 'Pod/**/*'
end
