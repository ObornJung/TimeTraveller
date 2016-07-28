
Pod::Spec.new do |s|

  s.name         = "MRC"
  s.version      = "0.1.0.1"
  s.summary      = "MRC."

  s.description      = <<-DESC
     TODO: MRC project.
                       DESC

  s.homepage     = "http://gitlab.alibaba-inc.com/obornjung.jj/MRC"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "左盟" => "obornjung.jj@alibaba-inc.com" }
  s.authors            = { "Oborn.Jung" => "obornjung.jj@alibaba-inc.com" }
  
  s.platform     = :ios, "7.0"
  s.source       = { :git => "git@gitlab.alibaba-inc.com:obornjung.jj/MRC.git", :tag => s.version }

  s.source_files  = "MRC/**/*"
  

s.subspec 'MRCUserDefine' do |ss|
    ss.source_files = 'MRC/MRCUserDefine/**/*'
     
  end


  s.subspec 'MRCSupport' do |ss|
    ss.dependency 'MRC/MRCUserDefine'
    ss.source_files = 'MRC/MRCSupport/**/*'
    ss.public_header_files = 'MRC/MRCSupport/*.h'
  end

  s.subspec 'MRCExtention' do |ss|
    ss.source_files = 'MRC/MRCExtention/**/*'
    ss.public_header_files = 'MRC/MRCExtention/*.h'
  end

  s.subspec 'MRCContainer' do |ss|
  	ss.source_files = 'MRC/MRCContainer/**/*'
    ss.dependency 'MRC/MRCUserDefine'
    ss.dependency 'MRC/MRCSupport'
    ss.dependency 'MRC/MRCExtention'
    #ss.public_header_files = 'MRC/MRCContainer/*.h'
    #ss.subspec 'Model' do |sss|
    	#sss.subspec 'Base' do |ssss|
  			#ssss.source_files = 'MRC/MRCContainer/Model/Base/*.{h,m}'
	    	#ssss.public_header_files = 'MRC/MRCContainer/Model/Base/*.h'
  		#end
	    #sss.source_files = 'MRC/MRCContainer/Model/*.{h,m}'
	   # sss.public_header_files = 'MRC/MRCContainer/Model/*.h'
  	#end
  	#ss.subspec 'ViewModel' do |sss|
	    #sss.source_files = 'MRC/MRCContainer/ViewModel/*.{h,m}'
	    #sss.public_header_files = 'MRC/MRCContainer/ViewModel/*.h'
  	#end
  	#ss.subspec 'View' do |sss|
	   # sss.source_files = 'MRC/MRCContainer/View/*.{h,m}'
	    #sss.public_header_files = 'MRC/MRCContainer/View/*.h'
  	#end
  	#ss.subspec 'ViewController' do |sss|
	   # sss.source_files = 'MRC/MRCContainer/ViewController/*.{h,m}'
	    #sss.public_header_files = 'MRC/MRCContainer/ViewController/*.h'
  	#end
  end

  s.subspec 'MRCTableView' do |ss|
  	ss.source_files = 'MRC/MRCTableView/**/*'
    ss.dependency 'MRC/MRCUserDefine'  
    ss.dependency 'MRC/MRCContainer'
    ss.dependency 'MRC/MRCSupport'
    ss.dependency 'MRC/MRCExtention'
    #ss.public_header_files = 'MRC/MRCTableView/*.h'
    #ss.subspec 'Model' do |sss|
	    #sss.source_files = 'MRC/MRCTableView/Model/*.{h,m}'
	    #sss.public_header_files = 'MRC/MRCTableView/Model/*.h'
  	#end
  	#ss.subspec 'ViewModel' do |sss|
	    #sss.source_files = 'MRC/MRCTableView/ViewModel/*.{h,m}'
	    #sss.public_header_files = 'MRC/MRCTableView/ViewModel/*.h'
  	#end
  	#ss.subspec 'View' do |sss|
	  	#sss.subspec 'Base' do |ssss|
  			#ssss.source_files = 'MRC/MRCTableView/View/Base/*.{h,m}'
	    	#ssss.public_header_files = 'MRC/MRCTableView/View/Base/*.h'
  		#end
	    #sss.source_files = 'MRC/MRCTableView/View/*.{h,m}'
	    #sss.public_header_files = 'MRC/MRCTableView/View/*.h'
  	#end
  	#ss.subspec 'ViewController' do |sss|
	    #sss.source_files = 'MRC/MRCTableView/ViewController/*.{h,m}'
	    #sss.public_header_files = 'MRC/MRCTableView/ViewController/*.h'
  	#end
  end
  	
  s.subspec 'MRCCollectionView' do |ss|
  	ss.source_files = 'MRC/MRCCollectionView/**/*'
    ss.dependency 'MRC/MRCUserDefine'
    ss.dependency 'MRC/MRCContainer'
    ss.dependency 'MRC/MRCSupport'
    ss.dependency 'MRC/MRCExtention'
    #ss.public_header_files = 'MRC/MRCCollectionView/*.h'
    #ss.subspec 'Model' do |sss|
	    #sss.source_files = 'MRC/MRCCollectionView/Model/*.{h,m}'
	    #sss.public_header_files = 'MRC/MRCCollectionView/Model/*.h'
  	#end
  	#ss.subspec 'ViewModel' do |sss|
	    #sss.source_files = 'MRC/MRCCollectionView/ViewModel/*.{h,m}'
	    #sss.public_header_files = 'MRC/MRCCollectionView/ViewModel/*.h'
  	#end
  	#ss.subspec 'View' do |sss|
  		#sss.subspec 'Base' do |ssss|
  			#ssss.source_files = 'MRC/MRCCollectionView/View/Base/*.{h,m}'
	    	#ssss.public_header_files = 'MRC/MRCCollectionView/View/Base/*.h'
  		#end
	    #sss.source_files = 'MRC/MRCCollectionView/View/*.{h,m}'
	    #sss.public_header_files = 'MRC/MRCCollectionView/View/*.h'
  	#end
  	#ss.subspec 'ViewController' do |sss|
	    #sss.source_files = 'MRC/MRCCollectionView/ViewController/*.{h,m}'
	    #sss.public_header_files = 'MRC/MRCCollectionView/ViewController/*.h'
  	#end
  end

   
  s.frameworks  = "Foundation", "UIKit"


  s.requires_arc = true

  s.dependency "libextobjc", "~> 0.4"
  s.dependency "Masonry", "~> 1.0.1"
  s.dependency "ReactiveCocoa", "~> 2.1.8"

end
