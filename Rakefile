# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")

require 'motion/project'

Motion::Project::App.setup do |app|
  
  app.name = 'motion-facbeook'

  app.info_plist['UIMainStoryboardFile'] = 'Storyboard'
  app.info_plist['FacebookAppID'] = '355198514515820'
  app.info_plist['CFBundleURLTypes'] = [
    { 
      'CFBundleURLSchemes' => [
        'fb355198514515820'
      ] 
    }
  ]
  
  app.vendor_project('vendor/FacebookSDK3', :static, :headers_dir => './Headers')
  app.libs += ['/usr/lib/libz.dylib', '/usr/lib/libsqlite3.dylib']

  app.frameworks += [
  	"CoreGraphics",
  	"Accounts",
  	"Foundation",
  	"UIKit",
  	"FBiOSSDK",
  	"FBiOSSDKResources"
  ]
end
