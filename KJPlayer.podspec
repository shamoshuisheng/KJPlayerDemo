Pod::Spec.new do |s|
  s.name         = "KJPlayer"
  s.version      = "2.1.1"
  s.summary      = "KJPlayer play and cache, AVPlayer / MIDIPlayer / IJKPlayer"
  s.homepage     = "https://github.com/yangKJ/KJPlayerDemo"
  s.description  = 'https://github.com/yangKJ/KJPlayerDemo/blob/master/README.md'
  s.license      = "MIT"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.license      = "Copyright (c) 2019 yangkejun"
  s.author       = { "77" => "ykj310@126.com" }
  s.platform     = :ios
  s.source       = { :git => "https://github.com/yangKJ/KJPlayerDemo.git", :tag => "#{s.version}" }
  s.social_media_url = 'https://www.jianshu.com/u/c84c00476ab6'
  s.requires_arc = true
  s.ios.deployment_target = '9.0'

  s.default_subspec  = 'Common'
  s.ios.source_files = 'KJPlayerDemo/KJPlayerHeader.h' 

  s.subspec 'Common' do |c|
    c.source_files = "KJPlayerDemo/Core/*","KJPlayerDemo/View/*"
    c.resources = "KJPlayerDemo/Core/*.{xcdatamodeld}"
    c.frameworks = 'Foundation','UIKit','AVFoundation','MobileCoreServices'
  end

  s.subspec 'AVPlayer' do |av|
    av.source_files = "KJPlayerDemo/KJAVPlayer/*"
    av.dependency 'KJPlayer/Common'
  end
  
  s.subspec 'MIDI' do |md|
    md.source_files = "KJPlayerDemo/KJMidiPlayer/*"
    md.resources = "KJPlayerDemo/KJMidiPlayer/*.{bundle}"
    md.dependency 'KJPlayer/Common'
  end
  
  s.subspec 'IJKPlayer' do |ijk|
    ijk.source_files = "KJPlayerDemo/KJIJKPlayer/*"
    ijk.dependency 'KJPlayer/Common'
    ijk.dependency 'IJKMediaFramework'
    ijk.frameworks = 'MediaPlayer','QuartzCore','CoreGraphics','AudioToolbox','VideoToolbox','CoreVideo','libz','libbz2'
  end

  s.subspec 'KJPlayerView' do |a|
    a.source_files = "KJPlayerDemo/KJPlayerView/*"
    a.resources = "KJPlayerDemo/KJPlayerView/*.{bundle}"
    a.frameworks = 'QuartzCore','Accelerate','CoreGraphics'
    a.dependency 'KJPlayer/Common'
  end
  
end


