Pod::Spec.new do |s|
  s.name             = 'FlexibleCollectionView'
  s.version          = '1.3.2'
  s.summary          = 'A very flexible collection view.'
  # s.resources        = 'FlexibleCollectionView/Assets/*'
  s.swift_version    = '4.1'
  s.description      = <<-DESC
A very lightweight Core Data framework. You\'ll be able to fetch object in an easier way.
                       DESC

  s.homepage         = 'https://github.com/carlos21/FlexibleCollectionView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Carlos Duclos' => 'darkzeratul64@gmail.com' }
  s.source           = { :git => 'https://github.com/carlos21/FlexibleCollectionView.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'Sources/**/*'
  
  # s.resource_bundles = {
  #  'FlexibleCollectionView' => ['FlexibleCollectionView/Assets/**/*.{storyboard,xib,xcassets,imageset,png,jpg}']
  # }
end
