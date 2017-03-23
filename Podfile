source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'

# ignore all warnings from all pods
inhibit_all_warnings!
use_frameworks!


def all_pods
    pod 'R.swift'
    pod 'Swinject'
    pod 'SwinjectStoryboard'
end

abstract_target 'Base' do
    all_pods
    
    target 'SnapshotTesting' do
    end
    
    target 'SnapshotTestingTests' do
        #inherit! :search_paths
        
        pod 'Quick'
        pod 'Nimble'
        pod 'FBSnapshotTestCase'
    end
end
