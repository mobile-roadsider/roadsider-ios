platform :ios, '10.0'

# ignore all warnings from all pods
inhibit_all_warnings!

target :Yaqeen do
    use_frameworks!
    project 'Yaqeen.xcodeproj'
    inherit! :search_paths
    pod 'Firebase/Auth'
    pod 'Fabric'
    pod 'Crashlytics'
    target 'YaqeenTests' do
        inherit! :search_paths
        pod 'Firebase/Auth'
    end
end
