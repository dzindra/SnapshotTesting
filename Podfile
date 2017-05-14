source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'

# ignore all warnings from all pods
inhibit_all_warnings!
use_frameworks!


target 'SnapshotTesting' do
    pod 'R.swift'
    pod 'Swinject'
    pod 'SwinjectStoryboard'
    
    target 'SnapshotTestingTests' do
        inherit! :search_paths
        
        pod 'FBSnapshotTestCase'
    end
end
