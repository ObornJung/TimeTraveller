#
#  Be sure to run `pod spec lint MRC.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "MRC"
  s.version      = "0.1.0"
  s.summary      = "A short description of MRC."

  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  s.description  = <<-DESC
                   DESC

  s.homepage     = "http://gitlab.alibaba-inc.com/obornjung.jj/MRC"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"


  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Licensing your code is important. See http://choosealicense.com for more info.
  #  CocoaPods will detect a license file if there is a named LICENSE*
  #  Popular ones are 'MIT', 'BSD' and 'Apache License, Version 2.0'.
  #

  s.license      = { :type => "MIT", :file => "LICENSE" }


  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the authors of the library, with email addresses. Email addresses
  #  of the authors are extracted from the SCM log. E.g. $ git log. CocoaPods also
  #  accepts just a name if you'd rather not provide an email address.
  #
  #  Specify a social_media_url where others can refer to, for example a twitter
  #  profile URL.
  #

  s.author             = { "左盟" => "obornjung.jj@alibaba-inc.com" }
  # Or just: s.author    = "Oborn.Jung"
  # s.authors            = { "Oborn.Jung" => "obornjung.jj@alibaba-inc.com" }
  # s.social_media_url   = "http://twitter.com/Oborn.Jung"

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If this Pod runs only on iOS or OS X, then specify the platform and
  #  the deployment target. You can optionally include the target after the platform.
  #

  s.platform     = :ios, "7.0"

  #  When using multiple platforms
  s.ios.deployment_target = "7.0"
  # s.osx.deployment_target = "10.7"
  # s.watchos.deployment_target = "2.0"
  # s.tvos.deployment_target = "9.0"


  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the location from where the source should be retrieved.
  #  Supports git, hg, bzr, svn and HTTP.
  #

  s.source       = { :git => "http://gitlab.alibaba-inc.com/obornjung.jj/MRC.git", :tag => "0.1.0" }


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  CocoaPods is smart about how it includes source code. For source files
  #  giving a folder will include any swift, h, m, mm, c & cpp files.
  #  For header files it will include any header in the folder.
  #  Not including the public_header_files will make all headers public.
  #

  s.source_files  = "MRC/*.{h,m,mm,c}"
  # s.public_header_files = "MRC/**/*.h"
  # s.exclude_files = "Classes/Exclude"

  s.subspec 'MRCSupport' do |ss|
    ss.source_files = 'MRC/MRCSupport/*.{h,m}'
    ss.public_header_files = 'MRC/MRCSupport/*.h'
  end

  s.subspec 'MRCExtention' do |ss|
    ss.source_files = 'MRC/MRCExtention/*.{h,m}'
    ss.public_header_files = 'MRC/MRCExtention/*.h'
  end

  s.subspec 'MRCContainer' do |ss|
  	ss.source_files = 'MRC/MRCContainer/*.{h,m}'
    ss.public_header_files = 'MRC/MRCContainer/*.h'
    ss.subspec 'Model' do |sss|
    	sss.subspec 'Base' do |ssss|
  			ssss.source_files = 'MRC/MRCContainer/Model/Base/*.{h,m}'
	    	ssss.public_header_files = 'MRC/MRCContainer/Model/Base/*.h'
  		end
	    sss.source_files = 'MRC/MRCContainer/Model/*.{h,m}'
	    sss.public_header_files = 'MRC/MRCContainer/Model/*.h'
  	end
  	ss.subspec 'ViewModel' do |sss|
	    sss.source_files = 'MRC/MRCContainer/ViewModel/*.{h,m}'
	    sss.public_header_files = 'MRC/MRCContainer/ViewModel/*.h'
  	end
  	ss.subspec 'View' do |sss|
	    sss.source_files = 'MRC/MRCContainer/View/*.{h,m}'
	    sss.public_header_files = 'MRC/MRCContainer/View/*.h'
  	end
  	ss.subspec 'ViewController' do |sss|
	    sss.source_files = 'MRC/MRCContainer/ViewController/*.{h,m}'
	    sss.public_header_files = 'MRC/MRCContainer/ViewController/*.h'
  	end
  end

  s.subspec 'MRCTableView' do |ss|
  	ss.source_files = 'MRC/MRCTableView/*.{h,m}'
    ss.public_header_files = 'MRC/MRCTableView/*.h'
    ss.subspec 'Model' do |sss|
	    sss.source_files = 'MRC/MRCTableView/Model/*.{h,m}'
	    sss.public_header_files = 'MRC/MRCTableView/Model/*.h'
  	end
  	ss.subspec 'ViewModel' do |sss|
	    sss.source_files = 'MRC/MRCTableView/ViewModel/*.{h,m}'
	    sss.public_header_files = 'MRC/MRCTableView/ViewModel/*.h'
  	end
  	ss.subspec 'View' do |sss|
	  	sss.subspec 'Base' do |ssss|
  			ssss.source_files = 'MRC/MRCTableView/View/Base/*.{h,m}'
	    	ssss.public_header_files = 'MRC/MRCTableView/View/Base/*.h'
  		end
	    sss.source_files = 'MRC/MRCTableView/View/*.{h,m}'
	    sss.public_header_files = 'MRC/MRCTableView/View/*.h'
  	end
  	ss.subspec 'ViewController' do |sss|
	    sss.source_files = 'MRC/MRCTableView/ViewController/*.{h,m}'
	    sss.public_header_files = 'MRC/MRCTableView/ViewController/*.h'
  	end
  end
  	
  s.subspec 'MRCCollectionView' do |ss|
  	ss.source_files = 'MRC/MRCCollectionView/*.{h,m}'
    ss.public_header_files = 'MRC/MRCCollectionView/*.h'
    ss.subspec 'Model' do |sss|
	    sss.source_files = 'MRC/MRCCollectionView/Model/*.{h,m}'
	    sss.public_header_files = 'MRC/MRCCollectionView/Model/*.h'
  	end
  	ss.subspec 'ViewModel' do |sss|
	    sss.source_files = 'MRC/MRCCollectionView/ViewModel/*.{h,m}'
	    sss.public_header_files = 'MRC/MRCCollectionView/ViewModel/*.h'
  	end
  	ss.subspec 'View' do |sss|
  		sss.subspec 'Base' do |ssss|
  			ssss.source_files = 'MRC/MRCCollectionView/View/Base/*.{h,m}'
	    	ssss.public_header_files = 'MRC/MRCCollectionView/View/Base/*.h'
  		end
	    sss.source_files = 'MRC/MRCCollectionView/View/*.{h,m}'
	    sss.public_header_files = 'MRC/MRCCollectionView/View/*.h'
  	end
  	ss.subspec 'ViewController' do |sss|
	    sss.source_files = 'MRC/MRCCollectionView/ViewController/*.{h,m}'
	    sss.public_header_files = 'MRC/MRCCollectionView/ViewController/*.h'
  	end
  end

  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  A list of resources included with the Pod. These are copied into the
  #  target bundle with a build phase script. Anything else will be cleaned.
  #  You can preserve files from being cleaned, please don't preserve
  #  non-essential files like tests, examples and documentation.
  #

  # s.resource  = "icon.png"
  # s.resources = "Resources/*.png"

  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"


  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Link your library with frameworks, or libraries. Libraries do not include
  #  the lib prefix of their name.
  #

  # s.frameworks = "SomeFramework", "AnotherFramework"
  s.frameworks  = "Foundation", "UIKit"

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"


  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If your library depends on compiler flags you can set them in the xcconfig hash
  #  where they will only apply to your library. If you depend on other Podspecs
  #  you can include multiple dependencies to ensure it works.

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  s.dependency "libextobjc", "~> 0.4"
  s.dependency "Masonry", "~> 1.0.1"
  s.dependency "ReactiveCocoa", "~> 2.1.8"

end
