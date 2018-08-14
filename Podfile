# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'
use_frameworks!

# ignore all warnings from all pods
inhibit_all_warnings!

def app_pods
    
    #Reactive programming
    pod 'RxSwift'
    pod 'RxCocoa'
    pod 'RxDataSources'
    
    #Networking
    pod 'RxAlamofire'
    pod 'Alamofire'

    #Image download - cache
    pod 'Kingfisher'
    
    #Autolayout
    pod 'SnapKit'
    
    #Json <-> object
    pod 'ObjectMapper'
    
    #Activity indicator
    pod 'SVProgressHUD'
    
    #Ayto scroll view when keyboard appeared
    pod 'IQKeyboardManagerSwift'
    
end

target 'TemplateProject' do
  app_pods
end
target 'TemplateProjectDev' do
    app_pods
end
target 'TemplateProjectTests' do
    app_pods
    inherit! :search_paths
end

